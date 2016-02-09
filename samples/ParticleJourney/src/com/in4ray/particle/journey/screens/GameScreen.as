package com.in4ray.particle.journey.screens
{
	import com.firefly.core.components.ParallaxContainer;
	import com.firefly.core.components.Screen;
	import com.firefly.core.components.ScrollerContainer;
	import com.firefly.core.components.Viewport;
	import com.firefly.core.layouts.constraints.$height;
	import com.firefly.core.layouts.constraints.$left;
	import com.firefly.core.layouts.constraints.$top;
	import com.firefly.core.layouts.constraints.$width;
	import com.in4ray.particle.journey.globals.$txt;
	
	import starling.display.Image;
	import starling.textures.Texture;
	
	public class GameScreen extends Screen
	{
		private var scroller:ScrollerContainer;
		private var parallaxContainer:ParallaxContainer;
		
		
		public function GameScreen()
		{
			super();
			
			
			var img:Image = new Image($txt.playBtn);
			
			scroller = new ScrollerContainer(null, Texture.fromColor(30, 30, 0xff000000));
			scroller.vScrollPullingEnabled = true;
			scroller.setViewport(new Viewport());
			scroller.addElement(img, $width(500).cpx, $height(500).cpx);
			layout.addElement(scroller, $left(50).cpx, $top(50).cpx, $height(200).cpx, $width(200).cpx);
		}
	}
}