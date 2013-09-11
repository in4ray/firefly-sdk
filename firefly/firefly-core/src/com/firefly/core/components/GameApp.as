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
	
	/** Basic game application class with integrated Firefly initializatin.
	 *  
	 * @example The following code shows how configure layout context of the applciation (design size):
	 *  <listing version="3.0">
	 *************************************************************************************
public class MyGameApp extends GameApp
{
	private var starling:Starling;
		
	public function MyGameApp()
	{
		super();
		
		setGlobalLayoutContext(768, 1024);
	}
}
	 *************************************************************************************
	 *  </listing> */	
	public class GameApp extends Sprite
	{
		private var _firefly:Firefly;
		
		/** Constructor. */	
		public function GameApp()
		{
			super();
			
			_firefly = new Firefly(this);
			_firefly.start().then(init);
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.quality = StageQuality.BEST;
			
			Starling.handleLostContext = true;
			
			stage.addEventListener(flash.events.Event.ADDED, onAddedToStage);
			stage.addEventListener(flash.events.Event.RESIZE, onResize);
		}
		
		/** Set global layout of the application.
		 *  @param designWidth Design width of the application.
		 *  @param designHeight Design height of the application.
		 *  @param vAlign Vertical align of layout.
		 *  @param hAlign Horizontal align of layout. */	
		protected function setGlobalLayoutContext(designWidth:Number, designHeight:Number, vAlign:String = VAlign.CENTER, hAlign:String = HAlign.CENTER):void
		{
			_firefly.setLayoutContext(designWidth, designHeight, vAlign, hAlign);
		}
		
		/** Initialize game application after initialization Firefly. */	
		protected function init():void
		{
			
		}
		
		/** Stage resize handler. */		
		protected function onResize(event:flash.events.Event):void
		{
			CONFIG::debug {	Log.info("Stage resized to {0}x{1} px.",  stage.stageWidth, stage.stageHeight)};
		}
		
		/** Added to stage handler. */		
		protected function onAddedToStage(event:flash.events.Event):void
		{
			stage.removeEventListener(flash.events.Event.ADDED, onAddedToStage);
		}
	}
}