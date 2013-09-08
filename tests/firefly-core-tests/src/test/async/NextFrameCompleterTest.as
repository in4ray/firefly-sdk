package test.async
{
	import com.firefly.core.async.Future;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;

	public class NextFrameCompleterTest extends EventDispatcher
	{
		[Test(async, timeout="1000")]
		public function testComplete() : void 
		{
			Future.nextFrame().then(function(arg1:Boolean):void
			{
				Assert.assertEquals(arg1, true);
				dispatchEvent(new Event(Event.COMPLETE));
			}, true
			);
			
			// wait for completion
			Async.handleEvent(this, this, Event.COMPLETE, function():void{}, 1000);
		}
	}
}