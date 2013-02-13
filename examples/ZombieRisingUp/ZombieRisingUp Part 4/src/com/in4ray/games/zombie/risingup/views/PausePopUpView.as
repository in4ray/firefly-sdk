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
	import com.in4ray.gaming.analytics.IAnalytics;
	import com.in4ray.gaming.components.Button;
	import com.in4ray.gaming.components.Quad;
	import com.in4ray.gaming.components.Sprite;
	import com.in4ray.gaming.core.SingletonLocator;
	import com.in4ray.gaming.events.ViewStateEvent;
	import com.in4ray.gaming.layouts.$hCenter;
	import com.in4ray.gaming.layouts.$height;
	import com.in4ray.gaming.layouts.$vCenter;
	import com.in4ray.gaming.layouts.$width;
	import com.in4ray.gaming.layouts.$y;
	import com.in4ray.gaming.model.Model;
	
	import starling.events.Event;
	
	/**
	 * Pause popup view.
	 */	
	public class PausePopUpView extends Sprite
	{
		private var textureBundle:Textures;
		/**
		 * Constractor. 
		 */		
		public function PausePopUpView()
		{
			super();
			
			// Get reference on game Textures
			textureBundle = new Textures();
			
			// Black quad background with alpha
			var quad:Quad = new Quad(0x000000);
			quad.alpha = 0.7;
			addElement(quad, $width(100).pct, $height(100).pct);
			
			// Continue
			var continueBtn:Button = new Button(textureBundle.continueUpButton, "", textureBundle.continueDownButton);
			continueBtn.addEventListener(Event.TRIGGERED, continueHandler);
			addElement(continueBtn, $hCenter(-100).rcpx, $vCenter(200).rcpx);
			
			// Restart
			var restartBtn:Button = new Button(textureBundle.restartUpButton, "", textureBundle.restartDownButton);
			restartBtn.addEventListener(Event.TRIGGERED, restartHandler);
			addElement(restartBtn, $hCenter(0).rcpx, $vCenter(200).rcpx);
			
			// Menu
			var menuBtn:Button = new Button(textureBundle.menuUpButton, "", textureBundle.menuDownButton);
			menuBtn.addEventListener(Event.TRIGGERED, menuHandler);
			addElement(menuBtn, $hCenter(100).rcpx, $vCenter(200).rcpx);
		}
		
		private function continueHandler(e:Event):void
		{
			dispatchEvent(new ViewStateEvent(ViewStateEvent.CLOSE_POPUP, ViewStates.PAUSE));
		}
		
		private function restartHandler(e:Event):void
		{
			dispatchEvent(new ViewStateEvent(ViewStateEvent.SWITCH_TO_STATE, ViewStates.GAME));
			dispatchEvent(new ViewStateEvent(ViewStateEvent.CLOSE_POPUP, ViewStates.PAUSE));
		}
		
		private function menuHandler(e:Event):void
		{
			dispatchEvent(new ViewStateEvent(ViewStateEvent.SWITCH_TO_STATE, ViewStates.MENU));
			dispatchEvent(new ViewStateEvent(ViewStateEvent.CLOSE_POPUP, ViewStates.PAUSE));
		}

	}
}


