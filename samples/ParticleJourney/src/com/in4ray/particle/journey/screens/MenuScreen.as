package com.in4ray.particle.journey.screens
{
	import com.firefly.core.async.helpers.Progress;
	import com.firefly.core.display.INavigationScreen;
	import com.firefly.core.effects.Fade;
	import com.firefly.core.events.NavigationEvent;
	import com.firefly.core.layouts.Layout;
	import com.firefly.core.layouts.constraints.$hCenter;
	import com.firefly.core.layouts.constraints.$left;
	import com.firefly.core.layouts.constraints.$top;
	import com.firefly.core.layouts.constraints.$vCenter;
	import com.firefly.core.layouts.constraints.$width;
	import com.in4ray.particle.journey.textures.CommonTextures;
	import com.in4ray.particle.journey.textures.MenuTextures;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	
	public class MenuScreen extends Sprite implements INavigationScreen
	{
		private var layout:Layout;
		private var quad:Quad;
		private var quadProgress:Quad;
		private var fadeEffect:Fade;
		
		public function MenuScreen()
		{
			super();
			
			addChild(new Image(new MenuTextures().menu));
			addChild(new Image(new CommonTextures().human));
			
			var button:Button = new Button(Texture.fromColor(100, 20), "Game");
			button.addEventListener(Event.TRIGGERED, onGameClick);
			
			// fade test
			var buttonFadePlay:Button = new Button(Texture.fromColor(100, 20), "Play Fade");
			buttonFadePlay.addEventListener(Event.TRIGGERED, onFadePlayClick);
			var buttonPauseFade:Button = new Button(Texture.fromColor(100, 20), "Pause Fade");
			buttonPauseFade.addEventListener(Event.TRIGGERED, onFadePauseClick);
			var buttonResumeFade:Button = new Button(Texture.fromColor(100, 20), "Resume Fade");
			buttonResumeFade.addEventListener(Event.TRIGGERED, onFadeResumeClick);
			var buttonStopFade:Button = new Button(Texture.fromColor(100, 20), "Stop Fade");
			buttonStopFade.addEventListener(Event.TRIGGERED, onFadeStopClick);
			var buttonEndFade:Button = new Button(Texture.fromColor(100, 20), "End Fade");
			buttonEndFade.addEventListener(Event.TRIGGERED, onFadeEndClick);
			quad = new Quad(140, 140, 0xcc33aa);
			quadProgress = new Quad(1, 15, 0x0033aa);
			
			
			layout = new Layout(this);
			layout.addElement(button, $vCenter(0), $hCenter(0));
			layout.addElement(buttonFadePlay, $left(50).px, $top(20).px);
			layout.addElement(buttonPauseFade, $left(50).px, $top(50).px);
			layout.addElement(buttonResumeFade, $left(50).px, $top(80).px);
			layout.addElement(buttonStopFade, $left(50).px, $top(110).px);
			layout.addElement(buttonEndFade, $left(50).px, $top(140).px);
			layout.addElement(quad, $left(200).px, $top(20).px);
			layout.addElement(quadProgress, $left(50).px, $top(170).px);
		}
		
		private function onFadePlayClick():void
		{
			quadProgress.color = 0x0033aa;
			quadProgress.width = 1;
			fadeEffect = new Fade(quad, 2.5, 0.1, 1);
			//fadeEffect.delay = 2000;
			//fadeEffect.loop = true;
			fadeEffect.play().then(onFadeComplete).progress(onFadeProgress);
		}
		
		private function onFadeProgress(val:Number):void
		{
			quadProgress.width = 290 * val;
		}
		
		private function onFadeComplete():void
		{
			quadProgress.width = 290;
			quadProgress.color = 0x000000;
		}
		
		private function onFadePauseClick():void
		{
			if (fadeEffect)
				fadeEffect.pause();
		}
		
		private function onFadeResumeClick():void
		{
			if (fadeEffect)
				fadeEffect.resume();
		}
		
		private function onFadeStopClick():void
		{
			if (fadeEffect)
				fadeEffect.stop();
		}
		
		private function onFadeEndClick():void
		{
			if (fadeEffect)
				fadeEffect.end();
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