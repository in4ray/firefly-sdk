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
	import com.firefly.core.async.GroupCompleter;
	import com.firefly.core.utils.SingletonLocator;
	import com.firefly.social.consts.ErrorCode;
	import com.firefly.social.helpers.FacebookImageOptions;
	import com.firefly.social.helpers.FacebookLeaderboardItem;
	import com.firefly.social.helpers.FacebookUserPictureLoader;
	import com.firefly.social.response.SocialReponse;
	import com.milkmangames.nativeextensions.GVHttpMethod;
	import com.milkmangames.nativeextensions.GoViral;
	import com.milkmangames.nativeextensions.events.GVFacebookEvent;
	
	import flash.geom.Point;
	
	import starling.events.EventDispatcher;
	
	/** This manager requires Milkman GoViral Native Extension for Adobe AIR.
	 *  To compile code you need to buy .ane and place it into "external" library folder.
	 *  @see https://www.milkmanplugins.com/goviral-facebook-and-sharing-air-ane */
	public class Facebook extends EventDispatcher
	{
		/** Facebook connection error.  */		
		private const CONNECTION_FAILURE:String = "9001";
		
		/** @private */		
		private var _initialized:Boolean;
		/** @private */
		private var _appId:String;
		/** @private */
		private var _profilePictureSize:Point;
		/** @private */
		private var _signInCompleter:Completer;
		/** @private */
		private var _signOutCompleter:Completer;
		
		/** Constructor. */		
		public function Facebook()
		{
			SingletonLocator.register(this, Facebook);
		}
		
		/** Instance of Facebook manager. */		
		public static function get instance():Facebook { return SingletonLocator.getInstance(Facebook); }
		
		/** Defines initialization state. */		
		public function get initialized():Boolean { return _initialized; }
		/** Defines user authentication state. */
		public function get authenticated():Boolean { return _initialized && GoViral.goViral.isFacebookAuthenticated() }
		
		/** Initialize Facebook manager.
		 *  @param appId Facebook application id.
		 *  @param profilePictureSize Profile picture size for leaderboard. */		
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
		
		/** Invoke Facebook sign in process.
		 *  @param readPermissions List of permissions will be requested.
		 *  @return Future object to get complition or error of sign in process. */		
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
					_signInCompleter.fail(new SocialReponse(SocialReponse.REQUEST_FAILURE, null, ErrorCode.SIGN_IN_FAILED));
				}
			}
			return _signInCompleter.future;
		}
		
		/** Invoke Facebook sign out process.
		 *  @return Future object to get complition or error of sign out process. */		
		public function signOut():Future
		{
			_signOutCompleter = new Completer();
			if (_initialized)
				GoViral.goViral.logoutFacebook();
			return _signOutCompleter.future;
		}
		
		/** Load leaderboard from Facebook friends.
		 *  @return Future object to get complition or error leaderboard loading. */		
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
							completer.complete(new SocialReponse(SocialReponse.REQUEST_RESPONSE, leaderboardItems))
						});
					}
					else
					{
						completer.fail(new SocialReponse(SocialReponse.REQUEST_FAILURE, null, ErrorCode.LEADERBOARD_NOT_LOADED, event.errorMessage));
					}
				});
			}
			return completer.future;
		}
		
		/** Load user score.
		 *  @return Future object to get complition or error of player score loading. */
		public function loadUserScore():Future
		{
			var completer:Completer = new Completer();
			if (authenticated)
			{
				GoViral.goViral.facebookGraphRequest("/me/scores", GVHttpMethod.GET, {fields:"score"}).addRequestListener(function(event:GVFacebookEvent):void {
					if (event.type == GVFacebookEvent.FB_REQUEST_RESPONSE)
						completer.complete(new SocialReponse(SocialReponse.REQUEST_RESPONSE, event.data.data[0]));
					else
						completer.complete(new SocialReponse(SocialReponse.REQUEST_FAILURE, null, ErrorCode.SCORE_NOT_LOADED, event.errorMessage));
				});
			}
			return completer.future;
		}
		
		/** Load user profile picture.
		 *  @param options Additional options for user profile picture loading.
		 *  @return Future object to get complition or error of user profile picture loading. */		
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
						completer.complete(new SocialReponse(SocialReponse.REQUEST_RESPONSE, event.graphPath))
					else
						completer.fail(new SocialReponse(SocialReponse.REQUEST_FAILURE, null, ErrorCode.IMAGE_NOT_LOADED, event.errorMessage));
				});
			}
			return completer.future;
		}
		
		/** Save user score.
		 *  @param score Score value.
		 *  @return Future object to get complition or error of score saving process. */
		public function saveScore(score:int):Future
		{
			var completer:Completer = new Completer();
			if (authenticated)
			{
				GoViral.goViral.postFacebookHighScore(score).addRequestListener(function(event:GVFacebookEvent):void {
					if (event.type == GVFacebookEvent.FB_REQUEST_RESPONSE)
						completer.complete(new SocialReponse(SocialReponse.REQUEST_RESPONSE, event.data))
					else
						completer.complete(new SocialReponse(SocialReponse.REQUEST_FAILURE, null, ErrorCode.SCORE_NOT_SAVED, event.errorMessage));
				});
			}
			return completer.future;
		}
		
		/** @private */		
		private function onSignedIn(event:GVFacebookEvent):void
		{
			if(_signInCompleter)
				_signInCompleter.complete(new SocialReponse(SocialReponse.REQUEST_RESPONSE));
		}
		
		/** @private */
		private function onSignInCanceled(event:GVFacebookEvent):void
		{
			if(_signInCompleter)
				_signInCompleter.fail(new SocialReponse(SocialReponse.REQUEST_FAILURE, null, ErrorCode.SIGN_IN_CANCELED, "User loginning canceled."));
		}
		
		/** @private */
		private function onSignInFailed(event:GVFacebookEvent):void
		{
			if(_signInCompleter)
			{
				if (event.errorCode.toString() == CONNECTION_FAILURE)
					_signInCompleter.fail(new SocialReponse(SocialReponse.REQUEST_FAILURE, null, ErrorCode.INTERNET_CONNECTION_PROBLEM, "Connection to Facebook failure."));
				else
					_signInCompleter.fail(new SocialReponse(SocialReponse.REQUEST_FAILURE, null, ErrorCode.SIGN_IN_FAILED, event.errorMessage));
			}
		}
		
		/** @private */
		private function onSignedOut(event:GVFacebookEvent):void
		{
			if(_signOutCompleter)
			_signOutCompleter.complete(new SocialReponse(SocialReponse.REQUEST_RESPONSE));
		}
	}
}