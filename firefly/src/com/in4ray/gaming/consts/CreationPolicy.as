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
	 * Creation policy types. 
	 */	
	public class CreationPolicy
	{
		/**
		 * Create instance on demand by first request and cache it. 
		 */		
		public static const ONDEMAND:String = "ondemand";
		
		/**
		 * Don't cache instance. 
		 */		
		public static const NOCACHE:String = "nocache";
		
		/**
		 * Create and cache instance immediately. 
		 */		
		public static const INIT:String = "init"; 
	}
}