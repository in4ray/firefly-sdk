// =================================================================================================
//
//	Firefly Framework
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.components
{
	import com.firefly.core.Firefly;
	import com.firefly.core.firefly_internal;
	import com.firefly.core.layouts.LayoutContext;
	import com.firefly.core.utils.Log;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	import starling.core.Starling;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	use namespace firefly_internal;
	
	public class GameApp extends Sprite
	{
		public function GameApp()
		{
			super();
			
			new Firefly(this);
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.quality = StageQuality.BEST;
			
			Starling.handleLostContext = true;
			
			stage.addEventListener(flash.events.Event.RESIZE, resizeHandler);
			stage.addEventListener(flash.events.Event.ADDED, addedHandler);
		}
		
		public function setGlobalLayoutContext(designWidth:Number, designHeight:Number, vAlign:String = VAlign.CENTER, hAlign:String = HAlign.CENTER):void
		{
			Firefly.current.setLayoutContext(designWidth, designHeight, vAlign, hAlign);
		}
		
		/**
		 * Stage resize handler. 
		 * 
		 * @param event Stage resize event.
		 */		
		protected function resizeHandler(event:flash.events.Event):void
		{
			CONFIG::debug {	Log.info("Stage resized to {0}x{1} px.",  stage.stageWidth, stage.stageHeight)};
		
			Firefly.current.updateSize(stage);
		}
		
		protected function addedHandler(event:flash.events.Event):void
		{
			stage.removeEventListener(flash.events.Event.ADDED, addedHandler);
			//showNextSplash();
		}
	}
}