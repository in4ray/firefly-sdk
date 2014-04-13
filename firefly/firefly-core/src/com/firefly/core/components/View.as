package com.firefly.core.components
{
	import com.firefly.core.display.IView;
	import com.firefly.core.layouts.Layout;
	
	import starling.display.Sprite;
	
	public class View extends Sprite implements IView
	{
		private var _width:Number;
		private var _height:Number;
		private var _layout:Layout;
		
		/** Constructor.
		 *  @param layout Layout which be used to positioning elements. */	
		public function View(layout:Layout = null)
		{
			super();
			
			if (layout)
				_layout = layout;
			else
				_layout = new Layout(this);
		}
		
		/** @inheritDoc */
		override public function get width():Number { return !isNaN(_width) ? _width : super.width; }
		override public function set width(value:Number):void { _width = value; }
		/** @inheritDoc */
		override public function get height():Number { return !isNaN(_height) ? _height : super.height; }
		override public function set height(value:Number):void { _height = value; }
		
		/** Layout for positioning elements. */
		public function get layout():Layout { return _layout; }
		
		/** Update geometry of all elements in the container bases on layout. */
		public function updateLayout():void
		{
			_layout.layout();
		}
		
		
		public function show(data:Object=null):void
		{
		}
		
		public function hide():void
		{
		}
	}
}