package com.firefly.social.helpers
{
	import starling.textures.Texture;

	public class FacebookLeaderboardItem
	{
		private var _name:String;
		private var _score:int;
		private var _profileTexture:Texture;
		
		public function FacebookLeaderboardItem(name:String, score:int, profileTexture:Texture=null)
		{
			_name = name;
			_score = score;
			_profileTexture = profileTexture;
		}

		public function get name():String { return _name; }
		public function set name(value:String):void { _name = value; }
		
		public function get score():int { return _score; }
		public function set score(value:int):void { _score = value; }
		
		public function get profileTexture():Texture { return _profileTexture; }
		public function set profileTexture(value:Texture):void { _profileTexture = value; }
	}
}