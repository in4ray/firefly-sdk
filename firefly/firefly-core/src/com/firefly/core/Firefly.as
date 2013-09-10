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
	import com.firefly.core.audio.AudioMixer;
	import com.firefly.core.layouts.LayoutContext;
	import com.firefly.core.utils.Log;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	use namespace firefly_internal;
	public class Firefly
	{
		public static const MAX_TEXTURE_SIZE:Number = 2048;

		public static function get version():String
		{
			return "1.1";
		}
		
		firefly_internal static var _current:Firefly;
		public static function get current():Firefly
		{
			return _current;
		}
		
		public function Firefly(main:Sprite)
		{
			_main = main;
			_current = this;
			_audioMixer = new AudioMixer();
		}
		
		private var _main:Sprite;
		public function get main():Sprite
		{ 
			return _main; 
		}
		
		private var _width:Number;
		public function get width():Number
		{
			return _width;
		}
		
		private var _height:Number;
		public function get height():Number
		{
			return _height;
		}
		
		private var _contentScale:Number;
		public function get contentScale():Number
		{
			return _contentScale;
		}
		
		private var _layoutContext:LayoutContext;
		public function get layoutContext():LayoutContext
		{
			return _layoutContext;
		}
		
		public function setLayoutContext(designWidth:Number, designHeight:Number, vAlign:String = VAlign.CENTER, hAlign:String = HAlign.CENTER):void
		{
			Firefly.current._layoutContext = LayoutContext.withDesignSize(designWidth, designHeight, vAlign, hAlign);
		}
		
		
		firefly_internal function updateSize(stage:Stage):void
		{
			CONFIG::debug {
				if(!layoutContext)
					Log.error("Layout Context is not set.");
			};
				
			_width = stage.stageWidth;
			_height = stage.stageHeight;
			_contentScale = 1 / Math.max(1, Math.max(width, height) / MAX_TEXTURE_SIZE);
			_textureScale= Math.min(1 ,Math.max(width / layoutContext.designWidth, height / layoutContext.designHeight));
		}
		
		public var os:String;
		
		firefly_internal var _textureScale:Number;
		
		private var _audioMixer:AudioMixer;

		public function get audioMixer():AudioMixer
		{
			return _audioMixer;
		}
	}
}