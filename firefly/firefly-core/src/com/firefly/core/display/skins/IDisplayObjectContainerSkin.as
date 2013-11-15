package com.firefly.core.display.skins
{
	import starling.display.DisplayObject;

	public interface IDisplayObjectContainerSkin extends IDisplayObjectSkin
	{
		function addChild(child:DisplayObject):DisplayObject;
		function addChildAt(child:DisplayObject, index:int):DisplayObject;
		function removeChild(child:DisplayObject, dispose:Boolean=false):DisplayObject;
		function removeChildAt(index:int, dispose:Boolean=false):DisplayObject;
		function getChildAt(index:int):DisplayObject;
		function getChildIndex(child:DisplayObject):int;
		function setChildIndex(child:DisplayObject, index:int):void;
		function contains(child:DisplayObject):Boolean;
		function get numChildren():int;
	}
}