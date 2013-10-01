package test.layouts.helpers
{
	import starling.display.Sprite;
	
	public class Container extends Sprite
	{
		public function Container(w:Number, h:Number)
		{
			super();
			_height = h;
			_width = w;
		}
		
		private var _height:Number;
		override public function get height():Number
		{
			return _height;
		}
		
		override public function set height(value:Number):void
		{
			_height = value;
		}
		
		private var _width:Number;
		override public function get width():Number
		{
			return _width;
		}
		
		override public function set width(value:Number):void
		{
			_width = value;
		}
		
		
	}
}