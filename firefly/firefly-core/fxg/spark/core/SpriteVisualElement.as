// =================================================================================================
//
//	Firefly Framework
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package spark.core
{
	import flash.display.Sprite;
	
	/** FXG display object. */	
	public class SpriteVisualElement extends Sprite
	{
		private var _width:Number;
		private var _height:Number;
		
		/** Original height of FXG. */		
		public var viewHeight:Number;
		
		/** Original width of FXG */	
		public var viewWidth:Number;
		
		/** Constructor. */		
		public function SpriteVisualElement() 
		{
			super();
		}
		
		/** @inheritDoc */		
		override public function get width():Number { return !isNaN(_width) ? _width : viewWidth; }
		override public function set width(value:Number):void 
		{ 
			_width = value; 
			scaleX = scaleY = Math.max(width/viewWidth, height/viewHeight);
		}
		
		/** @inheritDoc */		
		override public function get height():Number { return !isNaN(_height) ? _height : viewHeight; }
		override public function set height(value:Number):void 
		{ 
			_height = value; 
			scaleX = scaleY = Math.max(width/viewWidth, height/viewHeight);
		}
	}
}