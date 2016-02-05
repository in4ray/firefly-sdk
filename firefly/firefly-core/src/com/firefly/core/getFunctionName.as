// =================================================================================================
//
//	Firefly Framework
//	Copyright 2016 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core
{
	import flash.sampler.getSavedThis;
	import flash.utils.describeType;

	/** Global function that returns function name.
	 *  @param func Function to get its name.
	 *  @return Function name. */
	public function getFunctionName(func:Function):String
	{
		var obj:Object = getSavedThis(func);
		var methods:XMLList = describeType(obj)..method.@name;
		var funcName:String;
		for each (funcName in methods)
		{
			if (obj.hasOwnProperty(funcName) && obj[funcName] != null && obj[funcName] === func)
				break;
		}
		
		return funcName;
	}
}

