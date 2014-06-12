
package com.firefly.core.binding
{
public class Binding
{
    private var _type:String;
    private var _func:Function;

    public function Binding(type:String)
    {
        _type = type;
    }

    public function get type():String { return _type; }

    public function bind(func:Function):void
    {
       _func = func;
    }

    public function unbind():void
    {
        _func = null;
    }

    public function notify(v:*):void
    {
        _func(v);
    }
}
}
