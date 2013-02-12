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
	[ExcludeClass]
	
	/**
	 * Order of layout processing. 
	 */	
	public class LayoutOrder
	{
		/**
		 * For layouts that change position. 
		 */		
		public static const POSITION:Number = 0;
		
		/**
		 * For layouts that change size. 
		 */	
		public static const SIZE:Number = 10;
		
		/**
		 * For layouts first constrains. 
		 */	
		public static const FIRST_CONSTRAINS:Number = 20;
		
		/**
		 * For layouts second constrains. 
		 */	
		public static const SECOND_CONSTRAINS:Number = 30;
	}
}