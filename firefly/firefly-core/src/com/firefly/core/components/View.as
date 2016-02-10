package com.firefly.core.components
{
	import com.firefly.core.display.IView;
	
	public class View extends Component implements IView
	{
		/** @inheritDoc */		
		public function set viewData(data:Object):void { }
		
		/** @inheritDoc */
		public function show():void { }
		
		/** @inheritDoc */
		public function hide():void { }
	}
}