package test.concurrency
{
	import com.firefly.core.concurrency.Task;
	
	import org.flexunit.Assert;

	public class TaskTest
	{
		[Test]
		public function testExecution() : void 
		{
			new Task(function(arg1:Boolean):void
			{
				Assert.assertTrue(arg1);	
			}, [true]).proceed();
		}
	}
}