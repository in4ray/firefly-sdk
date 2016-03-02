// =================================================================================================
//
//	Firefly Framework
//	Copyright 2016 in4ray. All Rights Reserved.
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
	import com.firefly.core.model.Model;
	import com.firefly.core.utils.Log;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.utils.getQualifiedClassName;
	
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
	public function MyGameApp()
	{
		super(CompanySplash);
		
		setGlobalLayoutContext(768, 1024);
		
		setCompanySplash(new CompanySplash());
		regNavigator(MainScreen);
		regModel(new GameModel("MyGameName"));
		regSplash(new FireflySplash(), 2); 
	}
	 
	override protected function init():void
	{
		super.init();
		
		Starling.current.showStats = true;
	}
}
	 *************************************************************************************
	 *  </listing> */	
	public class GameApp extends Sprite
	{
		/** @private */
		private var _firefly:Firefly;
		/** @private */
		private var _currentSplash:Splash;
		/** @private */
		private var _navigatorClass:Class;
		/** @private */
		private var _starling:Starling;
		/** @private */
		private var _splashScreens:Vector.<Splash>;
		/** @private */
		private var _splashScreensShowed:Boolean;
		/** @private */
		private var _starlingInitialized:Boolean;
		
		/** Constructor. 
		 * 	@param splashClass Class name of splash screen.
		 * 	@param duration Duration of displaying splash screen in seconds.*/	
		public function GameApp(splashClass:Class=null, duration:Number=2)
		{
			super();
			
			_splashScreens = new Vector.<Splash>();
			
			if (splashClass)
				regSplash(new splashClass(), duration);
			
			_firefly = new Firefly(this);
			if (_splashScreens.length > 0)
			{
				showSplash();
				Future.forEach(Future.delay(duration), _firefly.start()).then(initStarling);
			}
			else
			{
				Future.nextFrame().then(onRemoveSplash)
				_firefly.start().then(initStarling);
			}
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.quality = StageQuality.BEST;
			
			Starling.handleLostContext = true;
			
			stage.addEventListener(flash.events.Event.ADDED, onAddedToStage);
			stage.addEventListener(flash.events.Event.RESIZE, onResize);
		}
		
		public function get navigator():ScreenNavigator  { return _starling ? _starling.root as ScreenNavigator : null;  } 
		
		/** Register game navigator class which will be created after Starling was initialized.
		 *  Use <code>com.firefly.core.components.ScreenNavigator</code> */	
		public function regNavigator(value:Class):void 
		{
			CONFIG::debug {
				if(_starling)
					Log.warn("Navigator was set up after Starling was started. Will be ignored.", name);
			};
			
			_navigatorClass = value; 
		}
		
		/** Register game model in Firefly. */	
		public function regModel(model:Model):void
		{
			_firefly.setModel(model);
		}
		
		/** Register default font name in Firefly. */	
		public function regDefaultFont(font:String):void
		{
			_firefly.setDefaultFont(font);
		}
		
		/** Set company splash screen.
		 *  @param splash Instance of splash screen.
		 *  @param duration Duration of displaying splash screen in seconds.*/
		public function regSplash(splash:Splash, duration:Number = 2):void
		{
			if (splash)
			{
				splash.duration = duration;
				_splashScreens.push(splash);
			}
		}
		
		/** Called when starling and navigator is created. */	
		protected function init():void
		{
			if (_firefly.model)
				_firefly.model.load();
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
		
		/** @private 
		 *  Show splash screen. */	
		private function showSplash():Future
		{
			_currentSplash = _splashScreens.shift();
			_currentSplash.width = stage.stageWidth;
			_currentSplash.height = stage.stageHeight;
			_currentSplash.updateLayout();
			_currentSplash.show();
			addChild(_currentSplash);
			
			CONFIG::debug {	Log.info("Splash screen {0} showed.", getQualifiedClassName(_currentSplash))};
			
			return Future.delay(_currentSplash.duration).then(onRemoveSplash);
		}
		
		/** @private 
		 *  Remove current splash screen, show next splash screen or start game. */		
		private function onRemoveSplash():void
		{
			if (_currentSplash)
			{
				removeChild(_currentSplash);
				_currentSplash.hide();
			}
			
			if (_splashScreens.length > 0)
			{
				showSplash();
			}
			else
			{
				_splashScreensShowed = true;
				startGame();
			}
		}
		
		/** Starling root class created. */	
		private function onRootCreated(e:starling.events.Event):void
		{
			_starling.removeEventListener(starling.events.Event.ROOT_CREATED, onRootCreated);
			_starlingInitialized = true;
			
			init();
			startGame();
		}
		
		/** Start game in case all splash screens are showed, Firefly and Starling are initialized. */
		private function startGame():void
		{
			if (_splashScreensShowed && _starlingInitialized)
			{
				CONFIG::debug {	Log.info("Game app initialized.")};				
				navigator.controller.start();
			}
		}
		
		/** Stage resize handler. */		
		private function onResize(event:flash.events.Event):void
		{
			CONFIG::debug {	Log.info("Stage resized to {0}x{1} px.", stage.stageWidth, stage.stageHeight)};
			if (_currentSplash)
			{
				_currentSplash.width = stage.stageWidth;
				_currentSplash.height = stage.stageHeight;
				_currentSplash.updateLayout();
			}
		}
		
		/** Added to stage handler. */		
		private function onAddedToStage(event:flash.events.Event):void
		{
			stage.removeEventListener(flash.events.Event.ADDED, onAddedToStage);
		}
	}
}