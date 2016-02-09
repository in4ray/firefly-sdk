package com.in4ray.particle.journey.splash
{
	import com.firefly.core.components.Splash;
	import com.firefly.core.display.IView;
	import com.firefly.core.layouts.constraints.$bottom;
	import com.firefly.core.layouts.constraints.$hCenter;
	import com.firefly.core.layouts.constraints.$height;
	import com.firefly.core.layouts.constraints.$right;
	import com.firefly.core.layouts.constraints.$vCenter;
	import com.firefly.core.layouts.constraints.$width;
	
	import textures.GameName;
	import textures.LoadingText;
	
	
	public class GameSplash extends Splash implements IView
	{
		public function GameSplash()
		{
			super();
		
			layout.addElement(new GameName(), $vCenter(-40), $hCenter(0), $width(584).cpx, $height(97).cpx);
			
			// App loading message
			layout.addElement(new LoadingText(), $right(120).cpx, $bottom(30).cpx, $width(191).cpx, $height(34).cpx);
		}
		
		override public function show(data:Object=null):void
		{
			graphics.clear();
			graphics.beginFill(0xFFFFFF);
			graphics.drawRect(0,0,width,height);
			graphics.endFill();
			
			layout.layout();
		}
	}
}