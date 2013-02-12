// =================================================================================================
//
//	in4ray Gaming SDK
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.in4ray.gaming.consts
{
	/**
	 * Layout measure units. 
	 */	
	public class LayoutUnits
	{
		/**
		 * Pixels. 
		 */
		public static const PX:String = "px";
		
		/**
		 * Percents from container size. 
		 */		
		public static const PCT:String = "pct";
		
		/**
		 * Inches (detects device DPI and calculates corresponding value). 
		 */		
		public static const INCH:String = "inch";
		
		/**
		 * Absolute context pixels (depends on layout context) 
		 */		
		public static const ACPX:String = "acpx";
		
		/**
		 * Relative context pixels (depends on layout context) 
		 */		
		public static const RCPX:String = "rcpx";
	}
}