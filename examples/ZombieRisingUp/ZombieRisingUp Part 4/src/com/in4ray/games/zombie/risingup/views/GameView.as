// =================================================================================================
//
//	Zombie: Rising Up
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================
package com.in4ray.games.zombie.risingup.views
{
	import com.in4ray.games.zombie.risingup.textures.Textures;
	import com.in4ray.gaming.components.Image;
	import com.in4ray.gaming.components.Sprite;
	
	
	/**
	 * Game view.
	 */	
	public class GameView extends Sprite
	{
		private var textureBundle:Textures;
		
		/**
		 * Constructor.
		 */		
		public function GameView()
		{
			super();
			
			// Get reference on game Textures
			textureBundle = new Textures();
			
			// Background
			addElement(new Image(textureBundle.menuBackground));
		}
	}
}