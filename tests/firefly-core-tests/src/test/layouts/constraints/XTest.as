package test.layouts.constraints
{
	import com.firefly.core.firefly_internal;
	import com.firefly.core.layouts.Layout;
	import com.firefly.core.layouts.constraints.$x;
	
	import org.flexunit.Assert;
	
	import starling.display.Quad;
	
	import test.layouts.helpers.Container;

	use namespace firefly_internal;
	
	public class XTest
	{
		[Test]
		public function testPxLayout() : void 
		{
			var layout:Layout = new Layout(new Container(100, 100));
			var quad:Quad = new Quad(50, 50);
			layout.addElement(quad, $x(20));
			
			Assert.assertTrue(quad.x == 10);	
		}
		
		[Test]
		public function testPctLayout() : void 
		{
			var layout:Layout = new Layout(new Container(100, 100));
			var quad:Quad = new Quad(50, 50);
			layout.addElement(quad, $x(20).pct);
			
			Assert.assertTrue(Math.round(quad.x) == 20);	
		}
	}
}  