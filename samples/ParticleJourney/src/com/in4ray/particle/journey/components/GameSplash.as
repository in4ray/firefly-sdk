package com.in4ray.particle.journey.components
{
	import com.firefly.core.components.Splash;
	import com.firefly.core.display.IView;
	
	public class GameSplash extends Splash implements IView
	{
		public function GameSplash()
		{
			super();
		}
		
		public function hide():void
		{
		
		}
		
		public function show(data:Object=null):void
		{
			graphics.clear();
			graphics.beginFill(0);
			graphics.drawRect(0,0,width,height);
			graphics.endFill()
		}
	}
}