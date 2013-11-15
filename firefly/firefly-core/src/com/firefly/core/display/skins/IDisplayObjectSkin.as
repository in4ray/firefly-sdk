package com.firefly.core.display.skins
{
	import com.firefly.core.display.DisplayObject;
	
	import starling.events.Event;

	public interface IDisplayObjectSkin
	{
		function get x():Number;
		function set x(value:Number):void;
		function get y():Number;
		function set y(value:Number):void;
		function get width():Number;
		function set width(value:Number):void;
		function get height():Number;
		function set height(value:Number):void;
		function get rotation():Number;
		function set rotation(value:Number):void;
		function get pivotX():Number;
		function set pivotX(value:Number):void;
		function get pivotY():Number;
		function set pivotY(value:Number):void;
		function get alpha():Number
		function set alpha(value:Number):void 
		function get visible():Boolean;
		function set visible(value:Boolean):void;
		function get touchable():Boolean;
		function set touchable(value:Boolean):void;
		
		function removeFromParent():void;
		function get hostComponent():DisplayObject;
		function set hostComponent(host:DisplayObject):void;
		
		function addEventListener(type:String, listener:Function):void;
		function removeEventListener(type:String, listener:Function):void;
		function hasEventListener(type:String):Boolean;
	}
}