package test.layouts.constraints
{
	import com.firefly.core.layouts.Layout;
	import com.firefly.core.layouts.constraints.$top;
	
	import org.flexunit.Assert;
	
	import starling.display.Quad;
	
	import test.layouts.helpers.Container;

	public class TopTest
	{
		[Test]
		public function testLayout() : void 
		{
			var layout:Layout = new Layout(new Container(100, 100));
			var quad:Quad = new Quad(50, 50);
			layout.addElement(quad, $top(20));
			
			Assert.assertTrue(quad.y == 10);	
		}
	}
}