package test.layouts.constraints
{
	import com.firefly.core.layouts.Layout;
	import com.firefly.core.layouts.constraints.$left;
	import com.firefly.core.layouts.constraints.$right;
	
	import org.flexunit.Assert;
	
	import starling.display.Quad;
	
	import test.layouts.helpers.Container;

	public class RightTest
	{
		[Test]
		public function testLayout() : void 
		{
			var layout:Layout = new Layout(new Container(100, 100));
			var quad:Quad = new Quad(50, 50);
			layout.addElement(quad, $right(20));
			
			Assert.assertTrue(quad.x == 40);	
		}
		
		[Test]
		public function testWithResize() : void 
		{
			var layout:Layout = new Layout(new Container(100, 100));
			var quad:Quad = new Quad(50, 50);
			layout.addElement(quad, $right(20), $left(20));
			
			Assert.assertTrue(quad.x == 10);	
			Assert.assertTrue(quad.width == 80);	
		}
	}
}