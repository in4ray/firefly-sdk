package test.async
{
	import com.firefly.core.async.Future;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;

	public class GroupCompleterTest extends EventDispatcher
	{
		[Test(async, timeout="1000")]
		public function testComplete() : void 
		{
			var rnd:Number = Math.random();
			Future.forEach(Future.nextFrame(), Future.delay(0.08)).then(function(arg:Number):void
			{
				Assert.assertEquals(arg, rnd);	
				dispatchEvent(new Event(Event.COMPLETE));
			}, rnd);
			
			// wait for completion
			Async.handleEvent(this, this, Event.COMPLETE, function():void{}, 1000);
		}
		
		[Test(async, timeout="1000")]
		public function testProgress() : void 
		{
			var i:Number = 0;
			var rnd:Number = Math.random();
			Future.forEach(Future.nextFrame(), Future.forEach(Future.delay(0.005), Future.delay(0.008))).progress(function(ratio:Number, arg:Number):void
			{
				i++;
				Assert.assertEquals(arg, rnd);	
				Assert.assertEquals(Math.round(ratio*100), Math.round(i/3*100));	
				if(i==3)
					dispatchEvent(new Event(Event.COMPLETE));
			}, rnd);
			
			// wait for completion
			Async.handleEvent(this, this, Event.COMPLETE, function():void{}, 1000);
		}
	}
}