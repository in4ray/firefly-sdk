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
	import avmplus.getQualifiedClassName;

	/** Utility class that helps to work with strings. */	
	public class StringUtil
	{
		/** Interpolate string with arguments.
		 *  @param msg String message need to interpolate. 
		 *  @param args Array of arguments.
		 *  @return Interpolated string. */	
		public static function interpolateSting(msg:String, args:Array):String
		{
			for (var i:int = 0; i < args.length; i++) 
			{
				msg = msg.replace(new RegExp("\\{"+i+"\\}", "g"), args[i]);
			}
			
			return msg;
		}
		
		/** Get class name. 
		 *  @param value Class or instance.
		 *  @return name of class without packages */		
		public static function getClassName(value:*):String
		{
			return getQualifiedClassName(value).split("::")[1];
		}
		
		/** Add zeroes at the begining of the string for number.
		 *  @param value Number to add zeroes.
		 *  @param places Specifies how many places for result string are reserved.
		 *  @return Result string. */		
		public static function leadingZero(value:Number, places:int):String
		{
			var str:String = value.toString();
			while (str.length < places) 
			{
				str = '0' + str;
			}
			return str;
		}
		
		/** Add spaces at the begining/ending of the string.
		 *  @param value String to make fixed size.
		 *  @param places Specifies how many places for result string are reserved.
		 *  @return Result string. */
		public static function fixedSize(value:String, places:int):String
		{
			var left:int = (value.length+places)/2;
			while (value.length < left) 
			{
				value = ' ' + value;
			}
			
			while (value.length < places) 
			{
				value = value + ' ';
			}
			
			return value;
		}
	}
}