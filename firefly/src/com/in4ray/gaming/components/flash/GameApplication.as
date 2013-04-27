// =================================================================================================
//
//	in4ray Gaming SDK
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.in4ray.gaming.components.flash
{
	
	import com.in4ray.gaming.gp_internal;
	import com.in4ray.gaming.components.RootView;
	import com.in4ray.gaming.components.Sprite;
	import com.in4ray.gaming.consts.TextureConsts;
	import com.in4ray.gaming.events.StarlingEvent;
	import com.in4ray.gaming.layouts.$height;
	import com.in4ray.gaming.layouts.$width;
	import com.in4ray.gaming.core.GameGlobals;
	import com.in4ray.gaming.core.SystemManager;
	
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	
	import starling.core.Starling;
	import starling.events.Event;
	
	use namespace gp_internal;
	
	/**
	 * Base game class, all games should be extended from it. 
	 * It conatins core logic to setup game and initialize Starling.
	 * 
	 * @example The following is minimum needed to set up your game:
	 *
	 * <listing version="3.0">
import com.in4ray.games.core.components.flash.GameApplication;
 
public class SampleGame extends GameApplication
{
	public function SampleGame()
	{
		super();
		
		setDesignSize(1024, 768);
		setDesignDPI(120);
		setMainView(new MainView());
	}
}
  
  
import com.in4ray.games.core.components.Sprite;
	
import starling.events.Event;

public class MainView extends Sprite
{
	public function MainView()
	{
		addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
	}
	
	private function addedToStageHandler(e:Event):void
	{
		// place your code here
	}
}
	 * </listing>
	 */	
	public class GameApplication extends com.in4ray.gaming.components.flash.Sprite
	{
		/**
		 * Constructor. 
		 */		
		public function GameApplication()
		{
			super();
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.quality = StageQuality.BEST;
			
			Starling.handleLostContext = true;
			
			GameGlobals.preinitialize(this);
			
			stage.addEventListener(flash.events.Event.RESIZE, resizeHandler);
			stage.addEventListener(flash.events.Event.ADDED, addedHandler);
		}
		
		/**
		 * Specify design size for textures (in most cases it is size of background texture).
		 * 
		 * @param w Width in pixels.
		 * @param h Height in pixels.
		 */
		public function setDesignSize(w:Number, h:Number):void
		{
			GameGlobals._designSize = new Point(w, h);
			
			updateScaleFactor();
		}
		
		/**
		 * Specify design dpi for textures e.g. 120 dpi.
		 * 
		 * @param dpi Dots per inch.
		 */
		public function setDesignDPI(dpi:Number):void
		{
			GameGlobals._designDPI = dpi;
		}
		
		private var mainView:com.in4ray.gaming.components.Sprite;
		
		/**
		 * Set main Starling game view. 
		 * 
		 * @param main View class extended from <code>com.in4ray.games.core.components.Sprite</code>
		 */		
		public function setMainView(main:com.in4ray.gaming.components.Sprite):void
		{
			mainView = main;
			
			updateMainView();
		}
		
		private function updateMainView():void
		{
			if(Starling.current && Starling.current.root as RootView && mainView)
			{	
				(Starling.current.root as RootView).removeChildren();
				(Starling.current.root as RootView).addElement(mainView, $width(100).pct, $height(100).pct);
			}
		}
		
		private var splashScreens:Vector.<Splash> = new Vector.<Splash>();
		
		/**
		 * Add splash screen.
		 *  
		 * @param splash Splash screen object.
		 * @param duration Number of milliseconds during which splash will be shown.
		 * 
		 * @example The following example shows how to add splash screen:
		 *
		 * <listing version="3.0">
import com.in4ray.games.core.components.flash.GameApplication;
 
public class SampleGame extends GameApplication
{
	public function SampleGame()
	{
		super();
		
		 ...
		
		addSplash(new CompanySplash());
	}
}
  
  
import com.in4ray.games.core.components.flash.Splash;
import com.in4ray.games.core.components.flash.TextField;
import com.in4ray.games.core.layouts.$hCenter;
import com.in4ray.games.core.layouts.$vCenter;
import com.in4ray.games.core.layouts.$width;

import flash.text.TextFormat;

public class CompanySplash extends Splash
{
	public function CompanySplash()
	{
		super();
		
		var label:TextField = new TextField();
		label.text = "My Company";
		label.setTextFormat(new TextFormat(null, 26, 0, true));
		addElement(label, $vCenter(0), $hCenter(0), $width(160));
	}
}
		 * </listing>
		 */		
		public function addSplash(splash:Splash, duration:Number = 1000):void
		{
			splash.duration = duration;
			splashScreens.push(splash);
		}
		
		private function addedHandler(event:flash.events.Event):void
		{
			stage.removeEventListener(flash.events.Event.ADDED, addedHandler);
			showNextSplash();
		}
		
		/**
		 * Current index of splash screen. 
		 */		
		protected var currentIndex:int = -1;
		
		private var splashTimer:Timer;
		
		private var _starlingInstance:Starling;
		
		/**
		 * Instance object of Starling. 
		 */		
		public function get starlingInstance():Starling
		{
			return _starlingInstance;
		}
		
		/**
		 * Set <code>readyToRemove</code> flag to splash screen and remove it if 
		 * it's been showing more time then specified in duration.
		 *  
		 * @param splash Splash screen object.
		 */		
		public function readyToRemoveSplash(splash:Splash):void
		{
			splash.readyToRemove = true;
			
			if(currentIndex < splashScreens.length && splashScreens[currentIndex] == splash && (!splashTimer || !splashTimer.running))
			{
				timerHandler();
			}
		}
		
		private function showNextSplash():void
		{
			var duration:Number = 1000;
			if(splashScreens.length > currentIndex + 1)
			{
				currentIndex++;
				var nextSplash:Splash = splashScreens[currentIndex];
				addElement(nextSplash, $width(100).pct,  $height(100).pct);
				duration = nextSplash.duration;
				splashAdded(currentIndex);
			}
			
			splashTimer = new Timer(duration, 0);
			splashTimer.addEventListener(TimerEvent.TIMER, timerHandler);
			splashTimer.start();
		}
		
		private function timerHandler(event:TimerEvent=null):void
		{
			if(splashTimer)
			{
				splashTimer.removeEventListener(TimerEvent.TIMER, timerHandler);
				splashTimer.stop();
				splashTimer = null;
			}
			
			if(currentIndex >= 0 && splashScreens[currentIndex].readyToRemove)
			{
				if(currentIndex >= 0)
					removeChild(splashScreens[currentIndex]);
				
				splashRemoved(currentIndex);
				
				if(splashScreens.length > currentIndex + 1)
					showNextSplash();
			}
			else if(currentIndex == -1)
			{
				initStarling();
			}
		}
		
		/**
		 * Next splash screen added. 
		 * @param index index of splash screen.
		 */		
		protected function splashAdded(index:Number):void
		{
			if(index == 1)
				initStarling();
		}
		
		/**
		 * Current splash screen removed. 
		 * @param index index of splash screen.
		 */	
		protected function splashRemoved(index:Number):void
		{
			if(index <= 0)
				GameGlobals.init(this);
			
			if(index <= 0 && splashScreens.length < 2)
				initStarling();
			
			if(index == splashScreens.length-1)
				splashChainComplete();
		}
		
		/**
		 * All splash screens have been already showed. 
		 */		
		protected function splashChainComplete():void
		{
			splashScreens.length = 0;
		}
		
		/**
		 * Initialize Starling object. 
		 */		
		protected function initStarling():void
		{
			_starlingInstance = new Starling(RootView, stage, new Rectangle(0, 0, GameGlobals.stageSize.x, GameGlobals.stageSize.y));
			_starlingInstance.addEventListener(starling.events.Event.ROOT_CREATED, rootCreatedHandler);
			_starlingInstance.start();
		}
		
		private function rootCreatedHandler(event:starling.events.Event):void
		{
			updateMainView();
			dispatchEvent(new StarlingEvent(StarlingEvent.STARLING_INITIALIZED));
		}		
		
		/**
		 * Stage resize handler. 
		 * 
		 * @param event Stage resize event.
		 */		
		protected function resizeHandler(event:flash.events.Event):void
		{
			CONFIG::debugging {trace("[in4ray] Stage resized to " + stage.stageWidth + "x" + stage.stageHeight)};
			
			GameGlobals._stageSize = new Point(stage.stageWidth, stage.stageHeight);
			
			updateScaleFactor();
			
			if(stage.stageWidth > 0 && stage.stageHeight > 0)
				setActualSize(stage.stageWidth, stage.stageHeight);
		}
		
		private function updateScaleFactor():void
		{
			if(GameGlobals.designSize && GameGlobals.stageSize)
				GameGlobals._contentScaleFactor = Math.max(1, Math.max(GameGlobals.stageSize.x/TextureConsts.MAX_WIDTH, GameGlobals.stageSize.y/TextureConsts.MAX_HEIGHT));
			
			CONFIG::debugging {trace("[in4ray] Content scale factor " + GameGlobals.contentScaleFactor)};
		}
		
		override public function set height(value:Number):void
		{
			throw Error("Forbidden, use setActualSize method instead."); 
		}
		
		override public function set width(value:Number):void
		{
			throw Error("Forbidden, use setActualSize method instead."); 
		}
		
		override public function set x(value:Number):void
		{
			throw Error("Forbidden, use setActualPosition method instead."); 
		}
		
		override public function set y(value:Number):void
		{
			throw Error("Forbidden, use setActualPosition method instead."); 
		}
	}
}
