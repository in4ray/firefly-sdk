// =================================================================================================
//
//	Firefly Framework
//	Copyright 2016 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.social
{
	import com.firefly.core.async.Completer;
	import com.firefly.core.async.Future;
	import com.firefly.core.utils.SingletonLocator;
	import com.firefly.social.consts.ErrorCode;
	import com.firefly.social.response.SocialReponse;
	import com.milkmangames.nativeextensions.GPGScore;
	import com.milkmangames.nativeextensions.GPGTimeSpan;
	import com.milkmangames.nativeextensions.GoogleGames;
	import com.milkmangames.nativeextensions.events.GoogleGamesEvent;

	/** This manager requires Milkman Google Services and Google Games Native Extension for Adobe AIR.
	 *  To compile code you need to buy .ane and place it into "external" library folder.
	 *  @see hhttps://www.milkmanplugins.com/google-play-games-air-ane */
	public class GameCenter
	{
		/** @private */
		private var _initialized:Boolean;
		/** @private */
		private var _googleGamesEnabled:Boolean;
		/** @private */
		private var _leaderboardId:String;
		/** @private */
		private var _signInCompleter:Completer;
		/** @private */
		private var _signOutCompleter:Completer;
		/** @private */
		private var _saveScoreCompleter:Completer;
		/** @private */
		private var _loadUserScoreCompleter:Completer;
		
		/** Constructor. */		
		public function GameCenter()
		{
			SingletonLocator.register(this, GameCenter);
		}
		
		/** Instance of GameCenter class. */		
		public static function get instance():GameCenter { return SingletonLocator.getInstance(GameCenter); }
		
		/** Defines initialization state. */		
		public function get initialized():Boolean { return _initialized; }
		/** Defines user authentication state. */
		public function get authenticated():Boolean { return _initialized && GoogleGames.games.isSignedIn(); }
		
		/** Initialize Game Center manager.
		 *  @param leaderboardId Leaderboard id. */		
		public function init(leaderboardId:String=""):void
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
		
		/** Invoke Game Center sign in process.
		 *  @return Future object to get complition or error of sign in process. */		
		public function signIn():Future
		{
			_signInCompleter = new Completer();
			if (_initialized)
				GoogleGames.games.signIn();
			return _signInCompleter.future;
		}
		
		/** Invoke Game Center sign out process.
		 *  @return Future object to get complition or error of sign out process. */		
		public function signOut():Future
		{
			_signOutCompleter = new Completer();
			if (_initialized)
				GoogleGames.games.signOut();
			return _signOutCompleter.future;
		}
		
		/** Show leaderboard. */	
		public function showLeaderboard():void
		{
			if (authenticated)
				GoogleGames.games.showLeaderboard(_leaderboardId);
		}
		
		/** Show leaderboard by id.
		 *  @param id Leaderboard id. */		
		public function showLeaderboardById(id:String):void
		{
			if (authenticated)
				GoogleGames.games.showLeaderboard(id);
		}
		
		/** Save user score.
		 *  @param score Score value.
		 *  @return Future object to get complition or error of score saving process. */
		public function saveScore(score:int):Future
		{
			_saveScoreCompleter = new Completer();
			if (authenticated)
				GoogleGames.games.submitScore(_leaderboardId, score);
			return _saveScoreCompleter.future;
		}
		
		/** Load user score.
		 *  @return Future object to get complition or error of player score loading. */
		public function loadUserScore():Future
		{
			_loadUserScoreCompleter = new Completer();
				if (authenticated)
					GoogleGames.games.loadScores(_leaderboardId, GPGTimeSpan.ALL_TIME);
			return _loadUserScoreCompleter.future;
		}
		
		/** Save user score by leaderboard id.
		 *  @param id Leaderboard id.
		 *  @param score Score value.
		 *  @return Future object to get complition or error of score saving process. */
		public function saveScoreByLeaderboardId(id:String, score:int):Future
		{
			_saveScoreCompleter = new Completer();
			if (authenticated)
				GoogleGames.games.submitScore(id, score);
			return _saveScoreCompleter.future;
		}
		
		/** @private */		
		private function onSignedIn(event:GoogleGamesEvent):void
		{
			if (_signInCompleter)
				_signInCompleter.complete(new SocialReponse(SocialReponse.REQUEST_RESPONSE));
		}
		
		/** @private */		
		private function onSignInFailed(event:GoogleGamesEvent):void
		{
			if (_signInCompleter)
				_signInCompleter.fail(new SocialReponse(SocialReponse.REQUEST_FAILURE, null, ErrorCode.SIGN_IN_FAILED, event.failureReason));
		}
		
		/** @private */		
		private function onSignedOut(event:GoogleGamesEvent):void
		{
			if (_signOutCompleter)
				_signOutCompleter.complete(new SocialReponse(SocialReponse.REQUEST_RESPONSE));
		}
		
		/** @private */		
		private function onScoreSubmitted(event:GoogleGamesEvent):void
		{
			if (_saveScoreCompleter)
				_saveScoreCompleter.complete(new SocialReponse(SocialReponse.REQUEST_RESPONSE));
		}
		
		/** @private */		
		private function onScoreSubmitFailed(event:GoogleGamesEvent):void
		{
			if (_saveScoreCompleter)
				_saveScoreCompleter.fail(new SocialReponse(SocialReponse.REQUEST_FAILURE, null, ErrorCode.SCORE_NOT_SAVED, event.failureReason));
		}
		
		/** @private */		
		private function onUserScoreLoaded(event:GoogleGamesEvent):void
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
				_loadUserScoreCompleter.complete(new SocialReponse(SocialReponse.REQUEST_FAILURE, playerScore));
		}
		
		/** @private */		
		private function onUserScoreLoadFailed(event:GoogleGamesEvent):void
		{
			if (_loadUserScoreCompleter)
				_loadUserScoreCompleter.fail(new SocialReponse(SocialReponse.REQUEST_FAILURE, null, ErrorCode.SCORE_NOT_LOADED, event.failureReason));
		}
	}
}