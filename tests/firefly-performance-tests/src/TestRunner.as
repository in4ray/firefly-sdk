// =================================================================================================
//
//	Firefly Framework
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package
{
	import com.firefly.core.async.Completer;
	import com.firefly.core.async.Future;
	import com.firefly.core.async.GroupCompleter;
	import com.firefly.core.async.NextFrameCompleter;
	import com.firefly.core.effects.Fade;
	import com.firefly.core.effects.easing.Bounce;
	import com.firefly.core.utils.ClassFactory;
	import com.firefly.core.utils.SingletonLocator;
	import com.firefly.tests.PerformanceTest;
	
	import flash.display.Sprite;
	
	import starling.animation.Juggler;
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.starling_internal;
	import starling.display.Sprite;
	
	use namespace starling_internal;
	public class TestRunner extends flash.display.Sprite
	{
		public static var juggler:Juggler;
		public static var tweenJuggler:Juggler;
		
		public function TestRunner()
		{
			super();
			
			var test:PerformanceTest = new PerformanceTest();
			//test.testCreation(new ClassFactory(Future));
			//test.testCreation(new ClassFactory(Completer));
			//test.testCreation(new ClassFactory(GroupCompleter));
			//test.testCreation(new ClassFactory(NextFrameCompleter));
			//test.testCreation(new ClassFactory(Tween, null, 0));
			/*test.testCreation(new ClassFactory(DelayedCompleter, 1))*/
			
			
			/*test.testCreation(new ClassFactory(Point));
			test.testFunction(new ClassFactory(Point), "setTo", 0, 0);
			test.testFunction(new ClassFactory(Rectangle), "offsetPoint", new ClassFactory(Point, 1,1));*/
			
			/*juggler = new Juggler();
			var fade:Fade = new Fade(new starling.display.Sprite(), 1000, 0);
			fade.easer = new Bounce();
			fade.juggler = juggler;
			fade.play();
			test.testStaticFunction(TestRunner, "animateFade");
			
			tweenJuggler = new Juggler();
			var tween:Tween = new Tween(new starling.display.Sprite(), 1, Transitions.EASE_IN_OUT_BOUNCE);
			tween.fadeTo(0);
			tweenJuggler.add(tween);
			test.testStaticFunction(TestRunner, "animateTweenFade");
			
			test.run(true)*/;
			
			test.testStaticFunction(TestRunner, "test1");
			test.testStaticFunction(TestRunner, "test2");
			test.testStaticFunction(TestRunner, "test3");
			
			test.run(true)
			
		}
		
		public static function test1():void
		{
			var v:* = SingletonLocator.getInstance(ParticleBundle);
		}
		
		public static function test2():void
		{
			var v:* = new ParticleBundle();
		}
		
		public static function test3():void
		{
			var v:* = $prt;
		}
		
		public static function fromPool():void
		{
			Tween.fromPool(null,0);
		}
		
		public static function animateFade():void
		{
			juggler.advanceTime(0.5);
		}
		
		public static function animateTweenFade():void
		{
			tweenJuggler.advanceTime(0.5);
		}
	}
}