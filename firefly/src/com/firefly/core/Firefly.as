// =================================================================================================
//
//	Firefly Framework
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core
{
	import com.firefly.core.async.Completer;
	import com.firefly.core.async.Future;
	import com.firefly.core.audio.AudioMixer;
	import com.firefly.core.consts.SystemType;
	import com.firefly.core.layouts.LayoutContext;
	import com.firefly.core.utils.Log;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.system.Capabilities;
	import flash.utils.getTimer;
	
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	use namespace firefly_internal;
	
	/** Firefly core class with configurations. */
	public class Firefly
	{
		/** Maximum texture size needed for calculation of content scale. */
		private static const MAX_TEXTURE_SIZE:Number = 4096;
		private static var _current:Firefly;
		
		firefly_internal var _textureScale:Number;
		
		private var _main:Sprite;
		private var _defaultFrameRate:Number;
		private var _stageWidth:Number;
		private var _stageHeight:Number;
		private var _contentScale:Number;
		private var _layoutContext:LayoutContext;
		private var _audioMixer:AudioMixer;
		private var _completer:Completer;
		private var _systemType:String;
		private var _dpi:Number;
		
		/** Constructor.
		 *  @param main Application entry point. */
		public function Firefly(main:Sprite)
		{
			_main = main;
			_current = this;
			_defaultFrameRate = _main.stage.frameRate;
			
			// define operating system
			if (Capabilities.version.indexOf('IOS') > -1)
				_systemType = SystemType.IOS;
			else if (Capabilities.version.indexOf('AND') > -1)
				_systemType = SystemType.ANDROID;
			else if(Capabilities.playerType == "Desktop")
				_systemType = SystemType.DESKTOP;
			else
				_systemType = SystemType.WEB;
			// define dpi
			var serverString:String = unescape(Capabilities.serverString);
			_dpi = Number(serverString.split("&DP=", 2)[1]);
			
			_main.stage.addEventListener(flash.events.Event.RESIZE, onResize);
		}
		
		/** Version of Firefly SDK. */
		public static function get version():String { return "1.1"; }
		
		/** Current instance of Firefly class. */
		public static function get current():Firefly { return _current; }
		
		/** Application entry point. */
		public function get main():Sprite { return _main; }
		
		/** Width of the stage. */
		public function get stageWidth():Number { return _stageWidth; }
		
		/** Height of the stage. */
		public function get stageHeight():Number { return _stageHeight; }
		
		/** Scale factor of content. */
		public function get contentScale():Number { return _contentScale; }
		
		/** Layout context of the the application. */
		public function get layoutContext():LayoutContext { return _layoutContext; }
		
		/** Type of operating system on which runs application. */
		public function get systemType():String { return _systemType; }
		
		/** DPI of device. */
		public function get dpi():Number { return _dpi; }
		
		/** Audio mixer which manages all registered music and sounds. */
		public function get audioMixer():AudioMixer { return _audioMixer; }
		
		/** Start initialization of Firefly.
		 *  @return Future object for callback. */
		public function start():Future
		{
			_completer = new Completer();
			
			var time:uint = getTimer();
			if (time >= 1000)
				Future.nextFrame().then(timerComplete);
			else
				Future.delay((1000 - time)/1000).then(timerComplete);
			
			return _completer.future;
		}
		
		/** Set global layout of the application.
		 *  @param designWidth Design width of the application.
		 *  @param designHeight Design height of the application.
		 *  @param vAlign Vertical align of layout.
		 *  @param hAlign Horizontal align of layout. */		
		public function setLayoutContext(designWidth:Number, designHeight:Number, vAlign:String = VAlign.CENTER, hAlign:String = HAlign.CENTER):void
		{
			_layoutContext = LayoutContext.withDesignSize(designWidth, designHeight, vAlign, hAlign);
		}
		
		/** @private */
		private function timerComplete():void
		{
			_audioMixer = new AudioMixer();

			updateSize(_main.stage);
			
			_completer.complete();
		}
		
		/** @private */
		private function onResize(event:Event):void
		{
			updateSize(_main.stage);
		}
		
		/** @private 
		 *  @param stage Instance of stage.*/
		private function updateSize(stage:Stage):void
		{
			CONFIG::debug {
				if(!layoutContext)
					Log.error("Layout Context is not set. Use setGlobalLayoutContext() function to set game app design size.");
			};
			// calculate stage width/height, content and texture scales
			_stageWidth = stage.stageWidth;
			_stageHeight = stage.stageHeight;
			_contentScale = 1 / Math.max(1, Math.max(stageWidth, stageHeight) / MAX_TEXTURE_SIZE);
			_textureScale= Math.min(1 ,Math.max(stageWidth / layoutContext.designWidth, stageHeight / layoutContext.designHeight));
		}
	}
}