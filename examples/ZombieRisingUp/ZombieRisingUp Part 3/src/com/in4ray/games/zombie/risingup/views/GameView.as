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
	import com.in4ray.gaming.components.Sprite;
	import com.in4ray.gaming.components.TextField;
	
	
	/**
	 * Game view.
	 */	
	public class GameView extends Sprite
	{
		
		/**
		 * Constructor.
		 */		
		public function GameView()
		{
			super();
			
			var label:TextField = new TextField("Game", "Chango", 80);
			label.setActualSize(300, 100);
			addElement(label);
		}
	}
}