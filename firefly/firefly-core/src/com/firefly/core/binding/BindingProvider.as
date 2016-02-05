// =================================================================================================
//
//	Firefly Framework
//	Copyright 2016 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.binding
{
	import com.firefly.core.utils.WeakRef;
	
	import flash.utils.Dictionary;
	
	/** Class for providing binding capability.
	 *
	 *  @see com.firefly.core.binding.Binding
	 *
	 *  @example The following code shows how to use this class:
	 *  <listing version="3.0">
	 *************************************************************************************
public class MyClass extends Sprite
{
private var _bindingProvider:BindingProvider;
 
	public function MyClass()
	{
		_bindingProvider = new BindingProvider();
	}
	 
    public function get bindingProvider():BindingProvider { return _bindingProvider; }
	 
	public function get onMyProp():Binding { return _bindingProvider.getBinding("onMyPropChange"); }

    public function get myProp():int { return _myProp; }
    public function set myProp(value:int):void
    {
       _myProp = value;
       onMyProp.notify(value);
    }
}
	 *************************************************************************************
	 *  </listing> */
	public class BindingProvider
	{
		/** @private */
	    private var _bindings:Dictionary;
	
		/** Constructor. */		
	    public function BindingProvider()
	    {
	        _bindings = new Dictionary();
	    }
	
		/** Return binding instance by name. The instance of <code>Binding</code> class will be initiated after first call
		 *  of the function.
		 *  @param name The name of the binding.
		 *  @return Binding instance. */		
	    public function getBinding(name:String):Binding
	    {
	        if(name in _bindings)
	        {
	            return _bindings[name];
	        }
	        else
	        {
				var binding:Binding = new WeakRef(new Binding(name)).get();
				_bindings[name] = binding;
				return binding;
	        }
	    }
	
		/** Remove binding instance from the provider.
		 *  @param name The name of the binding. */
	    public function removeBinding(name:String):void
	    {
	        delete _bindings[name];
	    }
	}
}
