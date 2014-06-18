
package com.firefly.core.binding
{
import flash.utils.Dictionary;

public class Binding
	{
	    private var _type:String;
        private var _handlers:Dictionary;
	
	    public function Binding(type:String)
	    {
	        _type = type;
            _handlers = new Dictionary(true);
	    }
	
	    public function get type():String { return _type; }
	
	    public function bind(func:Function):void
	    {
            _handlers[func] = true;
	    }
	
	    public function unbind(func:Function):void
	    {
	        delete _handlers[func];
	    }

        public function unbindAll():void
        {
            _handlers = new Dictionary(true);
        }
	
	    public function notify(v:*):void
	    {
            for (var func:Object in _handlers)
            {
                func.apply(null, [v]);
            }
	    }
	}
}
