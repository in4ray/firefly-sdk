// =================================================================================================
//
//	in4ray Gaming SDK
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.in4ray.gaming.layouts
{
	/**
	 * Inaterface for layouts that uses measure units. 
	 */	
	public interface ILayoutUnits
	{
		/**
		 * Sets pixels units. 
		 */		
		function get px():ILayout;
		
		/**
		 * Sets percents units. 
		 */
		function get pct():ILayout;
		
		/**
		 * Sets inches units. 
		 */
		function get inch():ILayout;
		
		/**
		 * Sets absolute texture pixel units. 
		 */
		function get acpx():ILayout;
		
		/**
		 * Sets relative texture pixel units. 
		 */
		function get rcpx():ILayout;
	}
}