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
	import com.firefly.core.async.Future;
	import com.firefly.core.utils.Log;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import starling.core.Starling;
	import starling.events.Event;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	use namespace firefly_internal;
	
	/** Basic game application class with integrated Firefly initialization.
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
		setCompanySplash(new CompanySplash());
	}
}
	 *************************************************************************************
	 *  </listing> */	
	public class GameApp extends Sprite
	{
		private var _firefly:Firefly;
		private var _splash:Splash;
		private var _navigatorClass:Class;
		private var _starling:Starling;
		
		/** Constructor. 
		 * 	@param splashClass Instance of splash screen. 
		 * 	@param duration Duration of displaying splash screen in seconds.*/	
		public function GameApp(splashClass:Class = null, duration:Number = 2)
		{
			super();
			
			_firefly = new Firefly(this);
			
			if(splashClass != null)
				Future.forEach(_firefly.start(), setCompanySplash(new splashClass(), duration)).then(initStarling);
			else
				_firefly.start().then(initStarling);
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.quality = StageQuality.BEST;
			
			Starling.handleLostContext = true;
			
			stage.addEventListener(flash.events.Event.ADDED, onAddedToStage);
			stage.addEventListener(flash.events.Event.RESIZE, onResize);
		}
		
		public function get navigator():ScreenNavigator 
		{
			return _starling ? _starling.root as ScreenNavigator : null; 
		} 
		
		public function regNavigator(value:Class):void 
		{
			CONFIG::debug {
				if(_starling)
					Log.warn("Navigator was set up after Starling was started. Will be ignored.", name);
			};
			
			_navigatorClass = value; 
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
		
		/** Initialize game application after initialization Firefly and showing splash screen. */	
		private function initStarling():void
		{
			if(!_navigatorClass)
				_navigatorClass = ScreenNavigator;
			
			_starling = new Starling(_navigatorClass, stage, new Rectangle(0,0, stage.stageWidth, stage.stageHeight));
			_starling.start();
			_starling.addEventListener(starling.events.Event.ROOT_CREATED, onRootCreated);
			
			Firefly.current.initJuggler(Starling.juggler);
		}
		
		/** Starling root class created. */	
		private function onRootCreated(e:starling.events.Event):void
		{
			if (_splash)
			{
				removeChild(_splash);
				_splash = null;
			}
			
			init();
		}
		
		/** Called when starling and navigator is created*/	
		protected function init():void
		{
			navigator.controller.start();
		}
		
		/** Set company splash screen.
		 *  @param splash Instance of splash screen.
		 *  @param duration Duration of displaying splash screen in seconds.*/
		private function setCompanySplash(splash:Splash, duration:Number = 2):Future
		{
			if (splash)
			{
				_splash = splash;
				_splash.width = stage.stageWidth;
				_splash.height = stage.stageHeight;
				_splash.updateLayout();
				addChild(_splash);
			}
			
			return Future.delay(duration);
		}
		
		/** Stage resize handler. */		
		private function onResize(event:flash.events.Event):void
		{
			CONFIG::debug {	Log.info("Stage resized to {0}x{1} px.", stage.stageWidth, stage.stageHeight)};
			if (_splash)
			{
				_splash.width = stage.stageWidth;
				_splash.height = stage.stageHeight;
				_splash.updateLayout();
			}
		}
		
		/** Added to stage handler. */		
		private function onAddedToStage(event:flash.events.Event):void
		{
			stage.removeEventListener(flash.events.Event.ADDED, onAddedToStage);
		}
	}
}