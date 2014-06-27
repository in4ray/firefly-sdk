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
import com.firefly.core.firefly_internal;
import com.firefly.core.getFunctionName;

import flash.utils.Dictionary;

import avmplus.getQualifiedClassName;

/** Helper class which provides capability of binding.
 *
 *  @see com.firefly.core.binding.BindingProvider
 *
 *  @example The following code shows how to use binding functionality:
 *  <listing version="3.0">
 *************************************************************************************
public class MyViewClass extends Sprite
{
    private var _gameModel:MyGameModel;

    public function MyViewClass()
    {
       _gameModel = new MyGameModel(); // get singleton
       _gameModel.onMyProp.bind(this, onMyPropChangeFunc);
       _gameModel.onMyProp.bind(this, onMyPropChangeFunc2);
    }

    private function onMyPropChangeFunc(v:int):void
    {
       trace(v);
    }

    private function onMyPropChangeFunc2(v:int):void
    {
       trace(v);
    }
}

public class MyViewClass2 extends Sprite
{
    private var _gameModel:MyGameModel;

    public function MyViewClass2()
    {
       _gameModel = new MyGameModel(); // get singleton
       _gameModel.onMyProp.bindWeak(this, onMyPropChangeFunc); // you can bind just one function in one class for using weak reference
    }

    private function onMyPropChangeFunc(v:int):void
    {
       trace(v);
    }
} 

public class MyGameModel extends Model
{
    private var _myProp:int = 0;

    public function MyGameModel()
    {
       super("MyGame");
    }

    public function get onMyProp():Binding { return bindingProvider.getBinding("onMyPropChange"); }

    public function get myProp():int { return _myProp; }
    public function set myProp(v:int):void
    {
       _myProp = v;
       onMyProp.notify(v);
    }
}
 *************************************************************************************
 *  </listing> */
    public class Binding
	{
        /** @private */
	    private var _name:String;
        /** @private */
        private var _handlers:Dictionary;
		/** @private */
        private var _weakHandlers:Dictionary;
		/** @private */
        private var _provider:BindingProvider;

        /** Constructor.
         *  @param type Binding name. */
	    public function Binding(name:String)
	    {
	        _name = name;
            _handlers = new Dictionary();
			_weakHandlers = new Dictionary(true);
	    }
		
		firefly_internal function set provider(v:BindingProvider):void { _provider = v; };

        /** The binding name. */
	    public function get name():String { return _name; }

        /** Bind function on changing property. This function calls after property is changed.
		 *  <p>Important!!! You can bind on the same target different functions. Required calling <code>unbind()</code> 
		 *  function to break reference on target instance and provide it for garbage collector.</p>
		 *  @param target The target that need to bind.
         *  @param func The function will called after propety is changed. */
	    public function bind(target:Object, func:Function):void
	    {
			_handlers[getKey(target, func)] = func;
	    }
		
		/** Bind function on changing property using weak reference. This function calls after property is changed.
		 *  <p>Important!!! You can bind in the same target only one function. By using this function you don't need 
		 *  to call any unbind functions to free the memory.</p>
		 *  @param target The target that need to bind.
		 *  @param func The function will called after propety is changed. */
		public function bindWeak(target:Object, func:Function):void
		{
			_weakHandlers[target] = getFunctionName(func);
		}

        /** Unbind function to break reference on target instance and provide it for garbage collector.
		 *  @param target The target that need to unbind.
         *  @param func The function to unbind. */
	    public function unbind(target:Object, func:Function):void
	    {
            delete _handlers[getKey(target, func)];
			
			if (_provider)
			{
				var key:Object;
				var n:int = 0;
				for (key in _handlers) { n++; }
				for (key in _weakHandlers) { n++; }
				if (n == 0)
					dispose();
			}
	    }
		
        /** Unbind all binded functions. */
        public function unbindAll():void
        {
			if (_provider)
			{
				dispose();
			}
			else
			{
				_handlers = new Dictionary();
				_weakHandlers = new Dictionary(true);
			}
		}

        /** Calls all binded functions and sends changed value.
         *  @param v Changed value. */
	    public function notify(v:*):void
	    {
			var key:Object;
			for (key in _handlers)
            {
                _handlers[key].apply(null, [v]);
            }
			for (key in _weakHandlers)
			{
				key[_weakHandlers[key]].apply(null, [v]);
			}
	    }
		
		/** @private
		 *  Generate ky for dictionary based on target class name and function name.
		 *  @param target Target to get class name.
		 *  @param func Function to get function name.
		 *  @return Generated key. */		
		private function getKey(target:Object, func:Function):String
		{
			return getQualifiedClassName(target) + "_" + getFunctionName(func);
		}
		
		/** @private */		
		private function dispose():void
		{
			_provider.removeBinding(_name);
			_handlers = null;
			_weakHandlers = null;
			_provider = null;
		}
	}
}
