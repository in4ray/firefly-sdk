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
	import com.firefly.core.firefly_internal;
	
	import flash.utils.Dictionary;

	use namespace firefly_internal;
	public class Registry
	{
		private static const faces:Dictionary = new Dictionary();
		firefly_internal static function regFace(face:Class, impl:Class):void
		{
			faces[face] = impl;
		}
		
		public static function getImpl(face:Class):Class
		{
			return faces[face];
		}
	}
}