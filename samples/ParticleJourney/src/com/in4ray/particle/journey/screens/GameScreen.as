package com.in4ray.particle.journey.screens
{
	import com.firefly.core.components.Screen;
	import com.firefly.core.components.ScrollerContainer;
	import com.firefly.core.layouts.constraints.$height;
	import com.firefly.core.layouts.constraints.$left;
	import com.firefly.core.layouts.constraints.$top;
	import com.firefly.core.layouts.constraints.$width;
	import com.firefly.core.layouts.constraints.$x;
	import com.firefly.core.layouts.constraints.$y;
	import com.in4ray.particle.journey.textures.GameTextures;
	
	import starling.display.Image;
	import starling.events.EnterFrameEvent;
	
	public class GameScreen extends Screen
	{
		private var scroller:ScrollerContainer;
		
		
		public function GameScreen()
		{
			super();
			
			/*addChild(new Image(new CommonTextures().human));*/
			scroller = new ScrollerContainer();
			layout.addElement(scroller, $top(50).cpx, $left(50).cpx, $width(300).cpx, $height(300).cpx);
			
			var image:Image = new Image(new GameTextures().companyLogo);
			scroller.addElement(image, $x(0), $y(0));
		}
		
		private function onEnterFrameHandler(e:EnterFrameEvent):void
		{
		}
		
		
		override public function show(data:Object=null):void
		{
		}
		
		override public function hide():void
		{
		}
	}
}