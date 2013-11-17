package com.in4ray.particle.journey.screens
{
	import com.firefly.core.display.INavigationScreen;
	import com.firefly.core.events.NavigationEvent;
	import com.firefly.core.layouts.Layout;
	import com.firefly.core.layouts.constraints.$hCenter;
	import com.firefly.core.layouts.constraints.$vCenter;
	import com.in4ray.particle.journey.textures.CommonTextures;
	import com.in4ray.particle.journey.textures.MenuTextures;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	
	public class MenuScreen extends Sprite implements INavigationScreen
	{
		private var layout:Layout;
		public function MenuScreen()
		{
			super();
			
			addChild(new Image(new MenuTextures().menu));
			addChild(new Image(new CommonTextures().human));
			
			var button:Button = new Button(Texture.fromColor(100, 20), "Game");
			button.addEventListener(Event.TRIGGERED, onGameClick);
			
			layout = new Layout(this);
			layout.addElement(button, $vCenter(0), $hCenter(0));
		}
		
		private function onGameClick(e:Event):void
		{
			dispatchEvent(new NavigationEvent(NavigationEvent.TO_GAME));
		}
		
		public function startShowTransition():void
		{
		}
		
		public function startHideTransition():void
		{
		}
		
		public function show(data:Object):void
		{
		}
		
		public function hide():void
		{
		}
	}
}