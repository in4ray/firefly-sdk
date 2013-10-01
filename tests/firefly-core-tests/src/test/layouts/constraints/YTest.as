package test.layouts.constraints
{
	import com.firefly.core.layouts.Layout;
	import com.firefly.core.layouts.constraints.$y;
	
	import org.flexunit.Assert;
	
	import starling.display.Quad;
	
	import test.layouts.helpers.Container;

	public class YTest
	{
		[Test]
		public function testLayout() : void 
		{
			var layout:Layout = new Layout(new Container(100, 100));
			var quad:Quad = new Quad(50, 50);
			layout.addElement(quad, $y(20));
			
			Assert.assertTrue(quad.y == 10);	
		}
		
		[Test]
		public function testPctLayout() : void 
		{
			var layout:Layout = new Layout(new Container(100, 100));
			var quad:Quad = new Quad(50, 50);
			layout.addElement(quad, $y(20).pct);
			
			Assert.assertTrue(Math.round(quad.y) == 20);	
		}
	}
}