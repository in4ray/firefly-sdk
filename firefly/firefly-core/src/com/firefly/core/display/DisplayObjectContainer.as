package com.firefly.core.display
{
	import com.firefly.core.display.skins.IDisplayObjectContainerSkin;
	import com.firefly.core.display.skins.IDisplayObjectSkin;
	
	import starling.display.DisplayObject;
	
	public class DisplayObjectContainer extends com.firefly.core.display.DisplayObject
	{
		public function DisplayObjectContainer(skin:IDisplayObjectContainerSkin)
		{
			super(skin);
		}
		
		public function get skinContainer():IDisplayObjectContainerSkin 
		{ 
			return _skin as IDisplayObjectContainerSkin; 
		}
		
		public function addChild(child:com.firefly.core.display.DisplayObject):com.firefly.core.display.DisplayObject
		{
			skinContainer.addChild(child.skin as starling.display.DisplayObject);
			return child;
		}
		
		public function addChildAt(child:com.firefly.core.display.DisplayObject, index:int):com.firefly.core.display.DisplayObject
		{
			skinContainer.addChildAt(child.skin as starling.display.DisplayObject, index);
			return child;
		}
		
		public function removeChild(child:com.firefly.core.display.DisplayObject, dispose:Boolean=false):com.firefly.core.display.DisplayObject
		{
			skinContainer.removeChild(child.skin as starling.display.DisplayObject);
			return child;
		}
		
		public function removeChildAt(index:int, dispose:Boolean=false):com.firefly.core.display.DisplayObject
		{
			var child:IDisplayObjectSkin = skinContainer.removeChildAt(index, dispose) as IDisplayObjectSkin;
			return child ? child.hostComponent : null;
		}
		
		public function getChildAt(index:int):com.firefly.core.display.DisplayObject
		{
			var child:IDisplayObjectSkin = skinContainer.getChildAt(index) as IDisplayObjectSkin;
			return child ? child.hostComponent : null;
		}
		
		public function getChildIndex(child:com.firefly.core.display.DisplayObject):int
		{
			return skinContainer.getChildIndex(child.skin as starling.display.DisplayObject);
		}
		
		public function setChildIndex(child:com.firefly.core.display.DisplayObject, index:int):void
		{
			skinContainer.setChildIndex(child.skin as starling.display.DisplayObject, index);
		}
		
		public function contains(child:com.firefly.core.display.DisplayObject):Boolean
		{
			return skinContainer.contains(child.skin as starling.display.DisplayObject);
		}
		
		public function get numChildren():int
		{
			return skinContainer.numChildren();
		}
	}
}