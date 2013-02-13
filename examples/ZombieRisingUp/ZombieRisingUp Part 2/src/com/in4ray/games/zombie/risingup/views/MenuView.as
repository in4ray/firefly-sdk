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
	import com.in4ray.gaming.components.Sprite;
	import com.in4ray.gaming.components.TextField;
	import com.in4ray.gaming.events.ViewStateEvent;
	
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	/**
	 * Game menu view. 
	 */	
	public class MenuView extends Sprite
	{

		private var play:TextField;

		private var credits:TextField;
		
		/**
		 * Constractor. 
		 */		
		public function MenuView()
		{
			super();
			
			var label:TextField = new TextField("Menu", "Chango", 40);
			label.setActualSize(300, 100);
			addElement(label);
			
			play = new TextField("Play", "Chango", 40);
			play.setActualSize(300, 50);
			play.setActualPosition(100, 100);
			addElement(play);
			play.addEventListener(TouchEvent.TOUCH, gameTouchHandler);
			
			credits = new TextField("Credits", "Chango", 40);
			credits.setActualSize(300, 50);
			credits.setActualPosition(100, 150);
			addElement(credits);
			credits.addEventListener(TouchEvent.TOUCH, creditsTouchHandler);
		}
		
		private function gameTouchHandler(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(play);
			if(touch && touch.phase == TouchPhase.BEGAN)
				dispatchEvent(new ViewStateEvent(ViewStateEvent.SWITCH_TO_STATE, ViewStates.GAME));
		}
		
		private function creditsTouchHandler(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(credits);
			if(touch && touch.phase == TouchPhase.BEGAN)
				dispatchEvent(new ViewStateEvent(ViewStateEvent.SWITCH_TO_STATE, ViewStates.CREDITS));
		}
	}
}