/**
 * Created by rzarich on 12.06.14.
 */
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
