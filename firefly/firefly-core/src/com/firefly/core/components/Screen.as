package com.firefly.core.components
{
	import com.firefly.core.Firefly;
	import com.firefly.core.display.IScreen;
	
	public class Screen extends View implements IScreen
	{
		public function Screen()
		{
			super();
			
			width = Firefly.current.stageWidth;
			height = Firefly.current.stageHeight;
		}
	}
}