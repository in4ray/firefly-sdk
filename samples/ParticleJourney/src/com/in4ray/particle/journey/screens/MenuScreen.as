package com.in4ray.particle.journey.screens
{
	import com.firefly.core.Firefly;
	import com.firefly.core.firefly_internal;
	import com.firefly.core.async.Future;
	import com.firefly.core.components.Button;
	import com.firefly.core.components.Screen;
	import com.firefly.core.components.TextField;
	import com.firefly.core.components.ToggleButton;
	import com.firefly.core.components.helpers.LocalizationField;
	import com.firefly.core.effects.Fade;
	import com.firefly.core.effects.IAnimation;
	import com.firefly.core.effects.LayoutAnimation;
	import com.firefly.core.effects.Parallel;
	import com.firefly.core.effects.Rotate;
	import com.firefly.core.effects.Scale;
	import com.firefly.core.effects.Sequence;
	import com.firefly.core.effects.easing.Back;
	import com.firefly.core.events.NavigationEvent;
	import com.firefly.core.layouts.Layout;
	import com.firefly.core.layouts.constraints.$height;
	import com.firefly.core.layouts.constraints.$left;
	import com.firefly.core.layouts.constraints.$pivotX;
	import com.firefly.core.layouts.constraints.$pivotY;
	import com.firefly.core.layouts.constraints.$top;
	import com.firefly.core.layouts.constraints.$width;
	import com.firefly.core.layouts.constraints.$x;
	import com.firefly.core.layouts.constraints.$y;
	import com.firefly.core.model.Model;
	import com.in4ray.particle.journey.GameModel;
	import com.in4ray.particle.journey.fonts.GameFontBundle;
	import com.in4ray.particle.journey.fonts.GameParticleBundle;
	import com.in4ray.particle.journey.locale.GameLocalizationBundle;
	import com.in4ray.particle.journey.textures.CommonTextures;
	import com.in4ray.particle.journey.textures.MenuTextures;
	
	import extensions.particles.PDParticleSystem;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.deg2rad;
	
	use namespace firefly_internal;
	
	public class MenuScreen extends Screen
	{
		private var _model:GameModel;
        private var _quad:Quad;
		private var _quadProgress:Quad;
		private var _textFieldProgress:com.firefly.core.components.TextField;
		private var _currentEffect:IAnimation;
		private var _localizationBundle:GameLocalizationBundle;
		private var tf:com.firefly.core.components.TextField;
        private var tf2:com.firefly.core.components.TextField;
		
		public function MenuScreen()
		{
			super();
			
            _model = Firefly.current.model as GameModel;
            _localizationBundle = new GameLocalizationBundle();
			
			//var font:BitmapFont = 
			starling.text.TextField.registerBitmapFont(new GameFontBundle().buildBitmapFont("myFont", new MenuTextures().getTexture("myFont")), "Mauryssel");
			
			addChild(new Image(new MenuTextures().menu));
			addChild(new Image(new CommonTextures().human));
			
			var button:starling.display.Button = new starling.display.Button(Texture.fromColor(100, 20), "Game");
			button.addEventListener(Event.TRIGGERED, onGameClick);
			
			// animations
			var buttonFade:starling.display.Button = new starling.display.Button(Texture.fromColor(100, 20), "Fade");
			buttonFade.addEventListener(Event.TRIGGERED, onFadeClick);
			var buttonRotate:starling.display.Button = new starling.display.Button(Texture.fromColor(100, 20), "Rotate");
			buttonRotate.addEventListener(Event.TRIGGERED, onRotateClick);
			var buttonScale:starling.display.Button = new starling.display.Button(Texture.fromColor(100, 20), "Scale");
			buttonScale.addEventListener(Event.TRIGGERED, onScaleClick);
			var buttonSequence:starling.display.Button = new starling.display.Button(Texture.fromColor(100, 20), "Sequence");
			buttonSequence.addEventListener(Event.TRIGGERED, onSequenceClick);
			var buttonParallel:starling.display.Button = new starling.display.Button(Texture.fromColor(100, 20), "Parallel");
			buttonParallel.addEventListener(Event.TRIGGERED, onParallelClick);
			var layoutAnim:starling.display.Button = new starling.display.Button(Texture.fromColor(100, 20), "Layout Anim");
			layoutAnim.addEventListener(Event.TRIGGERED, onLayoutAnimClick);
			
			quad = new Quad(140, 140, 0xcc33aa);
			_quadProgress = new Quad(1, 15, 0x0033aa);
			
			_currentEffect = new Fade(quad, 2000, 0.1);
			
			var buttonFadePlay:starling.display.Button = new starling.display.Button(Texture.fromColor(100, 20), "Play");
			buttonFadePlay.addEventListener(Event.TRIGGERED, onPlayClick);
			var buttonPauseFade:starling.display.Button = new starling.display.Button(Texture.fromColor(100, 20), "Pause");
			buttonPauseFade.addEventListener(Event.TRIGGERED, onPauseClick);
			var buttonResumeFade:starling.display.Button = new starling.display.Button(Texture.fromColor(100, 20), "Resume");
			buttonResumeFade.addEventListener(Event.TRIGGERED, onResumeClick);
			var buttonStopFade:starling.display.Button = new starling.display.Button(Texture.fromColor(100, 20), "Stop");
			buttonStopFade.addEventListener(Event.TRIGGERED, onStopClick);
			var buttonEndFade:starling.display.Button = new starling.display.Button(Texture.fromColor(100, 20), "End");
			buttonEndFade.addEventListener(Event.TRIGGERED, onEndClick);
			var gameBtn:starling.display.Button = new starling.display.Button(Texture.fromColor(100, 20), "Game");
			gameBtn.fontName = "Mauryssel";
			gameBtn.addEventListener(Event.TRIGGERED, onGameClick);

			layout.addElement(buttonFade, $left(20).cpx, $top(50).cpx, $width(100).cpx, $height(20).cpx);
			layout.addElement(buttonRotate, $left(130).cpx, $top(50).cpx, $width(100).cpx, $height(20).cpx);
			layout.addElement(buttonScale, $left(240).cpx, $top(50).cpx, $width(100).cpx, $height(20).cpx);
			layout.addElement(buttonSequence, $left(350).cpx, $top(50).cpx, $width(100).cpx, $height(20).cpx);
			layout.addElement(buttonParallel, $left(460).cpx, $top(50).cpx, $width(100).cpx, $height(20).cpx);
			layout.addElement(layoutAnim, $left(570).cpx, $top(50).cpx, $width(100).cpx, $height(20).cpx);
			layout.addElement(quad, $left(160).cpx, $top(100).cpx, $width(140).cpx, $height(140).cpx);
			layout.addElement(_quadProgress, $left(160).cpx, $top(280).cpx, $height(15).cpx);
			layout.addElement(buttonFadePlay, $left(20).cpx, $top(90).cpx, $width(100).cpx, $height(20).cpx);
			//layout.addElement(buttonFadeReverse, $left(20).px, $top(120).px, $width(100).px, $height(20).px);
			layout.addElement(buttonPauseFade, $left(20).cpx, $top(150).cpx, $width(100).cpx, $height(20).cpx);
			layout.addElement(buttonResumeFade, $left(20).cpx, $top(180).cpx, $width(100).cpx, $height(20).cpx);
			layout.addElement(buttonStopFade, $left(20).cpx, $top(210).cpx, $width(100).cpx, $height(20).cpx);
			layout.addElement(buttonEndFade, $left(20).cpx, $top(240).cpx, $width(100).cpx, $height(20).cpx);
			layout.addElement(gameBtn, $left(20).cpx, $top(270).cpx, $width(100).cpx, $height(20).cpx);
			
			
			var quad:Quad = new Quad(100, 100, 0x000000);
			layout.addElement(quad, $x(0).cpx, $y(350).cpx, $height(400).cpx, $width(100).pct);
			
			var particle1:PDParticleSystem = new GameParticleBundle().buildParticle("myParticle1", new MenuTextures().particleStar);
			var particle2:PDParticleSystem = new GameParticleBundle().buildParticle("myParticle2", new MenuTextures().particleStar);
			var particle3:PDParticleSystem = new GameParticleBundle().buildParticle("myParticle3", new MenuTextures().particle3);
			var particle4:PDParticleSystem = new GameParticleBundle().buildParticle("myParticle4", new MenuTextures().particle4);
			Starling.juggler.add(particle1);
			Starling.juggler.add(particle2);
			Starling.juggler.add(particle3);
			Starling.juggler.add(particle4);
			
			layout.addElement(particle1, $x(100).cpx, $y(400).cpx);
			layout.addElement(particle2, $x(200).cpx, $y(400).cpx);
			layout.addElement(particle3, $x(400).cpx, $y(400).cpx);
			layout.addElement(particle4, $x(100).cpx, $y(600).cpx);
			
			particle1.start(500);
			particle2.start(500);
			particle3.start(500);
			particle4.start(500);
			
			tf = new com.firefly.core.components.TextField(null, "Verdana", 50, 0xffffff);
			tf.autoScale = true;
            tf.text = _model.count.toString();
			layout.addElement(tf, $x(500).cpx, $y(400).cpx, $width(200).cpx, $height(70).cpx);
			
			tf2 = new com.firefly.core.components.TextField(null, "Verdana", 50, 0xffffff);
			tf2.autoScale = true;
			layout.addElement(tf2, $x(500).cpx, $y(600).cpx, $width(200).cpx, $height(70).cpx);
			
			var btn:com.firefly.core.components.Button = new com.firefly.core.components.Button(Texture.fromColor(100, 20), new LocalizationField("s", "Save Prop"));
			btn.addEventListener(Event.TRIGGERED, onSaveProperty);
			layout.addElement(btn, $x(100).cpx, $y(400).cpx, $width(100).cpx, $height(50).cpx);
			
			var btn2:com.firefly.core.components.Button = new com.firefly.core.components.Button(Texture.fromColor(100, 20), new LocalizationField("s2", "Load Prop"));
			btn2.addEventListener(Event.TRIGGERED, onLoadProperty);
			layout.addElement(btn2, $x(220).cpx, $y(400).cpx, $width(100).cpx, $height(50).cpx);
			
			var btnToggle:com.firefly.core.components.ToggleButton = new com.firefly.core.components.ToggleButton(Texture.fromColor(100, 20), new MenuTextures().particleStar, 
				_localizationBundle.getLocaleField("rateBtn"), _localizationBundle.getLocaleField("leaderboard_today"));
			layout.addElement(btnToggle, $x(100).cpx, $y(470).cpx, $width(100).cpx, $height(50).cpx);
			
			Future.delay(3).then(function ():void {_localizationBundle.locale = "ua";});
			Future.delay(6).then(function ():void {_localizationBundle.locale = "ru";});
			Future.delay(9).then(function ():void {_localizationBundle.locale = "en";});
			Future.delay(12).then(function ():void {_localizationBundle.locale = "ua";});
			
			_model.onCount.bind(onCountChange);
            _model.onCount.bind(onCount2Change);
		}
		
		private function onCountChange(val:int):void
		{
			tf.text = val.toString();
		}

        private function onCount2Change(val:int):void
        {
            tf2.text = val.toString();
        }
		
		private function onSaveProperty(e:Event):void
		{
			var val:int = Math.random() * 1000000;
			trace("Generated value: " + val);
			Firefly.current.model.saveProp("myProperty", val);
			
			_model.count++;
		}
		
		private function onLoadProperty(e:Event):void
		{
			trace("Loaded value: " + Firefly.current.model.loadProp("myProperty"));
		}
		
		private function onLayoutAnimClick(event:Event):void
		{
			resetTarget();
			_currentEffect = new LayoutAnimation(_quad, 2, [$x(300).px, $y(200).px, $width(300).px, $height(10).px]);
		}
		
		private function onFadeClick(event:Event):void
		{
			resetTarget();
			_currentEffect = new Fade(_quad, 2, 0.1);
			_currentEffect.repeatCount = 0;
		}
		
		private function onRotateClick(event:Event):void
		{
			resetTarget();
			_currentEffect = new Rotate(_quad, 2, deg2rad(30));
		}
		
		private function onScaleClick(event:Event):void
		{
			resetTarget();
			_currentEffect = new Scale(_quad, 2, 2.4);
			_currentEffect.easer = new Back();
		}
		
		private function onSequenceClick(event:Event):void
		{
			resetTarget();
			_currentEffect = new Sequence(_quad, 5, [new Fade(_quad, 2, 0.2), new Rotate(_quad, 1, 0.2), new Fade(_quad, NaN, 1)]);
			_currentEffect.repeatCount = 3;
			_currentEffect.repeatDelay = 1;
		}
		
		private function onParallelClick():void
		{
			resetTarget();
			_currentEffect = new Parallel(_quad, 4, [new Rotate(_quad, 2, deg2rad(360)), new LayoutAnimation(_quad, 2, [$pivotX(100).pct, $pivotY(100).pct])]);
			_currentEffect.repeatCount = 3;
			_currentEffect.repeatDelay = 1;
		}
		
		private function resetTarget():void
		{
			layout.removeElement(_quad);
			layout.addElement(_quad, $left(160).cpx, $top(100).cpx, $width(140).cpx, $height(140).cpx, $pivotX(0), $pivotY(0));
			_quad.rotation = 0;
			_quad.alpha = 1;
			_quad.scaleX = _quad.scaleY = 1;
		}
		
		private function onPlayClick():void
		{
			resetTarget();
			
			_quadProgress.color = 0x0033aa;
			_quadProgress.width = 1;
			/*currentEffect.repeatCount = 5;
			currentEffect.repeatDelay = 1;
			currentEffect.delay = 0.5;*/
			//currentEffect.loop = true;
			_currentEffect.play().then(onFadeComplete).progress(onFadeProgress);
		}
		
		private function onFadeProgress(val:Number):void
		{
			_quadProgress.width = 290 * val;
		}
		
		private function onFadeComplete():void
		{
			_quadProgress.width = 290;
			_quadProgress.color = 0x000000;
		}
		
		private function onPauseClick():void
		{
			_currentEffect.pause();
		}
		
		private function onResumeClick():void
		{
			_currentEffect.resume();
		}
		
		private function onStopClick():void
		{
			_currentEffect.stop();
		}
		
		private function onEndClick():void
		{
			_currentEffect.end();
		}
		
		private function onGameClick(e:Event):void
		{
			dispatchEvent(new NavigationEvent(NavigationEvent.TO_GAME));
		}
	}
}