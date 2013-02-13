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
	 * Credits view. Shows general information about application. 
	 */	
	public class CreditsView extends Sprite
	{
		/**
		 * Constractor. 
		 */		
		public function CreditsView()
		{
			super();
			
			// Credits
			var label:TextField = new TextField("Credits", "Chango", 40);
			label.setActualSize(300, 100);
			addElement(label);
		}
	}
}