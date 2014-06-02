// =================================================================================================
//
//	Firefly Framework
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.layouts.helpers
{
	import com.firefly.core.Firefly;
	import com.firefly.core.firefly_internal;
	import com.firefly.core.consts.LayoutUnits;
	import com.firefly.core.utils.AlignUtil;
	import com.firefly.core.utils.Log;
	
	import flash.geom.Rectangle;
	
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	use namespace firefly_internal;
	
	/** Class that provides layout context for specified container. */	
	public class LayoutContext
	{
		/** @private */
		private var _width:Number;
		/** @private */
		private var _height:Number;
		/** @private */
		private var _designWidth:Number;
		/** @private */
		private var _designHeight:Number;
		/** @private */
		private var _vAlign:String;
		/** @private */
		private var _hAlign:String;
		
		/** Constructor.
		 *  @param container Flash or Starling container.
		 *  @param vAlign Vertical texture align.
		 *  @param hAlign Horizontal texture align. */		
		public function LayoutContext(container:Object=null, vAlign:String = VAlign.CENTER, hAlign:String = HAlign.CENTER)
		{
			if (container)
			{
				_width = container.width;
				_height = container.height;	
			}
			_hAlign = hAlign;
			_vAlign = vAlign;
		}
		
		/** Width of container */
		public function get width():Number { return isNaN(_width) ? Firefly.current.stageWidth : _width; }
		public function set width(value:Number):void { _width = value; }
		
		/** Height of container */
		public function get height():Number { return isNaN(_height) ? Firefly.current.stageHeight : _height; }
		public function set height(value:Number):void { _height = value; }
		
		/** DPI of application */
		public function get dpi():Number { return Firefly.current.dpi; }
		
		/** Scale for all textures. */
		public function get textureScale():Number { return Firefly.current.textureScale; }

		/** Vertical texture align. */		
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
		public function set vAlign(value:String):void { _vAlign = value; }

		/** Horizontal texture align. */
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
		public function set hAlign(value:String):void { _hAlign = value; }

		/** Design width of the application. */
		public function get designWidth():Number
		{
			if(isNaN(_designWidth))
			{
				CONFIG::debug {
					if(Firefly.current.layoutContext == this)
						Log.error("Design width is not set.");
				};
				
				return Firefly.current.layoutContext.designWidth;
			}
			
			return _designWidth;
		}
		public function set designWidth(value:Number):void { _designWidth = value; }

		/** Design height of the application. */
		public function get designHeight():Number
		{
			if(isNaN(_designHeight))
			{
				CONFIG::debug {
					if(Firefly.current.layoutContext == this)
						Log.error("Design height is not set.");
				};
				
				return Firefly.current.layoutContext.designHeight;
			}
			
			return _designHeight;
		}
		public function set designHeight(value:Number):void { _designHeight = value; }
		
		/** Returns texture rectangle cropped by align.
		 *  @param width Texture width.
		 *  @param height Texture height.
		 *  @param vAligh Vertical align.
		 *  @param hAlign Horizontal align.
		 *  @return Cropping rectangle. */		
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
		
		/** Converts layout value in inches to real pixels.
		 *  @param value Layout value in inches.
		 *  @return Real pixels. */		
		public function layoutInchToReal(value:Number):Number
		{
			return value*Firefly.current.dpi;
		}
		
		/** Converts layout value in percents to real pixels by X-axis.
		 *  @param value Layout value in percents.
		 *  @return Real pixels. */	
		public function layoutPctToRealByX(value:Number):Number
		{
			return value*width/100;
		}
		
		/** Converts layout value in percents to real pixels by Y-axis.
		 *  @param value Layout value in percents.
		 *  @return Real pixels. */	
		public function layoutPctToRealByY(value:Number):Number
		{
			return value*height/100;
		}
		
		/** Converts layout value in design pixels to real pixels by X-axis.
		 *  @param value Layout value in percents.
		 *  @param respectCropping Flag that indicates whether texture align offset 
		 *         should be respect during calculations.
		 *  @return Real pixels. */	
		public function layoutCpxToRealByX(value:Number, respectCropping:Boolean=false):Number
		{
			value *= textureScale;
			
			if(respectCropping)
				value += Math.min(0, AlignUtil.getHOffset(Firefly.current.stageWidth, designWidth*textureScale, hAlign)); 
			
			return value;
		}
		
		/** Converts layout value in design pixels to real pixels by Y-axis.
		 *  @param value Layout value in percents.
		 *  @param respectCropping Flag that indicates whether texture align offset 
		 *         should be respect during calculations.
		 *  @return Real pixels. */	
		public function layoutCpxToRealByY(value:Number, respectCropping:Boolean=false):Number
		{
			value *= textureScale;
			
			if(respectCropping)
				value += Math.min(0, AlignUtil.getVOffset(Firefly.current.stageHeight, designHeight*textureScale, vAlign)); 
			
			return value;
		}
		
		/** Converts real value in pixels to layout inches.
		 *  @param value Real value in pixels.
		 *  @return Layout inches. */		
		public function realToLayoutInch(value:Number):Number
		{
			return value/Firefly.current.dpi;
		}
		
		/** Converts real value in pixels to layout percents by X-axis.
		 *  @param value Real value in pixels.
		 *  @return Layout percents. */	
		public function realToLayoutPctByX(value:Number):Number
		{
			return 100*value/width;
		}
		
		/** Converts real value in pixels to layout percents by Y-axis.
		 *  @param value Real value in pixels.
		 *  @return Layout percents. */	
		public function realToLayoutPctByY(value:Number):Number
		{
			return 100*value/height;
		}
		
		/** Converts real value in pixels to layout design pixels by X-axis.
		 *  @param value Real value in pixels.
		 *  @param respectCropping Flag that indicates whether texture align offset 
		 *         should be respect during calculations.
		 *  @return Layout design pixels. */	
		public function realToLayoutCpxByX(value:Number, respectCropping:Boolean=false):Number
		{
			value /= textureScale;
			
			if(respectCropping)
				value -= Math.min(0, AlignUtil.getVOffset(Firefly.current.stageWidth, designWidth*textureScale, vAlign))*textureScale; 
			
			return value;
		}
		
		/** Converts real value in pixels to layout design pixels by Y-axis.
		 *  @param value Real value in pixels.
		 *  @param respectCropping Flag that indicates whether texture align offset 
		 *         should be respect during calculations.
		 *  @return Layout design pixels. */	
		public function realToLayoutCpxByY(value:Number, respectCropping:Boolean=false):Number
		{
			value /= textureScale;
			
			if(respectCropping)
				value -= Math.min(0, AlignUtil.getHOffset(Firefly.current.stageHeight, designWidth*textureScale, vAlign))*textureScale; 
			
			return value;
		}
		
		/** Converts layout value in specified units to real pixels by X-axis.
		 *  @param value Layout value in percents.
		 *  @param units Mesure units (px, pct, inches).
		 *  @param respectCropping Flag that indicates whether texture align offset 
		 *         should be respect during calculations.
		 *  @return Real pixels. */	
		public function layoutToRealByX(value:Number, units:String, respectCropping:Boolean=false):Number
		{
			if(units == LayoutUnits.CPX)
				return layoutCpxToRealByX(value, respectCropping);
			else if(units == LayoutUnits.PCT)
				return layoutPctToRealByX(value);
			else if (units == LayoutUnits.INCH)
				return layoutInchToReal(value);
			else
				return value;
		}
		
		/** Converts layout value in specified units to real pixels by Y-axis.
		 *  @param value Layout value in percents.
		 *  @param units Mesure units (px, pct, inches).
		 *  @param respectCropping Flag that indicates whether texture align offset 
		 *         should be respect during calculations.
		 *  @return Real pixels. */	
		public function layoutToRealByY(value:Number, units:String, respectCropping:Boolean=false):Number
		{
			if(units == LayoutUnits.CPX)
				return layoutCpxToRealByY(value, respectCropping);
			else if(units == LayoutUnits.PCT)
				return layoutPctToRealByY(value);
			else if (units == LayoutUnits.INCH)
				return layoutInchToReal(value);
			else
				return value;
		}
		
		/** Converts real pixels to layout value in specified units by X-axis.
		 *  @param value Real value pixels.
		 *  @param units Mesure units (px, pct, inches).
		 *  @param respectCropping Flag that indicates whether texture align offset 
		 *         should be respect during calculations.
		 *  @return Layout value. */	
		public function realToLayoutByX(value:Number, units:String, respectCropping:Boolean=false):Number
		{
			if(units == LayoutUnits.CPX)
				return realToLayoutCpxByX(value, respectCropping);
			else if(units == LayoutUnits.PCT)
				return realToLayoutPctByX(value);
			else if (units == LayoutUnits.INCH)
				return realToLayoutInch(value);
			else
				return value;
		}
		
		/** Converts real pixels to layout value in specified units by Y-axis.
		 *  @param value Real value pixels.
		 *  @param units Mesure units (px, pct, inches).
		 *  @param respectCropping Flag that indicates whether texture align offset 
		 *         should be respect during calculations.
		 *  @return Layout value. */	
		public function realToLayoutByY(value:Number, units:String, respectCropping:Boolean=false):Number
		{
			if(units == LayoutUnits.CPX)
				return realToLayoutCpxByY(value, respectCropping);
			else if(units == LayoutUnits.PCT)
				return realToLayoutPctByY(value);
			else if (units == LayoutUnits.INCH)
				return realToLayoutInch(value);
			else
				return value;
		}
		
		// ########################### STATIC ########################## //
		/** Create context with specified design size.
		 * 
		 * @param designWidth Design width of application.
		 * @param designHeight Design height of application.
		 * @param vAlign Vertical aligment.
		 * @param hAlign Horizontal aligment.
		 * @return Layout context object. */		
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