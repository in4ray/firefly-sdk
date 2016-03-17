package test.effects
{
	import com.firefly.core.async.Future;
	import com.firefly.core.effects.IAnimation;
	import com.firefly.core.effects.builder.AnimationBuilder;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import starling.display.Quad;
	
	public class FadeTest extends EventDispatcher
	{
		private var _fade:IAnimation;
		private var _quad:Quad;
		private var _alphaVal:Number;
		
		[Before]
		public function prepareFadeEffect() : void 
		{
			_quad = new Quad(100, 100);
			_fade = AnimationBuilder.init(_quad).fade().duration(0.5).build();
		}
		
		[Test(async, timeout="1000")]
		public function play() : void 
		{
			_fade.play().then(function():void
			{
				Assert.assertTrue(_quad.alpha == 0);
				Assert.assertFalse(_fade.isPause);
				Assert.assertFalse(_fade.isPlaying);
				
				dispatchEvent(new Event(Event.COMPLETE));
			});
			
			// wait for completion
			Async.handleEvent(this, this, Event.COMPLETE, function():void{}, 1000);
		}
		
		[Test(async, timeout="1000")]
		public function pause() : void 
		{
			_fade.play();
			
			Future.delay(0.2).then(function():void
			{
				_fade.pause();
				_alphaVal = _quad.alpha;
				
				Future.delay(0.2).then(function():void
				{
					Assert.assertTrue(_quad.alpha == _alphaVal);
					Assert.assertTrue(_fade.isPause);
					Assert.assertFalse(_fade.isPlaying);
					
					dispatchEvent(new Event(Event.COMPLETE));
				});
			});
			
			// wait for completion
			Async.handleEvent(this, this, Event.COMPLETE, function():void{}, 1000);
		}
		
		[Test(async, timeout="1000")]
		public function resume() : void 
		{
			_fade.play().then(function():void
			{
				Assert.assertTrue(_quad.alpha == 0);
				Assert.assertFalse(_fade.isPause);
				Assert.assertFalse(_fade.isPlaying);
				
				dispatchEvent(new Event(Event.COMPLETE));
			});
			
			_fade.pause();
			_fade.resume();
			
			// wait for completion
			Async.handleEvent(this, this, Event.COMPLETE, function():void{}, 1000);
		}
		
		[Test]
		public function end() : void 
		{
			_fade.play();
			_fade.end();
			
			Assert.assertTrue(_quad.alpha == 0);
		}
		
		[Test(async, timeout="3000")]
		public function repeatCount() : void 
		{
			_fade.repeatCount = 3;
			_fade.play().then(function():void
			{
				Assert.assertTrue(_quad.alpha == 0);
				
				dispatchEvent(new Event(Event.COMPLETE));
			});
			
			// wait for completion
			Async.handleEvent(this, this, Event.COMPLETE, function():void{}, 3000);
		}
	}
}