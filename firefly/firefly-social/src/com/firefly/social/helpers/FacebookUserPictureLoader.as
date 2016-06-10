// =================================================================================================
//
//	Firefly Framework
//	Copyright 2016 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.social.helpers
{
	import com.firefly.core.async.Completer;
	import com.firefly.core.async.Future;
	import com.firefly.social.Facebook;
	import com.firefly.social.response.SocialReponse;
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	import starling.textures.Texture;

	[ExcludeClass]
	/** The loader for loading user picture profile. */
	public class FacebookUserPictureLoader
	{
		/** @private */		
		private var _facebook:Facebook;
		/** @private */		
		private var _leaderboardItem:FacebookLeaderboardItem;
		/** @private */		
		private var _options:FacebookImageOptions;
		/** @private */
		private var _completer:Completer;
		
		/** Constructor.
		 *  @param facebook Facwebook manager.
		 *  @param leaderboardItem Leaderboard item
		 *  @param options Image options. */		
		public function FacebookUserPictureLoader(facebook:Facebook, leaderboardItem:FacebookLeaderboardItem, options:FacebookImageOptions)
		{
			_facebook = facebook;
			_leaderboardItem = leaderboardItem;
			_options = options;
		}
		
		/** Start loading user picture information.
		 *  @return Future object to get complition or error of picture loading. */		
		public function load():Future
		{
			_completer = new Completer();
			_facebook.loadUserPicture(_options).then(onUserPictureInfoLoaded);
			return _completer.future;
		}
		
		/** @private */
		private function onUserPictureInfoLoaded(response:SocialReponse):void
		{
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadPictureComplete);
			loader.load(new URLRequest(response.data as String));
		}
		
		/** @private */
		private function onLoadPictureComplete(event:Event):void
		{
			var image:Bitmap = Bitmap(LoaderInfo(event.target).content);
			_leaderboardItem.profileTexture = Texture.fromBitmap(image);
			_completer.complete();
		}
	}
}