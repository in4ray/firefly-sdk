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
	import com.in4ray.gaming.components.ToggleButton;
	import com.in4ray.gaming.consts.SystemType;
	import com.in4ray.gaming.core.GameGlobals;
	import com.in4ray.gaming.events.ViewStateEvent;
	import com.in4ray.gaming.layouts.$bottom;
	import com.in4ray.gaming.layouts.$hCenter;
	import com.in4ray.gaming.layouts.$height;
	import com.in4ray.gaming.layouts.$left;
	import com.in4ray.gaming.layouts.$right;
	import com.in4ray.gaming.layouts.$top;
	import com.in4ray.gaming.layouts.$vCenter;
	import com.in4ray.gaming.layouts.$width;
	import com.in4ray.gaming.layouts.$y;
	import com.in4ray.gaming.layouts.context.BasicLayoutContext;
	
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import starling.events.Event;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	/**
	 * Game menu view. 
	 */	
	public class MenuView extends Sprite
	{

		private var play:TextField;

		private var credits:TextField;
		
		private var textureBundle:Textures;
		
		/**
		 * Constractor. 
		 */		
		public function MenuView()
		{
			super();
			
			// Set default menu view layout context aligment as BOTTOM
			layoutContext = new BasicLayoutContext(this, HAlign.CENTER, VAlign.BOTTOM);
			
			// Get reference on game Textures
			textureBundle = new Textures();
			
			// Background
			addElement(new Image(textureBundle.menuBackground));
			
			// Game Name
			addElement(new Image(textureBundle.gameName), $hCenter(0), $y(60).rcpx);
			
			// Best Score Message
			var bestScoreMessage:TextField = new TextField("Best Score", "Chango", 80, 0x00FF00);
			bestScoreMessage.touchable = false;
			bestScoreMessage.autoScale = true;
			bestScoreMessage.hAlign = HAlign.LEFT;
			bestScoreMessage.vAlign = VAlign.TOP;
			addElement(bestScoreMessage, $right(86).acpx, $top(540).acpx, $width(180).acpx, $height(50).acpx);
					
			// Play
			var playBtn:Button = new Button(textureBundle.playUpButton, "", textureBundle.playDownButton);
			playBtn.addEventListener(Event.TRIGGERED, playHandler);
			addElement(playBtn, $hCenter(0), $vCenter(0));
			
			// Sound
			var soundBtn:ToggleButton = new ToggleButton(textureBundle.soundOnUpButton, textureBundle.soundOffUpButton, "", "", textureBundle.soundOnDownButton, textureBundle.soundOffDownButton);
			soundBtn.addEventListener(Event.TRIGGERED, soundHandler);
			addElement(soundBtn, $right(380).rcpx, $bottom(20).rcpx);
			
			// More
			var moreBtn:Button = new Button(textureBundle.moreUpButton, "", textureBundle.moreDownButton);
			moreBtn.addEventListener(Event.TRIGGERED, moreHandler);
			addElement(moreBtn, $right(290).rcpx, $bottom(20).rcpx);
			
			// Credits
			var creditsBtn:Button = new Button(textureBundle.creditsUpButton, "", textureBundle.creditsDownButton);
			creditsBtn.addEventListener(Event.TRIGGERED, creditsHandler);
			addElement(creditsBtn, $right(200).rcpx, $bottom(20).rcpx);
			
			// Facebook
			var facebookBtn:Button = new Button(textureBundle.facebookUpButton, "", textureBundle.facebookDownButton);
			facebookBtn.addEventListener(Event.TRIGGERED, facebookHandler);
			addElement(facebookBtn, $right(110).rcpx, $bottom(20).rcpx);
			
			// Twitter
			var twitterBtn:Button = new Button(textureBundle.twitterUpButton, "", textureBundle.twitterDownButton);
			twitterBtn.addEventListener(Event.TRIGGERED, twitterHandler);
			addElement(twitterBtn, $right(20).rcpx, $bottom(20).rcpx);
			
			// Exit
			if(GameGlobals.systemType != SystemType.IOS)
			{
				var exitBtn:Button = new Button(textureBundle.closeUpButton, "", textureBundle.closeDownButton);
				exitBtn.addEventListener(Event.TRIGGERED, exitHandler);
				addElement(exitBtn, $left(20).rcpx, $bottom(20).rcpx);
			}
		}
		
		private function playHandler(e:Event):void
		{
			dispatchEvent(new ViewStateEvent(ViewStateEvent.SWITCH_TO_STATE, ViewStates.GAME));
		}
		
		private function soundHandler(e:Event):void
		{
		}
		
		private function moreHandler(e:Event):void
		{
			navigateToURL(new URLRequest(AppConsts.MORE_URL), "_blank");
		}
		
		private function creditsHandler(e:Event):void
		{
			dispatchEvent(new ViewStateEvent(ViewStateEvent.SWITCH_TO_STATE, ViewStates.CREDITS));
		}
		
		private function twitterHandler(e:Event):void
		{
			navigateToURL(new URLRequest(AppConsts.TWITTER_URL), "_blank");
		}
		
		private function facebookHandler():void
		{
			navigateToURL(new URLRequest(AppConsts.FACEBOOK_URL), "_blank");
		}
		
		private function exitHandler(e:Event):void
		{
			dispatchEvent(new ViewStateEvent(ViewStateEvent.OPEN_POPUP, ViewStates.EXIT));
		}
	}
}