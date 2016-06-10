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
	import starling.textures.Texture;

	/** Facebook leaderboard item which contains user name, score and profile picture. */	
	public class FacebookLeaderboardItem
	{
		/** @private */		
		private var _name:String;
		/** @private */		
		private var _score:int;
		/** @private */		
		private var _profileTexture:Texture;
		
		/** Constructor.
		 *  @param name User name.
		 *  @param score User score.
		 *  @param profileTexture User profile picture texture. */		
		public function FacebookLeaderboardItem(name:String, score:int, profileTexture:Texture=null)
		{
			_name = name;
			_score = score;
			_profileTexture = profileTexture;
		}

		/** User name. */		
		public function get name():String { return _name; }
		public function set name(value:String):void { _name = value; }
		
		/** User score. */
		public function get score():int { return _score; }
		public function set score(value:int):void { _score = value; }
		
		/** User profile picture texture. */
		public function get profileTexture():Texture { return _profileTexture; }
		public function set profileTexture(value:Texture):void { _profileTexture = value; }
	}
}