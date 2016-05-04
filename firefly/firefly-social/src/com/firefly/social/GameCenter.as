package com.firefly.social
{
	import com.firefly.core.async.Completer;
	import com.firefly.core.async.Future;
	import com.firefly.core.utils.SingletonLocator;
	import com.firefly.social.consts.ErrorCode;
	import com.firefly.social.response.GameCenterResponse;
	import com.milkmangames.nativeextensions.GPGScore;
	import com.milkmangames.nativeextensions.GPGTimeSpan;
	import com.milkmangames.nativeextensions.GoogleGames;
	import com.milkmangames.nativeextensions.events.GoogleGamesEvent;

	/** This manager requires Milkman Google Services and Google Games Native Extension for Adobe AIR.
	 *  To compile code you need to buy .ane and place it into "external" library folder.
	 *  @see hhttps://www.milkmanplugins.com/google-play-games-air-ane
	 */
	public class GameCenter
	{
		private var _initialized:Boolean;
		private var _googleGamesEnabled:Boolean;
		private var _leaderboardId:String;
		private var _signInCompleter:Completer;
		private var _signOutCompleter:Completer;
		private var _saveScoreCompleter:Completer;
		private var _loadUserScoreCompleter:Completer;
		
		/** Constructor. */		
		public function GameCenter()
		{
			SingletonLocator.register(this, GameCenter);
		}
		
		/** Instance of GameCenter class. */		
		public static function get instance():GameCenter { return SingletonLocator.getInstance(GameCenter); }
		
		public function get initialized():Boolean { return _initialized; }
		public function get authenticated():Boolean { return _initialized && GoogleGames.games.isSignedIn(); }
		
		public function init(leaderboardId:String="", useOnlyGoogleServices:Boolean=false):void
		{	
			_leaderboardId = leaderboardId;
			
			if (GoogleGames.isSupported())
			{
				GoogleGames.create();
				GoogleGames.games.addEventListener(GoogleGamesEvent.SIGN_IN_SUCCEEDED, onSignedIn);
				GoogleGames.games.addEventListener(GoogleGamesEvent.SIGN_IN_FAILED, onSignInFailed);
				GoogleGames.games.addEventListener(GoogleGamesEvent.SIGNED_OUT, onSignedOut);
				GoogleGames.games.addEventListener(GoogleGamesEvent.SUBMIT_SCORE_SUCCEEDED, onScoreSubmitted);
				GoogleGames.games.addEventListener(GoogleGamesEvent.SUBMIT_SCORE_FAILED, onScoreSubmitFailed);
				GoogleGames.games.addEventListener(GoogleGamesEvent.LOAD_SCORES_SUCCEEDED, onUserScoreLoaded);
				GoogleGames.games.addEventListener(GoogleGamesEvent.LOAD_SCORES_FAILED, onUserScoreLoadFailed);
				
				_initialized = true;
			}
		}
		
		public function signIn():Future
		{
			_signInCompleter = new Completer();
			if (_initialized)
				GoogleGames.games.signIn();
			return _signInCompleter.future;
		}
		
		public function signOut():Future
		{
			_signOutCompleter = new Completer();
			if (_initialized)
				GoogleGames.games.signOut();
			return _signOutCompleter.future;
		}
		
		public function showLeaderboard():void
		{
			if (authenticated)
				GoogleGames.games.showLeaderboard(_leaderboardId);
		}
		
		public function showLeaderboardById(id:String):void
		{
			if (authenticated)
				GoogleGames.games.showLeaderboard(id);
		}
		
		public function saveScore(score:int):Future
		{
			_saveScoreCompleter = new Completer();
			if (authenticated)
				GoogleGames.games.submitScore(_leaderboardId, score);
			return _saveScoreCompleter.future;
		}
		
		public function loadPlayerScore():Future
		{
			_loadUserScoreCompleter = new Completer();
				if (authenticated)
					GoogleGames.games.loadScores(_leaderboardId, GPGTimeSpan.ALL_TIME);
			return _loadUserScoreCompleter.future;
		}
		
		public function saveScoreByLeaderboardId(id:String, score:int):Future
		{
			_saveScoreCompleter = new Completer();
			if (authenticated)
				GoogleGames.games.submitScore(id, score);
			return _saveScoreCompleter.future;
		}
		
		protected function onSignedIn(event:GoogleGamesEvent):void
		{
			if (_signInCompleter)
				_signInCompleter.complete(new GameCenterResponse(GameCenterResponse.REQUEST_RESPONSE));
		}
		
		protected function onSignInFailed(event:GoogleGamesEvent):void
		{
			if (_signInCompleter)
				_signInCompleter.fail(new GameCenterResponse(GameCenterResponse.REQUEST_FAILED, null, ErrorCode.SIGN_IN_FAILED, event.failureReason));
		}
		
		protected function onSignedOut(event:GoogleGamesEvent):void
		{
			if (_signOutCompleter)
				_signOutCompleter.complete(new GameCenterResponse(GameCenterResponse.REQUEST_RESPONSE));
		}
		
		protected function onScoreSubmitted(event:GoogleGamesEvent):void
		{
			if (_saveScoreCompleter)
				_saveScoreCompleter.complete(new GameCenterResponse(GameCenterResponse.REQUEST_RESPONSE));
		}
		
		protected function onScoreSubmitFailed(event:GoogleGamesEvent):void
		{
			if (_saveScoreCompleter)
				_saveScoreCompleter.fail(new GameCenterResponse(GameCenterResponse.REQUEST_FAILED, null, ErrorCode.SCORE_NOT_SAVED, event.failureReason));
		}
		
		protected function onUserScoreLoaded(event:GoogleGamesEvent):void
		{
			var playerScore:int = 0;
			var playerId:String = GoogleGames.games.getCurrentPlayerId();
			for each(var score:GPGScore in event.scores)
			{
				if (playerId == score.playerId)
				{
					playerScore = score.score;
					break;
				}
			}
			
			if (_loadUserScoreCompleter)
				_loadUserScoreCompleter.complete(new GameCenterResponse(GameCenterResponse.REQUEST_FAILED, playerScore));
		}
		
		protected function onUserScoreLoadFailed(event:GoogleGamesEvent):void
		{
			if (_loadUserScoreCompleter)
				_loadUserScoreCompleter.fail(new GameCenterResponse(GameCenterResponse.REQUEST_FAILED, null, ErrorCode.SCORE_NOT_LOADED, event.failureReason));
		}
	}
}