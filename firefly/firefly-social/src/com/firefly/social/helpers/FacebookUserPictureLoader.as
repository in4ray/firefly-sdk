package com.firefly.social.helpers
{
	import com.firefly.core.async.Completer;
	import com.firefly.core.async.Future;
	import com.firefly.social.Facebook;
	import com.firefly.social.response.FacebookReponse;
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	import starling.textures.Texture;

	public class FacebookUserPictureLoader
	{
		private var _facebook:Facebook;
		private var _leaderboardItem:FacebookLeaderboardItem;
		private var _options:FacebookImageOptions;
		private var _completer:Completer;
		
		public function FacebookUserPictureLoader(facebook:Facebook, leaderboardItem:FacebookLeaderboardItem, options:FacebookImageOptions)
		{
			_facebook = facebook;
			_leaderboardItem = leaderboardItem;
			_options = options;
		}
		
		public function load():Future
		{
			_completer = new Completer();
			_facebook.loadUserPicture(_options).then(onUserPictureInfoLoaded);
			return _completer.future;
		}
		
		public function onUserPictureInfoLoaded(response:FacebookReponse):void
		{
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadPictureComplete);
			loader.load(new URLRequest(response.data as String));
		}
		
		protected function onLoadPictureComplete(event:Event):void
		{
			var image:Bitmap = Bitmap(LoaderInfo(event.target).content);
			_leaderboardItem.profileTexture = Texture.fromBitmap(image);
			_completer.complete();
		}
	}
}