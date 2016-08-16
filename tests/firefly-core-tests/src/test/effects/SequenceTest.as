package test.effects
{
	import com.firefly.core.async.Future;
	import com.firefly.core.effects.IAnimation;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import starling.display.Quad;
	
	public class SequenceTest extends EventDispatcher
	{
		private var _sequence:IAnimation;
		private var _quad:Quad;
		private var _scaleVal:Number;
		private var _alpahVal:Number;
		private var _rotateVal:Number;
		
		[Before(async)]
		public function prepareSequenceEffect() : void 
		{
			_quad = new Quad(100, 100);
			_sequence = AnimationBuilderHolder.animator.target(_quad).sequence().duration(1).fade().scale(2).rotate(0.1).duration(0.4).build();
		}
		
		[After(async)]
		public function releaseSequence() : void 
		{
			AnimationBuilderHolder.animator.cache(_sequence);
		}
		
		[Test(async, timeout="1500")]
		public function play() : void 
		{
			_sequence.play().then(function():void
			{
				Assert.assertTrue(_quad.scaleX == 2);
				Assert.assertTrue(_quad.scaleY == 2);
				Assert.assertTrue(_quad.rotation == 0.1);
				Assert.assertTrue(_quad.alpha == 0);
				Assert.assertFalse(_sequence.isPause);
				Assert.assertFalse(_sequence.isPlaying);
				
				dispatchEvent(new Event(Event.COMPLETE));
			});
			
			// wait for completion
			Async.handleEvent(this, this, Event.COMPLETE, function():void{}, 1500);
		}
		
		[Test(async, timeout="2000")]
		public function pause() : void 
		{
			_sequence.play();
			
			Future.delay(0.2).then(function():void
			{
				_sequence.pause();
				_scaleVal = _quad.scaleX;
				_alpahVal = _quad.alpha;
				_rotateVal = _quad.rotation;
				
				Future.delay(0.2).then(function():void
				{
					Assert.assertTrue(_quad.scaleX == _scaleVal);
					Assert.assertTrue(_quad.scaleY == _scaleVal);
					Assert.assertTrue(_quad.rotation == _rotateVal);
					Assert.assertTrue(_quad.alpha == _alpahVal);
					Assert.assertTrue(_sequence.isPause);
					Assert.assertFalse(_sequence.isPlaying);
					
					dispatchEvent(new Event(Event.COMPLETE));
				});
			});
			
			// wait for completion
			Async.handleEvent(this, this, Event.COMPLETE, function():void{}, 2000);
		}
		
		[Test(async, timeout="1500")]
		public function resume() : void 
		{
			_sequence.play().then(function():void
			{
				Assert.assertTrue(_quad.scaleX == 2);
				Assert.assertTrue(_quad.scaleY == 2);
				Assert.assertTrue(_quad.rotation == 0.1);
				Assert.assertTrue(_quad.alpha == 0);
				Assert.assertFalse(_sequence.isPause);
				Assert.assertFalse(_sequence.isPlaying);
				
				dispatchEvent(new Event(Event.COMPLETE));
			});
			
			_sequence.pause();
			_sequence.resume();
			
			// wait for completion
			Async.handleEvent(this, this, Event.COMPLETE, function():void{}, 1500);
		}
		
		[Test]
		public function end() : void 
		{
			_sequence.play();
			_sequence.end();
			
			Assert.assertTrue(_quad.scaleX == 2);
			Assert.assertTrue(_quad.scaleY == 2);
			Assert.assertTrue(_quad.rotation == 0.1);
			Assert.assertTrue(_quad.alpha == 0);
		}
		
		[Test(async, timeout="3500")]
		public function repeatCount() : void 
		{
			_sequence.repeatCount = 3;
			_sequence.play().then(function():void
			{
				Assert.assertTrue(_quad.scaleX == 2);
				Assert.assertTrue(_quad.scaleY == 2);
				Assert.assertTrue(_quad.rotation == 0.1);
				Assert.assertTrue(_quad.alpha == 0);
				
				dispatchEvent(new Event(Event.COMPLETE));
			});
			
			// wait for completion
			Async.handleEvent(this, this, Event.COMPLETE, function():void{}, 3500);
		}
	}
}