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
import com.firefly.core.getFunctionName;
import com.firefly.core.utils.Log;

import flash.utils.Dictionary;

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

    private function onMyPropChangeFunc(value:int):void
    {
       trace(value);
    }

    private function onMyPropChangeFunc2(value:int):void
    {
       trace(value);
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

    private function onMyPropChangeFunc(value:int):void
    {
       trace(value);
    }
} 

public class MyGameModel extends Model
{
    private var _myProp:int;

    public function MyGameModel()
    {
       super("MyGame");
	   
	   myProp = 34; // set value through the setter to save inital value in the binding
    }

    public function get onMyProp():Binding { return bindingProvider.getBinding("onMyPropChange"); }
    public function get myProp():int { return _myProp; }
    public function set myProp(value:int):void
    {
       _myProp = value;
       onMyProp.update(value);
    }
}
 *************************************************************************************
 *  </listing> */
    public class Binding
	{
		/** @private */
		private var _value:*;
		/** @private */
	    private var _name:String;
        /** @private */
        private var _handlers:Vector.<Function>;
		/** @private */
        private var _weakHandlers:Dictionary;

        /** Constructor.
         *  @param type Binding name. */
	    public function Binding(name:String)
	    {
	        _name = name;
            _handlers = new <Function>[];
	    }

        /** The binding name. */
	    public function get name():String { return _name; }
		/** Current value. */
		public function get value():* { return _value; }

        /** Bind function on changing property. This function calls after property is changed.
		 *  <p>Important!!! You can bind on the same target different functions. Required calling <code>unbind()</code> 
		 *  function to break reference on target instance and provide it for garbage collector.</p>
         *  @param func The function will called after property is changed. */
	    public function bind(func:Function):void
	    {
			if (_handlers.indexOf(func) == -1)
                _handlers.push(func);
			
			if (_value != undefined)
				func.apply(null, [_value]);
	    }
		
		/** Bind function on changing property using weak reference. This function calls after property is changed.
		 *  @param target The target that need to bind.
		 *  @param func The function will called after property is changed.
         *  @param funcName Function name. For better performance use string name of the 
		 *  function than <code>func</code> parameter. */
		public function bindWeak(target:Object, func:Function, funcName:String=""):void
		{
			if (!_weakHandlers)
                _weakHandlers = new Dictionary(true);
			if (funcName == "")
				funcName = getFunctionName(func);
			
            var funcs:Vector.<String>;
            if(!(target in _weakHandlers))
            {
				funcs = new <String>[];
                _weakHandlers[target] = funcs;
            }
            else
            {
				funcs = _weakHandlers[target];
            }
			
			if (funcs.indexOf(funcName) == -1)
				funcs.push(funcName);
			if (_value != undefined)
				target[funcName].apply(null, [_value]);
		}

        /** Unbind function to break reference on target instance and provide it for garbage collector.
         *  @param func The function to unbind. */
	    public function unbind(func:Function):void
	    {
            var index:int = _handlers.indexOf(func);
			if (index != -1)
				delete _handlers.splice(index, 1);
	    }

        /** Unbind function to break reference on target instance and provide it for garbage collector. For correct
         *  working of weak binding you should bind only public functions.
         *  @param target The target that need to unbind.
		 *  @param func The function to unbind.
         *  @param funcName Function name to unbind. For better performance use string name of the 
		 *  function than <code>func</code> parameter. */
        public function unbindWeak(target:Object, func:Function, funcName:String=""):void
        {
			if (!_weakHandlers) return;
			if (funcName == "")
				funcName = getFunctionName(func);
			
			var funcs:Vector.<String> = _weakHandlers[target];
			if (funcs)
			{
				var length:int = funcs.length;
				for (var i:int = 0; i < length; i++)
				{
					if (funcName == funcs[i])
					{
						funcs.splice(i, 1);
						break;
					}
				}
				if (funcs.length > 0) return;
			}
			
			delete _weakHandlers[target];
        }
		
        /** Unbind all binded functions. */
        public function unbindAll():void
        {
            _handlers = new <Function>[];
            if (_weakHandlers)
                _weakHandlers = new Dictionary(true);
		}

        /** Calls all binded functions and sends changed value.
         *  @param v Changed value. */
	    public function update(value:*):void
	    {
			_value = value;
			_handlers.forEach(function (func:Function, i:int, arr:Vector.<Function>):void
            {
                func.apply(null, [value]);
            });

			var funcs:Vector.<String>;
            for (var target:Object in _weakHandlers)
			{
				funcs = _weakHandlers[target];
				funcs.forEach(function (funcName:String, i:int, arr:Vector.<String>):void
				{
                    try
                    {
                        target[funcName].apply(null, [value]);
                    }
                    catch (error:Error)
                    {
                        CONFIG::debug {
                            Log.error("Function {0} is not found in the target object. For weak binding required " +
                                    "just public functions.", funcName);
                        };
                    }
				});
			}
	    }
	}
}
