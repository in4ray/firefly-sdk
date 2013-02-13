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
	import com.in4ray.games.zombie.risingup.consts.AppConsts;
	import com.in4ray.games.zombie.risingup.consts.ViewStates;
	import com.in4ray.games.zombie.risingup.textures.Textures;
	import com.in4ray.gaming.components.Button;
	import com.in4ray.gaming.components.Image;
	import com.in4ray.gaming.components.Sprite;
	import com.in4ray.gaming.components.TextField;
	import com.in4ray.gaming.events.ViewStateEvent;
	import com.in4ray.gaming.layouts.$bottom;
	import com.in4ray.gaming.layouts.$hCenter;
	import com.in4ray.gaming.layouts.$height;
	import com.in4ray.gaming.layouts.$left;
	import com.in4ray.gaming.layouts.$top;
	import com.in4ray.gaming.layouts.$width;
	import com.in4ray.gaming.layouts.$y;
	
	import starling.events.Event;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	/**
	 * Credits view. Shows general information about application. 
	 */	
	public class CreditsView extends Sprite
	{
		private var textureBundle:Textures;
		
		/**
		 * Constractor. 
		 */		
		public function CreditsView()
		{
			super();
			
			// Get reference on game Textures
			textureBundle = new Textures();
			
			// Background
			addElement(new Image(textureBundle.menuBackground));
			
			// Game Name
			addElement(new Image(textureBundle.gameName), $hCenter(0), $y(60).rcpx);
			
			// Credits
			var creditsTxt:TextField = new TextField(AppConsts.CREDITS_MESSAGE, "Chango", 40, 0xFFFFFF);
			creditsTxt.autoScale = true;
			creditsTxt.touchable = false;
			creditsTxt.hAlign = HAlign.CENTER;
			creditsTxt.vAlign = VAlign.TOP;
			addElement(creditsTxt, $top(160).rcpx, $hCenter(0).rcpx, $width(900).rcpx, $height(340).rcpx);
			
			// Back
			var backBtn:Button = new Button(textureBundle.backUpButton, "", textureBundle.backDownButton);
			backBtn.addEventListener(Event.TRIGGERED, backHandler);
			addElement(backBtn, $left(20).rcpx, $bottom(20).rcpx);
		}
		
		private function backHandler(e:Event):void
		{
			dispatchEvent(new ViewStateEvent(ViewStateEvent.SWITCH_TO_STATE, ViewStates.MENU));
		}
	}
}