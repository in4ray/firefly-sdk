// =================================================================================================
//
//	in4ray Gaming SDK
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.in4ray.gaming.navigation
{
	import com.in4ray.gaming.components.Quad;
	import com.in4ray.gaming.effects.Fade;
	
	import starling.events.Event;
	
	[ExcludeClass]
	public class PopUpCover extends Quad
	{
		public function PopUpCover()
		{
			super(0);
			alpha = 0.5;
			
			fade = new Fade(this, 300, 0.7, 0);
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		private var fade:Fade;
		
		private function addedToStageHandler(e:Event):void
		{
			fade.play();
		}
	}
}