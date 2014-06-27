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
	
	/** Helper class which provides capabilty of creating weak reference to the object. */	
	public class WeakRef
	{
		/** @private */		
	    private var _ref:Dictionary;
	
		/** Constructor. 
		 *  @param obj Object for which need to create weak reference. */		
	    public function WeakRef(obj:*)
	    {
	        _ref = new Dictionary(true);
	        _ref[obj] = true;
	    }
	
		/** Return instance with weak reference.
		 *  @return Instance of the object. */		
	    public function get():*
	    {
	        for (var item:* in _ref )
	        {
	            return item;
	        }
	        return null;
	    }
	}
}
