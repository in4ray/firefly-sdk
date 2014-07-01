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

        /** Bind function on changing property. This function calls after property is changed.
		 *  <p>Important!!! You can bind on the same target different functions. Required calling <code>unbind()</code> 
		 *  function to break reference on target instance and provide it for garbage collector.</p>
         *  @param func The function will called after property is changed. */
	    public function bind(func:Function):void
	    {
			if (_handlers.indexOf(func) == -1)
                _handlers.push(func);
	    }
		
		/** Bind function on changing property using weak reference. This function calls after property is changed.
		 *  @param target The target that need to bind.
		 *  @param func The function will called after property is changed.
         *  @param funcName Function name. For better performance use string name of the function than <code>func</code>
         *  parameter.  */
		public function bindWeak(target:Object, func:Function, funcName:String=""):void
		{
			if (!_weakHandlers)
                _weakHandlers = new Dictionary(true);

            var funcs:Vector.<String>;
			if (funcName == "")
				funcName = getFunctionName(func);
			
            if(!(target in _weakHandlers))
            {
				funcs = new <String>[];
                _weakHandlers[target] = funcs;
            }
            else
            {
				funcs =_weakHandlers[target];
            }
			
			funcs.push(funcName);
		}

        /** Unbind function to break reference on target instance and provide it for garbage collector.
         *  @param func The function to unbind. */
	    public function unbind(func:Function):void
	    {
            delete _handlers.splice(_handlers.indexOf(func), 1);
	    }

        /** Unbind function to break reference on target instance and provide it for garbage collector.
         *  @param func The function to unbind. */
        public function unbindWeak(target:Object, func:Function, funcName:String=""):void
        {
            
			
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
	    public function notify(v:*):void
	    {
            _handlers.forEach(function (func:Function, i:int, arr:Vector.<Function>):void
            {
                func.apply(null, [v]);
            });

			var funcs:Vector.<String>;
            for (var target:Object in _weakHandlers)
			{
				funcs = _weakHandlers[target];
				funcs.forEach(function (funcName:String, i:int, arr:Vector.<String>):void
				{
					target[funcName].apply(null, [v]);
				});
			}
	    }
		
		/** @private */		
		private function dispose():void
		{
			_handlers = null;
			_weakHandlers = null;
		}
	}
}
