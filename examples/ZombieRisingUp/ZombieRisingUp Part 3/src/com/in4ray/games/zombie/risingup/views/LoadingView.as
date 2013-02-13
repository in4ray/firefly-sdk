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
	 * Loading view. Black screen with 'Loading...' message.
	 * Shows when application backs from hibernate mode.
	 */	
	public class LoadingView extends Sprite
	{
		/**
		 * Constractor. 
		 */		
		public function LoadingView()
		{
			super();
		
			var label:TextField = new TextField("Loading", "Chango", 80);
			addElement(label);
		}
	}
}
