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
	/** Logging util class to log information, warning and error messages with Firefly tag. */	
	public class Log
	{
		/** Log warning message. 
		 *  @param text Message string.
		 *  @param args Arguments to interpolate string. */		
		public static function warn(text:String, ...args):void
		{
			try	
			{
				throw Error("[Firefly]  WARN:  \"" + StringUtil.interpolateSting(text, args) + "\"");
			} 
			catch(error:Error){	trace(error.getStackTrace());}
		}
		
		/** Log error message. 
		 *  @param text Message string.
		 *  @param args Arguments to interpolate string. */
		public static function error(text:String, ...args):void
		{
			try	
			{
				throw Error("[Firefly] ERROR: \"" + StringUtil.interpolateSting(text, args) + "\"");
			} 
			catch(error:Error){	trace(error.getStackTrace());}
		}
		
		/** Log information message. 
		 *  @param text Message string.
		 *  @param args Arguments to interpolate string. */
		public static function info(text:String, ...args):void
		{
			trace("[Firefly]  INFO: \"" + StringUtil.interpolateSting(text, args) + "\"");
		}
	}
}