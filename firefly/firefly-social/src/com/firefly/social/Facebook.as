package com.firefly.social
{
	import com.firefly.core.async.Completer;
	import com.firefly.core.async.Future;
	import com.firefly.core.async.GroupCompleter;
	import com.firefly.core.utils.SingletonLocator;
	import com.firefly.social.consts.ErrorCode;
	import com.firefly.social.helpers.FacebookImageOptions;
	import com.firefly.social.helpers.FacebookLeaderboardItem;
	import com.firefly.social.helpers.FacebookUserPictureLoader;
	import com.firefly.social.response.FacebookReponse;
	import com.milkmangames.nativeextensions.GVHttpMethod;
	import com.milkmangames.nativeextensions.GoViral;
	import com.milkmangames.nativeextensions.events.GVFacebookEvent;
	
	import flash.geom.Point;
	
	import starling.events.EventDispatcher;
	
	/** This manager requires Milkman GoViral Native Extension for Adobe AIR.
	 *  To compile code you need to buy .ane and place it into "external" library folder.
	 *  @see https://www.milkmanplugins.com/goviral-facebook-and-sharing-air-ane
	 */
	public class Facebook extends EventDispatcher
	{
		private const CONNECTION_FAILURE:String = "9001";
		
		private var _initialized:Boolean;
		private var _appId:String;
		private var _profilePictureSize:Point;
		private var _signInCompleter:Completer;
		private var _signOutCompleter:Completer;
		
		public function Facebook()
		{
			SingletonLocator.register(this, Facebook);
		}
		
		public static function get instance():Facebook { return SingletonLocator.getInstance(Facebook); }
		
		public function get initialized():Boolean { return _initialized; }
		public function get authenticated():Boolean { return _initialized && GoViral.goViral.isFacebookAuthenticated() }
		
		public function init(appId:String, profilePictureSize:Point):void
		{
			_appId = appId;
			_profilePictureSize = profilePictureSize;
			
			if (GoViral.isSupported())
			{
				GoViral.create();
				
				if(GoViral.goViral.isFacebookSupported())
				{
					GoViral.goViral.initFacebook(_appId);
					GoViral.goViral.addEventListener(GVFacebookEvent.FB_LOGGED_IN, onSignedIn); 
					GoViral.goViral.addEventListener(GVFacebookEvent.FB_LOGGED_OUT, onSignedOut); 
					GoViral.goViral.addEventListener(GVFacebookEvent.FB_LOGIN_CANCELED, onSignInCanceled); 
					GoViral.goViral.addEventListener(GVFacebookEvent.FB_LOGIN_FAILED, onSignInFailed);
					
					_initialized = true;
				}
			}
		}
		
		public function signIn(readPermissions:String):Future
		{
			_signInCompleter = new Completer();
			if (_initialized)
			{
				try
				{
					GoViral.goViral.authenticateWithFacebook(readPermissions);
				} 
				catch(error:Error) 
				{
					_signInCompleter.fail(new FacebookReponse(FacebookReponse.REQUEST_FAILED, null, ErrorCode.SIGN_IN_FAILED));
				}
			}
			return _signInCompleter.future;
		}
		
		public function signOut():Future
		{
			_signOutCompleter = new Completer();
			if (_initialized)
				GoViral.goViral.logoutFacebook();
			return _signOutCompleter.future;
		}
		
		public function loadLeaderboard():Future
		{
			var completer:Completer = new Completer();
			if (authenticated)
			{
				GoViral.goViral.facebookGraphRequest(_appId+"/scores").addRequestListener(function(event:GVFacebookEvent):void {
					if (event.type == GVFacebookEvent.FB_REQUEST_RESPONSE)
					{
						var groupCompleter:GroupCompleter = new GroupCompleter();
						var leaderboardItems:Vector.<FacebookLeaderboardItem> = new Vector.<FacebookLeaderboardItem>();
						for each (var item:Object in event.data.data)
						{
							var leaderboardItem:FacebookLeaderboardItem = new FacebookLeaderboardItem(item.user.name, item.score);
							var options:FacebookImageOptions = new FacebookImageOptions(item.user.id, _profilePictureSize.x, _profilePictureSize.y);
							var picLoader:FacebookUserPictureLoader = new FacebookUserPictureLoader(instance, leaderboardItem, options);
							leaderboardItems.push(leaderboardItem);
							groupCompleter.append(picLoader.load());
						}
						groupCompleter.future.then(function():void
						{
							completer.complete(new FacebookReponse(FacebookReponse.REQUEST_RESPONSE, leaderboardItems))
						});
					}
					else
					{
						completer.fail(new FacebookReponse(FacebookReponse.REQUEST_FAILED, null, ErrorCode.LEADERBOARD_NOT_LOADED, event.errorMessage));
					}
				});
			}
			return completer.future;
		}
		
		public function loadPlayerScore():Future
		{
			var completer:Completer = new Completer();
			if (authenticated)
			{
				GoViral.goViral.facebookGraphRequest("/me/scores", GVHttpMethod.GET, {fields:"score"}).addRequestListener(function(event:GVFacebookEvent):void {
					if (event.type == GVFacebookEvent.FB_REQUEST_RESPONSE)
						completer.complete(new FacebookReponse(FacebookReponse.REQUEST_RESPONSE, event.data.data[0]));
					else
						completer.complete(new FacebookReponse(FacebookReponse.REQUEST_FAILED, null, ErrorCode.SCORE_NOT_LOADED, event.errorMessage));
				});
			}
			return completer.future;
		}
		
		public function loadUserPicture(options:FacebookImageOptions):Future
		{
			var completer:Completer = new Completer();
			if (authenticated)
			{
				var parameters:Object = {};
				if (!isNaN(options.width))
					parameters.width = options.width;
				if (!isNaN(options.height))
					parameters.height = options.height;
				if (options.type != "")
					parameters.type = options.type;
				
				GoViral.goViral.facebookGraphRequest(options.userId+"/picture", GVHttpMethod.GET, parameters).addRequestListener(function(event:GVFacebookEvent):void {
					if (event.type == GVFacebookEvent.FB_REQUEST_RESPONSE)
						completer.complete(new FacebookReponse(FacebookReponse.REQUEST_RESPONSE, event.graphPath))
					else
						completer.fail(new FacebookReponse(FacebookReponse.REQUEST_FAILED, null, ErrorCode.IMAGE_NOT_LOADED, event.errorMessage));
				});
			}
			return completer.future;
		}
		
		public function saveScore(score:int):Future
		{
			var completer:Completer = new Completer();
			if (authenticated)
			{
				GoViral.goViral.postFacebookHighScore(score).addRequestListener(function(event:GVFacebookEvent):void {
					if (event.type == GVFacebookEvent.FB_REQUEST_RESPONSE)
						completer.complete(new FacebookReponse(FacebookReponse.REQUEST_RESPONSE, event.data))
					else
						completer.complete(new FacebookReponse(FacebookReponse.REQUEST_FAILED, null, ErrorCode.SCORE_NOT_SAVED, event.errorMessage));
				});
			}
			return completer.future;
		}
		
		private function onSignedIn(event:GVFacebookEvent):void
		{
			if(_signInCompleter)
				_signInCompleter.complete(new FacebookReponse(FacebookReponse.REQUEST_RESPONSE));
		}
		
		private function onSignInCanceled(event:GVFacebookEvent):void
		{
			if(_signInCompleter)
				_signInCompleter.fail(new FacebookReponse(FacebookReponse.REQUEST_FAILED, null, ErrorCode.SIGN_IN_CANCELED, "User loginning canceled."));
		}
		
		private function onSignInFailed(event:GVFacebookEvent):void
		{
			if(_signInCompleter)
			{
				if (event.errorCode.toString() == CONNECTION_FAILURE)
					_signInCompleter.fail(new FacebookReponse(FacebookReponse.REQUEST_FAILED, null, ErrorCode.INTERNET_CONNECTION_PROBLEM, "Connection to Facebook failure."));
				else
					_signInCompleter.fail(new FacebookReponse(FacebookReponse.REQUEST_FAILED, null, ErrorCode.SIGN_IN_FAILED, event.errorMessage));
			}
		}
		
		private function onSignedOut(event:GVFacebookEvent):void
		{
			if(_signOutCompleter)
			_signOutCompleter.complete(new FacebookReponse(FacebookReponse.REQUEST_RESPONSE));
		}
	}
}