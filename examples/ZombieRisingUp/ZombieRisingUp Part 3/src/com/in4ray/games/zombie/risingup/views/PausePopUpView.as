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
	 * Pause popup view.
	 */	
	public class PausePopUpView extends Sprite
	{
		/**
		 * Constractor. 
		 */		
		public function PausePopUpView()
		{
			super();
			
			var label:TextField = new TextField("Pause", "Chango", 40);
			label.setActualSize(300, 100);
			label.setActualPosition(300, 150);
			addElement(label);
			addEventListener(TouchEvent.TOUCH, touchHandler);
		}
		
		private function touchHandler(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(this);
			if(touch && touch.phase == TouchPhase.BEGAN)
				dispatchEvent(new ViewStateEvent(ViewStateEvent.CLOSE_POPUP , ViewStates.PAUSE));
		}
	}
}