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
	
	public class ScaleTest extends EventDispatcher
	{
		private var _scale:IAnimation;
		private var _quad:Quad;
		private var _scaleVal:Number;
		
		[Before]
		public function prepareScaleEffect() : void 
		{
			_quad = new Quad(100, 100);
			_scale = AnimationBuilder.init(_quad).scale(2).duration(0.5).build();
		}
		
		[Test(async, timeout="1000")]
		public function play() : void 
		{
			_scale.play().then(function():void
			{
				Assert.assertTrue(_quad.scaleX == 2);
				Assert.assertTrue(_quad.scaleY == 2);
				Assert.assertFalse(_scale.isPause);
				Assert.assertFalse(_scale.isPlaying);
				
				dispatchEvent(new Event(Event.COMPLETE));
			});
			
			// wait for completion
			Async.handleEvent(this, this, Event.COMPLETE, function():void{}, 1000);
		}
		
		[Test(async, timeout="1000")]
		public function pause() : void 
		{
			_scale.play();
			
			Future.delay(0.2).then(function():void
			{
				_scale.pause();
				_scaleVal = _quad.scaleX;
				
				Future.delay(0.2).then(function():void
				{
					Assert.assertTrue(_quad.scaleX == _scaleVal);
					Assert.assertTrue(_quad.scaleY == _scaleVal);
					Assert.assertTrue(_scale.isPause);
					Assert.assertFalse(_scale.isPlaying);
					
					dispatchEvent(new Event(Event.COMPLETE));
				});
			});
			
			// wait for completion
			Async.handleEvent(this, this, Event.COMPLETE, function():void{}, 1000);
		}
		
		[Test(async, timeout="1000")]
		public function resume() : void 
		{
			_scale.play().then(function():void
			{
				Assert.assertTrue(_quad.scaleX == 2);
				Assert.assertTrue(_quad.scaleY == 2);
				Assert.assertFalse(_scale.isPause);
				Assert.assertFalse(_scale.isPlaying);
				
				dispatchEvent(new Event(Event.COMPLETE));
			});
			
			_scale.pause();
			_scale.resume();
			
			// wait for completion
			Async.handleEvent(this, this, Event.COMPLETE, function():void{}, 1000);
		}
		
		[Test]
		public function end() : void 
		{
			_scale.play();
			_scale.end();
			
			Assert.assertTrue(_quad.scaleX == 2);
			Assert.assertTrue(_quad.scaleY == 2);
		}
		
		[Test(async, timeout="3000")]
		public function repeatCount() : void 
		{
			_scale.repeatCount = 3;
			_scale.play().then(function():void
			{
				Assert.assertTrue(_quad.scaleX == 2);
				Assert.assertTrue(_quad.scaleY == 2);
				
				dispatchEvent(new Event(Event.COMPLETE));
			});
			
			// wait for completion
			Async.handleEvent(this, this, Event.COMPLETE, function():void{}, 3000);
		}
	}
}