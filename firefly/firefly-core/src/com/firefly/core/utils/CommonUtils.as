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
	import flash.utils.Dictionary;

	/** Class for common utilities. */	
	public class CommonUtils
	{
		/** Is dictionary empty.
		 *  @param dictionary Dictionary to be checked.
		 *  @return true if dictionary is empty.*/	
		public static function isEmptyDict(dictionary:Dictionary):Boolean
		{
			for each (var value:Object in dictionary) 
			{
				return false;
			}
			
			return true;
		}
	}
}