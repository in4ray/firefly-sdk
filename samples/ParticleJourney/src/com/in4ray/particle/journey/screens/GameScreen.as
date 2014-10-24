package com.in4ray.particle.journey.screens
{
	import com.firefly.core.components.ParallaxContainer;
	import com.firefly.core.components.Screen;
	import com.firefly.core.components.ScrollerContainer;
	import com.firefly.core.components.Viewport;
	import com.firefly.core.layouts.constraints.$bottom;
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
		private var parallaxContainer:ParallaxContainer;
		
		
		public function GameScreen()
		{
			super();
			
			/*addChild(new Image(new CommonTextures().human));*/
			scroller = new ScrollerContainer(null, $width(1000).cpx, $height(1000).cpx);
			scroller.hScrollerCtrl.scrollPullingEnabled = true;
			scroller.vScrollerCtrl.scrollPullingEnabled = true;
			layout.addElement(scroller, $top(50).cpx, $left(50).cpx, $width(300).cpx, $height(300).cpx);
			
			var image:Image = new Image(new GameTextures().companyLogo);
			scroller.addElement(image, $x(0), $y(0));
			
			var viewport4:Viewport = new Viewport("layer4");
			
			parallaxContainer = new ParallaxContainer();
			parallaxContainer.vScrollEnabled = false;
			parallaxContainer.addViewport(viewport4, $bottom(0), $x(0), $width(790).cpx);
			parallaxContainer.addViewport(new Viewport("layer3"), $bottom(0), $x(0), $width(900).cpx);
			/*parallaxContainer.addViewport(new Viewport("layer2"));
			parallaxContainer.addViewport(new Viewport("layer1"));*/
			parallaxContainer.addElement("layer4", new Image(new GameTextures().city4));
			parallaxContainer.addElement("layer3", new Image(new GameTextures().city3));
			/*parallaxContainer.addElement("layer2", new Image(new GameTextures().city2));
			parallaxContainer.addElement("layer1", new Image(new GameTextures().city1));*/
			layout.addElement(parallaxContainer, $top(310).cpx, $left(50).cpx, $width(700).cpx, $height(600).cpx);
			
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