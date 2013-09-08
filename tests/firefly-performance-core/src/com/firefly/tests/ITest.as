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
	public interface ITest
	{
		function run():void;
		
		function toString():String;
		
		function get duration():Number;
	}
}