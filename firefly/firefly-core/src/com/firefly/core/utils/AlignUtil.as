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
	import starling.utils.Align;

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
				case Align.CENTER:
				{
					value = (value - height)/2;	
					break;
				}
				case Align.BOTTOM:
				{
					value = value - height;	
					break;
				}
				case Align.TOP:
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
				case Align.CENTER:
				{
					value = (value - width)/2;	
					break;
				}
				case Align.RIGHT:
				{
					value = value - width;	
					break;
				}
				case Align.LEFT:
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