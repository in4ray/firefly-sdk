// =================================================================================================
//
//	Firefly Framework
//	Copyright 2016 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.utils
{
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	/** Utility class that helps to allign values e.g. align background textures. */	
	public class AlignUtil
	{
		/** Compute vertical aligment offset.
		 *  @param value Height of target to be shifted.
		 *  @param height Height of container.
		 *  @param vAlign Vertical align type.
		 *  @return Shift value. */		
		public static function getVOffset(value:Number, height:Number, vAlign:String):Number
		{
			switch(vAlign)
			{
				case VAlign.CENTER:
				{
					value = (value - height)/2;	
					break;
				}
				case VAlign.BOTTOM:
				{
					value = value - height;	
					break;
				}
				case VAlign.TOP:
				{
					value = 0;	
					break;
				}
					
				default:
				{
					break;
				}
			}
			
			return value;
		}
	
		/** Compute horizontal aligment offset.  
		 *  @param value Width of target to be shifted.
		 *  @param width Width of container.
		 *  @param hAlign Horizontal align type.
		 *  @return Shift value. */	
		public static function getHOffset(value:Number, width:Number, hAlign:String):Number
		{
			switch(hAlign)
			{
				case HAlign.CENTER:
				{
					value = (value - width)/2;	
					break;
				}
				case HAlign.RIGHT:
				{
					value = value - width;	
					break;
				}
				case HAlign.LEFT:
				{
					value = 0;	
					break;
				}	
				default:
				{
					break;
				}
			}
			
			return value;
		}
	}
}