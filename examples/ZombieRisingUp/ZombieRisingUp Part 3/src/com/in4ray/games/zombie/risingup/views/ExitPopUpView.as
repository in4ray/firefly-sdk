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
	 * Exit pop up dialog.
	 */
	public class ExitPopUpView extends Sprite
	{
		/**
		 * Constructor.
		 */
		public function ExitPopUpView()
		{
			super();
			
			
			// Dialog message
			var label:TextField = new TextField("Exit Popup", "Chango", 64);
			label.setActualSize(300, 100);
			label.setActualPosition(300, 150);
			addElement(label);
		}
	}
}