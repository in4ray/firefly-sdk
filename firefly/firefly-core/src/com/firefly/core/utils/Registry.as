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
	
	/** Register implementation for interface. */	
	public class Registry
	{
		private static const _faces:Dictionary = new Dictionary();
		
		/** Register implementation for interface.
		 *  @param face Interface.
		 *  @param impl Implementation.*/		
		firefly_internal static function regFace(face:Class, impl:Class):void
		{
			_faces[face] = impl;
		}
		
		// ########################### STATIC ########################## //
		
		/** Get implementation by interface.
		 *  @param face Inteface.
		 *  @return Implementation. */		
		public static function getImpl(face:Class):Class
		{
			return _faces[face];
		}
	}
}