package com.firefly.core.display
{
	import com.firefly.core.display.skins.IDisplayObjectSkin;

	public class DisplayObject
	{
		protected var _skin:IDisplayObjectSkin;
		
		public function DisplayObject(skin:IDisplayObjectSkin)
		{
			_skin = skin;
			_skin.hostComponent = this;
		}
		
		public function get skin():IDisplayObjectSkin {	return _skin; }

		public function get x():Number { return _skin.x; }
		public function set x(value:Number):void { _skin.x = value; }
		
		public function get y():Number { return _skin.y;	}
		public function set y(value:Number):void { _skin.y = value;	}
		
		public function get width():Number { return _skin.width; }
		public function set width(value:Number):void { _skin.width = value; }
		
		public function get height():Number { return _skin.height; }
		public function set height(value:Number):void {	_skin.height = value; }
		
		public function get rotation():Number { return _skin.rotation; }
		public function set rotation(value:Number):void { _skin.rotation = value; }
		
		public function get pivotX():Number { return _skin.pivotX; }
		public function set pivotX(value:Number):void {	_skin.pivotX = value; }
		
		public function get pivotY():Number { return _skin.pivotY; }
		public function set pivotY(value:Number):void {	_skin.pivotY = value; }
		
		public function get alpha():Number { return _skin.alpha; }
		public function set alpha(value:Number):void  {	_skin.pivotY = value; }
		public function get visible():Boolean { return _skin.visible; }
		public function set visible(value:Boolean):void {	_skin.visible = value; }
		public function get touchable():Boolean { return _skin.touchable; }
		public function set touchable(value:Boolean):void {	_skin.touchable = value; }
		
		public function removeFromParent():void 
		{ 
			_skin.removeFromParent(); 
		}
	}
}