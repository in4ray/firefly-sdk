package com.in4ray.particle.journey.screens
{
	import com.firefly.core.components.ParallaxContainer;
	import com.firefly.core.components.Quad;
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
			
			parallaxContainer = new ParallaxContainer();
			parallaxContainer.vScrollEnabled = false;
			layout.addElement(parallaxContainer, $top(310).cpx, $left(50).cpx, $width(700).cpx, $height(600).cpx);
			
			var viewport4:Viewport = new Viewport();
			viewport4.layout.addElement(new Image(new GameTextures().city4));
			var viewport3:Viewport = new Viewport();
			viewport3.layout.addElement(new Image(new GameTextures().city3));
			var viewport2:Viewport = new Viewport();
			viewport2.layout.addElement(new Image(new GameTextures().city2));
			var viewport1:Viewport = new Viewport();
			viewport1.layout.addElement(new Image(new GameTextures().city1));
			
			parallaxContainer.addViewport(viewport4, $bottom(0), $x(0), $width(790).cpx);
			parallaxContainer.addViewport(viewport3, $bottom(0), $x(0), $width(900).cpx);
			parallaxContainer.addViewport(viewport2, $bottom(0));
			parallaxContainer.addViewport(viewport1, $bottom(0));
			
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