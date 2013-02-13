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
	import com.in4ray.gaming.components.flash.Sprite;
	
	/**
	 * Lost context view. By default black screen.
	 * Shows when application lost context.  
	 */	
	public class LostContextView extends Sprite
	{
		/**
		 * Constractor. 
		 */		
		public function LostContextView()
		{
			super();
		}
		
		/**
		 * @inheritDoc
		 */	
		override public function setActualSize(w:Number, h:Number):void
		{
			super.setActualSize(w, h);
			
			graphics.clear();
			graphics.beginFill(0);
			graphics.drawRect(0, 0, w, h)
			graphics.endFill();
		}
	}
}