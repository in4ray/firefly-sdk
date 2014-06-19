// =================================================================================================
//
//	Firefly Framework
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.binding
{
	import flash.utils.Dictionary;
	
	public class BindingProvider
	{
	    private var _bindings:Dictionary;
	
	    public function BindingProvider()
	    {
	        _bindings = new Dictionary();
	    }
	
	    public function getBinding(type:String):Binding
	    {
	        if(type in _bindings)
	        {
	            return _bindings[type];
	        }
	        else
	        {
	            _bindings[type] = new Binding(type);
	            return _bindings[type];
	        }
	    }
	
	    public function removeBinding(type:String):void
	    {
	        var binding:Binding = _bindings[type];
	        binding.unbindAll();
	        delete _bindings[type];
	    }
	}
}
