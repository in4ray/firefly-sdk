package com.in4ray.particle.journey.screens
{
	import com.firefly.core.display.INavigationScreen;
	import com.firefly.core.effects.Fade;
	import com.firefly.core.effects.IAnimation;
	import com.firefly.core.effects.Rotate;
	import com.firefly.core.effects.Scale;
	import com.firefly.core.events.NavigationEvent;
	import com.firefly.core.layouts.Layout;
	import com.firefly.core.layouts.constraints.$hCenter;
	import com.firefly.core.layouts.constraints.$height;
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
	import starling.text.TextField;
	import starling.textures.Texture;
	
	public class MenuScreen extends Sprite implements INavigationScreen
	{
		private var layout:Layout;
		private var quad:Quad;
		private var quadProgress:Quad;
		private var textFieldProgress:TextField;
		private var currentEffect:IAnimation;
		
		public function MenuScreen()
		{
			super();
			
			addChild(new Image(new MenuTextures().menu));
			addChild(new Image(new CommonTextures().human));
			
			var button:Button = new Button(Texture.fromColor(100, 20), "Game");
			button.addEventListener(Event.TRIGGERED, onGameClick);
			
			// animations
			var buttonFade:Button = new Button(Texture.fromColor(100, 20), "Fade");
			buttonFade.addEventListener(Event.TRIGGERED, onFadeClick);
			var buttonRotate:Button = new Button(Texture.fromColor(100, 20), "Rotate");
			buttonRotate.addEventListener(Event.TRIGGERED, onRotateClick);
			var buttonScale:Button = new Button(Texture.fromColor(100, 20), "Scale");
			buttonScale.addEventListener(Event.TRIGGERED, onScaleClick);
			
			quad = new Quad(140, 140, 0xcc33aa);
			quadProgress = new Quad(1, 15, 0x0033aa);
			
			currentEffect = new Fade(quad, 2000, 0.1);
			
			var buttonFadePlay:Button = new Button(Texture.fromColor(100, 20), "Play");
			buttonFadePlay.addEventListener(Event.TRIGGERED, onPlayClick);
			var buttonFadeReverse:Button = new Button(Texture.fromColor(100, 20), "Reverse Play");
			buttonFadeReverse.addEventListener(Event.TRIGGERED, onReverseClick);
			var buttonPauseFade:Button = new Button(Texture.fromColor(100, 20), "Pause");
			buttonPauseFade.addEventListener(Event.TRIGGERED, onPauseClick);
			var buttonResumeFade:Button = new Button(Texture.fromColor(100, 20), "Resume");
			buttonResumeFade.addEventListener(Event.TRIGGERED, onResumeClick);
			var buttonStopFade:Button = new Button(Texture.fromColor(100, 20), "Stop");
			buttonStopFade.addEventListener(Event.TRIGGERED, onStopClick);
			var buttonEndFade:Button = new Button(Texture.fromColor(100, 20), "End");
			buttonEndFade.addEventListener(Event.TRIGGERED, onEndClick);
			
			layout = new Layout(this);
			layout.addElement(buttonFade, $left(20).px, $top(50).px, $width(100).px, $height(20).px);
			layout.addElement(buttonRotate, $left(130).px, $top(50).px, $width(100).px, $height(20).px);
			layout.addElement(buttonScale, $left(240).px, $top(50).px, $width(100).px, $height(20).px);
			layout.addElement(quad, $left(160).px, $top(100).px, $width(140).px, $height(140).px);
			layout.addElement(quadProgress, $left(160).px, $top(280).px, $height(15).px);
			layout.addElement(buttonFadePlay, $left(20).px, $top(90).px, $width(100).px, $height(20).px);
			layout.addElement(buttonFadeReverse, $left(20).px, $top(120).px, $width(100).px, $height(20).px);
			layout.addElement(buttonPauseFade, $left(20).px, $top(150).px, $width(100).px, $height(20).px);
			layout.addElement(buttonResumeFade, $left(20).px, $top(180).px, $width(100).px, $height(20).px);
			layout.addElement(buttonStopFade, $left(20).px, $top(210).px, $width(100).px, $height(20).px);
			layout.addElement(buttonEndFade, $left(20).px, $top(240).px, $width(100).px, $height(20).px);
		}
		
		private function onFadeClick(event:Event):void
		{
			resetTarget();
			currentEffect = new Fade(quad, 2, 0.1);
		}
		
		private function onRotateClick(event:Event):void
		{
			resetTarget();
			currentEffect = new Rotate(quad, 2, 0.2);
		}
		
		private function onScaleClick(event:Event):void
		{
			resetTarget();
			currentEffect = new Scale(quad, 2, 2.4);
		}
		
		private function resetTarget():void
		{
			layout.removeElement(quad);
			layout.addElement(quad, $left(160).px, $top(100).px, $width(140).px, $height(140).px);
			quad.rotation = 0;
			quad.alpha = 1;
			quad.scaleX = quad.scaleY = 1;
		}
		
		private function onPlayClick():void
		{
			quadProgress.color = 0x0033aa;
			quadProgress.width = 1;
			currentEffect.repeatCount = 5;
			currentEffect.repeatDelay = 1;
			//currentEffect.delay = 2;
			//currentEffect.loop = true;
			currentEffect.play().then(onFadeComplete).progress(onFadeProgress);
		}
		
		private function onReverseClick():void
		{
			quadProgress.color = 0x0033aa;
			quadProgress.width = 1;
			//fadeEffect.delay = 2000;
			//fadeEffect.loop = true;
			currentEffect.play().then(onFadeComplete).progress(onFadeProgress);
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
		
		private function onPauseClick():void
		{
			currentEffect.pause();
		}
		
		private function onResumeClick():void
		{
			currentEffect.resume();
		}
		
		private function onStopClick():void
		{
			currentEffect.stop();
		}
		
		private function onEndClick():void
		{
			currentEffect.end();
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