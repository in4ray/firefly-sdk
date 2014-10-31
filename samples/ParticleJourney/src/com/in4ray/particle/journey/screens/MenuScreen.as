package com.in4ray.particle.journey.screens
{
	import com.firefly.core.firefly_internal;
	import com.firefly.core.components.Button;
	import com.firefly.core.components.Screen;
	import com.firefly.core.events.NavigationEvent;
	import com.firefly.core.layouts.constraints.$hCenter;
	import com.firefly.core.layouts.constraints.$vCenter;
	import com.in4ray.particle.journey.globals.$txt;
	
	import starling.events.Event;
	
	use namespace firefly_internal;
	
	public class MenuScreen extends Screen
	{
		
		public function MenuScreen()
		{
			super();
			
			var playBtn:Button = new Button($txt.playBtn);
			playBtn.addEventListener(Event.TRIGGERED, onPlay);
			layout.addElement(playBtn, $vCenter(0), $hCenter(0));
		}
		
		private function onPlay(e:Event):void
		{
			dispatchEvent(new NavigationEvent(NavigationEvent.TO_GAME));
		}
	}
}