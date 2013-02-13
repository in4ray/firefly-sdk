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
	 * Game score view. Show user score (number of killed zombies) after each game session. 
	 */	
	public class ScoreView extends Sprite
	{
		/**
		 * Constractor. 
		 */		
		public function ScoreView()
		{
			super();
			
			var label:TextField = new TextField("Score", "Chango", 40);
			label.setActualSize(300, 100);
			addElement(label);
		}
	}
}