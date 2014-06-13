
package com.firefly.core.binding
{
	public class Binding
	{
	    private var _type:String;
        private var _functions:Vector.<Function>;
	    private var _func:Function;
	
	    public function Binding(type:String)
	    {
	        _type = type;
            _functions = new <Function>[];
	    }
	
	    public function get type():String { return _type; }
	
	    public function bind(func:Function):void
	    {
            _functions.push(func);
	    }
	
	    public function unbind(func:Function):void
	    {
	        var index:int = _functions.indexOf(func);
            if (index != -1)
                _functions.splice(index, 1);
	    }

        public function unbindAll():void
        {
            _functions.length = 0;
        }
	
	    public function notify(v:*):void
	    {
            _functions.forEach(function (func:Function, i:int, arr:Vector.<Function>):void
            {
                func(v);
                trace(i);
            });
	    }
	}
}
