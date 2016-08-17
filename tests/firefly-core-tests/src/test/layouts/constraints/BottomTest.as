package test.layouts.constraints
{
	import com.firefly.core.layouts.Layout;
	import com.firefly.core.layouts.constraints.$bottom;
	import com.firefly.core.layouts.constraints.$pivotY;
	import com.firefly.core.layouts.constraints.$top;
	
	import org.flexunit.Assert;
	
	import starling.display.Quad;
	
	import test.layouts.helpers.Container;

	public class BottomTest
	{
		[Test]
		public function testLayout() : void 
		{
			var layout:Layout = new Layout(new Container(100, 100));
			var quad:Quad = new Quad(50, 50);
			layout.addElement(quad, $bottom(20));
			
			Assert.assertTrue(quad.y == 40);	
		}
		
		[Test]
		public function testWithResize() : void 
		{
			var layout:Layout = new Layout(new Container(100, 100));
			var quad:Quad = new Quad(50, 50);
			layout.addElement(quad, $bottom(20), $top(20));
			
			Assert.assertTrue(quad.y == 10);	
			Assert.assertTrue(quad.height == 80);	
		}
		
		[Test]
		public function testWithPivot() : void 
		{
			var layout:Layout = new Layout(new Container(100, 100));
			var quad:Quad = new Quad(50, 50);
			layout.addElement(quad, $bottom(20), $pivotY(20));
			
			Assert.assertTrue(quad.y == 50);	
		}
	}
}