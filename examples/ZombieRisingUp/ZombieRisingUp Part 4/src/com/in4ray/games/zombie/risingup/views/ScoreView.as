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
	import com.in4ray.games.zombie.risingup.consts.ViewStates;
	import com.in4ray.games.zombie.risingup.textures.Textures;
	import com.in4ray.gaming.components.Button;
	import com.in4ray.gaming.components.Image;
	import com.in4ray.gaming.components.Quad;
	import com.in4ray.gaming.components.Sprite;
	import com.in4ray.gaming.components.TextField;
	import com.in4ray.gaming.events.ViewStateEvent;
	import com.in4ray.gaming.layouts.$hCenter;
	import com.in4ray.gaming.layouts.$height;
	import com.in4ray.gaming.layouts.$vCenter;
	import com.in4ray.gaming.layouts.$width;
	
	import starling.events.Event;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	/**
	 * Game score view. Show user score (number of killed zombies) after each game session. 
	 */	
	public class ScoreView extends Sprite
	{
		private var textureBundle:Textures;
		
		private var scoreTxt:TextField;
		
		/**
		 * Constractor. 
		 */		
		public function ScoreView()
		{
			super();
			
			// Get reference on game Textures
			textureBundle = new Textures();
			
			// Background
			addElement(new Image(textureBundle.menuBackground));
			
			// Black quad background with alpha
			var quad:Quad = new Quad(0x000000);
			quad.alpha = 0.7;
			addElement(quad, $width(100).pct, $height(100).pct);
			
			// Your Score Message
			var scoreMessage:TextField = new TextField("Your Score", "Chango", 80, 0x00FF00);
			scoreMessage.touchable = false;
			scoreMessage.autoScale = true;
			scoreMessage.hAlign = HAlign.CENTER;
			scoreMessage.vAlign = VAlign.TOP;
			addElement(scoreMessage, $vCenter(-80).rcpx, $hCenter(0).rcpx, $width(280).rcpx, $height(50).rcpx);
			
			//Skull
			addElement(new Image(textureBundle.skull), $vCenter(-20).rcpx, $hCenter(-70).rcpx);
			
			// Score
			scoreTxt = new TextField("", "Chango", 80, 0x00ff00);
			scoreTxt.autoScale = true;
			scoreTxt.touchable = false;
			scoreTxt.hAlign = HAlign.LEFT;
			scoreTxt.vAlign = VAlign.TOP;
			addElement(scoreTxt, $vCenter(-20).rcpx, $hCenter(70).rcpx, $width(180).rcpx, $height(50).rcpx);
			
			// Restart
			var restartBtn:Button = new Button(textureBundle.restartUpButton, "", textureBundle.restartDownButton);
			restartBtn.addEventListener(Event.TRIGGERED, restartHandler);
			addElement(restartBtn, $hCenter(-60).rcpx, $vCenter(200).rcpx);
			
			// Menu
			var menuBtn:Button = new Button(textureBundle.menuUpButton, "", textureBundle.menuDownButton);
			menuBtn.addEventListener(Event.TRIGGERED, menuHandler);
			addElement(menuBtn, $hCenter(60).rcpx, $vCenter(200).rcpx);
			
		}
		
		/**
		 * Game score (number of killed zombies).
		 */	
		private var _score:int = -1;
		public function get score():int
		{
			return _score;
		}
		public function set score(value:int):void
		{
			if(_score != value)
			{
				_score = value;
				
				scoreTxt.text = "x " + _score;
			}
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
