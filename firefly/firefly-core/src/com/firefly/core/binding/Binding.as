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
/** Helper class which provides capability of binding to properties.
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
        _gameModel.onMyProp.bind(onMyPropChangeFunc);
        _gameModel.onMyProp.bind(onMyPropChangeFunc2);
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

        /** Constructor.
         *  @param type Binding name. */
	    public function Binding(name:String)
	    {
	        _name = name;
            _handlers = new <Function>[];
	    }

        /** Binding name. */
	    public function get name():String { return _name; }

        /** Bind function on changing property. This function calls when property is changed.
         *  @param func Function. */
	    public function bind(func:Function):void
	    {
            _handlers.push(func);
	    }

        /** Unbind function from changing property.
         *  @param func Function. */
	    public function unbind(func:Function):void
	    {
            _handlers.splice(_handlers.indexOf(func), 1);
	    }

        /** Unbind all binded functions. */
        public function unbindAll():void
        {
            _handlers = new <Function>[];
        }

        /** Calls all binded functions and sends changed value as parameter.
         *  @param v New value. */
	    public function notify(v:*):void
	    {
            _handlers.forEach(function (func:Function, i:int, arr:Vector.<Function>):void
            {
                func.apply(null, [v]);
            });
	    }
	}
}
