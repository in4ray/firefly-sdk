// =================================================================================================
//
//	Firefly Framework
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.tests
{
	public class Utility
	{
		public static function formatString(value:String, length:int = 60):String
		{
			while(value.length < length)
			{
				value += " ";
			}
			
			return value;
		}
		
	}
}