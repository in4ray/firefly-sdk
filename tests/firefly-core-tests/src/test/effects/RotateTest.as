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
	
	public class RotateTest extends EventDispatcher
	{
		private var _rotate:IAnimation;
		private var _quad:Quad;
		private var _rotateVal:Number;
		
		[Before]
		public function prepareRotateEffect() : void 
		{
			_quad = new Quad(100, 100);
			_rotate = AnimationBuilder.init().target(_quad).rotate(0.1).duration(0.5).build();
		}
		
		[Test(async, timeout="1000")]
		public function play() : void 
		{
			_rotate.play().then(function():void
			{
				Assert.assertTrue(_quad.rotation == 0.1);
				Assert.assertFalse(_rotate.isPause);
				Assert.assertFalse(_rotate.isPlaying);
				
				dispatchEvent(new Event(Event.COMPLETE));
			});
			
			// wait for completion
			Async.handleEvent(this, this, Event.COMPLETE, function():void{}, 1000);
		}
		
		[Test(async, timeout="1000")]
		public function pause() : void 
		{
			_rotate.play();
			
			Future.delay(0.2).then(function():void
			{
				_rotate.pause();
				_rotateVal = _quad.rotation;
				
				Future.delay(0.2).then(function():void
				{
					Assert.assertTrue(_quad.rotation == _rotateVal);
					Assert.assertTrue(_rotate.isPause);
					Assert.assertFalse(_rotate.isPlaying);
					
					dispatchEvent(new Event(Event.COMPLETE));
				});
			});
			
			// wait for completion
			Async.handleEvent(this, this, Event.COMPLETE, function():void{}, 1000);
		}
		
		[Test(async, timeout="1000")]
		public function resume() : void 
		{
			_rotate.play().then(function():void
			{
				Assert.assertTrue(_quad.rotation == 0.1);
				Assert.assertFalse(_rotate.isPause);
				Assert.assertFalse(_rotate.isPlaying);
				
				dispatchEvent(new Event(Event.COMPLETE));
			});
			
			_rotate.pause();
			_rotate.resume();
			
			// wait for completion
			Async.handleEvent(this, this, Event.COMPLETE, function():void{}, 1000);
		}
		
		[Test]
		public function end() : void 
		{
			_rotate.play();
			_rotate.end();
			
			Assert.assertTrue(_quad.rotation == 0.1);
		}
		
		[Test(async, timeout="3000")]
		public function repeatCount() : void 
		{
			_rotate.repeatCount = 3;
			_rotate.play().then(function():void
			{
				Assert.assertTrue(_quad.rotation == 0.1);
				
				dispatchEvent(new Event(Event.COMPLETE));
			});
			
			// wait for completion
			Async.handleEvent(this, this, Event.COMPLETE, function():void{}, 3000);
		}
	}
}