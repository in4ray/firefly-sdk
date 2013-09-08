package test.async
{
	import com.firefly.core.async.Completer;
	import com.firefly.core.async.Future;
	
	import org.flexunit.Assert;

	public class CompleterTest
	{
		[Test]
		public function testComplete() : void 
		{
			var rnd:Number = Math.random();
			new Completer(new Future().then(function(arg:Number):void
			{
				Assert.assertEquals(arg, rnd);	
			}, rnd)).complete();
		}
	}
}