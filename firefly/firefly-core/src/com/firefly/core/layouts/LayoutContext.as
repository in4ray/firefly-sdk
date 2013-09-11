// =================================================================================================
//
//	Firefly Framework
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.layouts
{
	import com.firefly.core.Firefly;
	import com.firefly.core.utils.AlignUtil;
	import com.firefly.core.utils.Log;
	
	import flash.geom.Rectangle;
	
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	public class LayoutContext
	{
		private var _designWidth:Number;
		private var _designHeight:Number;
		private var _vAlign:String;
		private var _hAlign:String;
		private var _textureScale:Number;
		
		public function LayoutContext(vAlign:String = VAlign.CENTER, hAlign:String = HAlign.CENTER)
		{
			_hAlign = hAlign;
			_vAlign = vAlign;
		}

		public function get vAlign():String
		{
			if(!_vAlign)
			{
				CONFIG::debug {
					if(Firefly.current.layoutContext == this)
						Log.error("Design vAlign is not set.");
				};
				
				_vAlign = Firefly.current.layoutContext.vAlign;
			}
			
			return _vAlign;
		}

		public function set vAlign(value:String):void
		{
			_vAlign = value;
		}

		public function get hAlign():String
		{
			if(!_hAlign)
			{
				CONFIG::debug {
					if(Firefly.current.layoutContext == this)
						Log.error("Design hAlign is not set.");
				};
				
				_hAlign = Firefly.current.layoutContext.hAlign;
			}
			
			return _hAlign;
		}

		public function set hAlign(value:String):void
		{
			_hAlign = value;
		}

		public function get designWidth():Number
		{
			if(isNaN(_designWidth))
			{
				CONFIG::debug {
					if(Firefly.current.layoutContext == this)
						Log.error("Design width is not set.");
				};
				
				_designWidth = Firefly.current.layoutContext.designWidth;
			}
			
			return _designWidth;
		}

		public function set designWidth(value:Number):void
		{
			_designWidth = value;
		}

		public function get designHeight():Number
		{
			if(isNaN(_designHeight))
			{
				CONFIG::debug {
					if(Firefly.current.layoutContext == this)
						Log.error("Design height is not set.");
				};
				
				_designHeight = Firefly.current.layoutContext.designHeight;
			}
			
			return _designHeight;
		}

		public function set designHeight(value:Number):void
		{
			_designHeight = value;
		}
		
		public function get textureScale():Number
		{
			return _textureScale;
		}
		
		public function get dpi():Number
		{
			return Firefly.current.dpi;
		}
		
		public function getTextureRect(width:Number, height:Number, vAligh:String="", hAlign:String=""):Rectangle
		{
			if(!hAlign)
				hAlign = this.hAlign;
			
			if(!vAlign)
				vAlign = this.vAlign;
			
			var w:Number = Firefly.current.stageWidth / Firefly.current.contentScale;
			var h:Number = Firefly.current.stageHeight / Firefly.current.contentScale;
			
			var factor:Number = Math.max(w/width, h/height);
			
			var hOffset:Number = Math.min(0, AlignUtil.getHOffset(w/factor, width, hAlign)); 
			var vOffset:Number =  Math.min(0, AlignUtil.getVOffset(h/factor, height, vAlign));
			
			return new Rectangle(hOffset, vOffset, w/factor, h/factor);
		}
		
		// ########################### STATIC ########################## //
		
		public static function withDesignSize(designWidth:Number, designHeight:Number, vAlign:String = VAlign.CENTER, hAlign:String = HAlign.CENTER):LayoutContext
		{
			var context:LayoutContext = new LayoutContext();
			context.designWidth = designWidth;
			context.designHeight = designHeight;
			context.hAlign = hAlign;
			context.vAlign = vAlign;
			
			return context;
		}
	}
}