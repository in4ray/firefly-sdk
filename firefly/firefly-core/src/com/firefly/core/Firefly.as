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
	
	public class Firefly
	{
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
		
		public function Firefly(main:Sprite)
		{
			_main = main;
			_current = this;
			_defaultFrameRate = _main.stage.frameRate;
			
			if (Capabilities.version.indexOf('IOS') > -1)
				_systemType = SystemType.IOS;
			else if (Capabilities.version.indexOf('AND') > -1)
				_systemType = SystemType.ANDROID;
			else if(Capabilities.playerType == "Desktop")
				_systemType = SystemType.DESKTOP;
			else
				_systemType = SystemType.WEB;
			
			var serverString:String = unescape(Capabilities.serverString);
			_dpi = Number(serverString.split("&DP=", 2)[1]);
			
			_main.stage.addEventListener(flash.events.Event.RESIZE, resizeHandler);
		}
		
		public static function get version():String
		{
			return "1.1";
		}
		
		public static function get current():Firefly
		{
			return _current;
		}
		
		public function get main():Sprite
		{ 
			return _main; 
		}
		
		public function get stageWidth():Number
		{
			return _stageWidth;
		}
		
		public function get stageHeight():Number
		{
			return _stageHeight;
		}
		
		public function get contentScale():Number
		{
			return _contentScale;
		}
		
		public function get layoutContext():LayoutContext
		{
			return _layoutContext;
		}
		
		public function get audioMixer():AudioMixer
		{
			return _audioMixer;
		}
		
		public function get systemType():String
		{
			return _systemType;
		}
		
		public function get dpi():Number
		{
			return _dpi;
		}
		
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
		
		public function setLayoutContext(designWidth:Number, designHeight:Number, vAlign:String = VAlign.CENTER, hAlign:String = HAlign.CENTER):void
		{
			_layoutContext = LayoutContext.withDesignSize(designWidth, designHeight, vAlign, hAlign);
		}
		
		private function timerComplete():void
		{
			_audioMixer = new AudioMixer();
			
			updateSize(_main.stage);
			
			_completer.complete();
		}
		
		private function resizeHandler(event:Event):void
		{
			updateSize(_main.stage);
		}
		
		private function updateSize(stage:Stage):void
		{
			CONFIG::debug {
				if(!layoutContext)
					Log.error("Layout Context is not set. Use setGlobalLayoutContext() function to set game app design size.");
			};
			
			_stageWidth = stage.stageWidth;
			_stageHeight = stage.stageHeight;
			_contentScale = 1 / Math.max(1, Math.max(stageWidth, stageHeight) / MAX_TEXTURE_SIZE);
			_textureScale= Math.min(1 ,Math.max(stageWidth / layoutContext.designWidth, stageHeight / layoutContext.designHeight));
		}
	}
}