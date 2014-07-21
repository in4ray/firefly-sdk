package com.firefly.core.components
{
	import com.firefly.core.display.IView;
	import com.firefly.core.layouts.constraints.LayoutConstraint;
	
	public class View extends Container implements IView
	{
		private var _layouts:Array = [];
		
		public function show(data:Object=null):void
		{
		}
		
		public function hide():void
		{
		}
		
		public function addLayout(layout:LayoutConstraint, ...layouts):void
		{
			_layouts.push(layout);
			for each (layout in layouts) 
			{
				_layouts.push(layout);
			}
		}
		
		public function get layouts():Array { return _layouts; }
	}
}