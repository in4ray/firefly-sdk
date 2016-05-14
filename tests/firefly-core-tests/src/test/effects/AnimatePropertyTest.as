package test.effects
{
	import com.firefly.core.async.Future;
	import com.firefly.core.effects.IAnimation;
	import com.firefly.core.effects.builder.AnimationBuilder;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	public class AnimatePropertyTest extends EventDispatcher
	{
		private var _animate:IAnimation;
		private var _quad:TestObject;
		private var _animateVal:Number;
		
		[Before]
		public function prepareScaleEffect() : void 
		{
			_quad = new TestObject(100, 100);
			_animate = AnimationBuilder.init(_quad).animate("prop", 10).duration(0.5).build();
		}
		
		[Test(async, timeout="1000")]
		public function play() : void 
		{
			_animate.play().then(function():void
			{
				Assert.assertTrue(_quad.prop == 10);
				Assert.assertFalse(_animate.isPause);
				Assert.assertFalse(_animate.isPlaying);
				
				dispatchEvent(new Event(Event.COMPLETE));
			});
			
			// wait for completion
			Async.handleEvent(this, this, Event.COMPLETE, function():void{}, 1000);
		}
		
		[Test(async, timeout="1000")]
		public function pause() : void 
		{
			_animate.play();
			
			Future.delay(0.2).then(function():void
			{
				_animate.pause();
				_animateVal = _quad.prop;
				
				Future.delay(0.2).then(function():void
				{
					Assert.assertTrue(_quad.prop == _animateVal);
					Assert.assertTrue(_animate.isPause);
					Assert.assertFalse(_animate.isPlaying);
					
					dispatchEvent(new Event(Event.COMPLETE));
				});
			});
			
			// wait for completion
			Async.handleEvent(this, this, Event.COMPLETE, function():void{}, 1000);
		}
		
		[Test(async, timeout="1000")]
		public function resume() : void 
		{
			_animate.play().then(function():void
			{
				Assert.assertTrue(_quad.prop == 10);
				Assert.assertFalse(_animate.isPause);
				Assert.assertFalse(_animate.isPlaying);
				
				dispatchEvent(new Event(Event.COMPLETE));
			});
			
			_animate.pause();
			_animate.resume();
			
			// wait for completion
			Async.handleEvent(this, this, Event.COMPLETE, function():void{}, 1000);
		}
		
		[Test]
		public function end() : void 
		{
			_animate.play();
			_animate.end();
			
			Assert.assertTrue(_quad.prop == 10);
		}
		
		[Test(async, timeout="3000")]
		public function repeatCount() : void 
		{
			_animate.repeatCount = 3;
			_animate.play().then(function():void
			{
				Assert.assertTrue(_quad.prop == 10);
				
				dispatchEvent(new Event(Event.COMPLETE));
			});
			
			// wait for completion
			Async.handleEvent(this, this, Event.COMPLETE, function():void{}, 3000);
		}
	}
}

import starling.display.Quad;

internal class TestObject extends Quad
{
	public function TestObject(width:Number, height:Number, color:uint=0xffffff)
	{
		super(width, height, color);
	}
	
	public var prop:int = 0;
}