package com.firefly.core.components
{
	import com.firefly.core.display.IView;
	
	public class View extends Component implements IView
	{
		public function show(data:Object=null):void { }
		
		public function hide():void { }

		public function dialogAppeared(dialog:IView):void { }
	}
}