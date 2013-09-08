// =================================================================================================
//
//	Firefly Framework
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.utils
{
	public class Log
	{
		public static function warn(text:String, ...args):void
		{
			try	
			{
				throw Error("[Firefly]  WARN:  \"" + StringUtil.interpolateSting(text, args) + "\"");
			} 
			catch(error:Error){	trace(error.getStackTrace());}
		}
		
		public static function error(text:String, ...args):void
		{
			try	
			{
				throw Error("[Firefly] ERROR: \"" + StringUtil.interpolateSting(text, args) + "\"");
			} 
			catch(error:Error){	trace(error.getStackTrace());}
		}
		
		public static function info(text:String, ...args):void
		{
			trace("[Firefly]  INFO: \"" + StringUtil.interpolateSting(text, args) + "\"");
		}
	}
}