package com.in4ray.particle.journey.screens
{
	import com.firefly.core.components.View;
	
	import starling.display.Quad;
	
	public class LoadingScreen extends View
	{
		private var q:Quad;
		
		public function LoadingScreen()
		{
			super();
			
			q = new Quad(1, 1, 0);
			addChild(q);
		}
		
		override public function show(data:Object=null):void
		{
			trace(height)
			q.width = width;
			q.height = height;
		}
	}
}