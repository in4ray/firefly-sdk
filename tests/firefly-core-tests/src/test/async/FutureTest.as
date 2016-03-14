package test.async
{
	import com.firefly.core.firefly_internal;
	import com.firefly.core.async.Future;
	
	import org.flexunit.Assert;

	public class FutureTest
	{
		[Test]
		public function testComplete() : void 
		{
			// No args
			new Future().then(function():void{}).firefly_internal::complete();
			
			// One arg
			new Future().then(function(arg1:Boolean):void
			{
				Assert.assertEquals(arg1, true);	
			}
			).firefly_internal::complete(true);
			
			// Two args
			var rnd:Number = Math.random();
			new Future().then(function(arg1:Boolean, arg2:Number):void
			{
				Assert.assertEquals(arg1, true);	
				Assert.assertEquals(arg2, rnd);	
			}
			, rnd).firefly_internal::complete(true);
		}
		
		[Test]
		public function testError() : void 
		{
			// No args
			new Future().error(function():void{}).firefly_internal::fail();
			
			// One arg
			new Future().error(function(arg1:Boolean):void
			{
				Assert.assertEquals(arg1, true);	
			}
			).firefly_internal::fail(true);
			
			// Two args
			var rnd:Number = Math.random();
			new Future().error(function(arg1:Boolean, arg2:Number):void
			{
				Assert.assertEquals(arg1, true);	
				Assert.assertEquals(arg2, rnd);	
			}
				, rnd).firefly_internal::fail(true);
		}
		
		[Test]
		public function testNullComplete() : void 
		{
			new Future().firefly_internal::complete();
		}
	}
}