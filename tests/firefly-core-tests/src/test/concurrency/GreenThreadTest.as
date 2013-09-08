package test.concurrency
{
	import com.firefly.core.concurrency.GreenThread;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;

	public class GreenThreadTest extends EventDispatcher
	{
		[Test(async, timeout="1000")]
		public function testSchedule() : void 
		{
			var thread:GreenThread = new GreenThread();
			thread.schedule(function(arg1:Boolean):void
			{
				Assert.assertTrue(arg1);	
			}, true);
			
			thread.schedule(function(arg1:Number, arg2:Number):void
			{
				Assert.assertEquals(arg1, 1);	
				Assert.assertEquals(arg2, 2);	
				dispatchEvent(new Event(Event.COMPLETE));
			}, 1, 2);
			
			// wait for completion
			Async.handleEvent(this, this, Event.COMPLETE, function():void{}, 1000);
		}
	}
}