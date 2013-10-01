package test.layouts.constraints
{
	import com.firefly.core.layouts.Layout;
	import com.firefly.core.layouts.constraints.$height;
	
	import org.flexunit.Assert;
	
	import starling.display.Quad;
	
	import test.layouts.helpers.Container;

	public class HeightTest
	{
		[Test]
		public function testLayout() : void 
		{
			var layout:Layout = new Layout(new Container(100, 100));
			var quad:Quad = new Quad(50, 50);
			layout.addElement(quad, $height(20));
			
			Assert.assertTrue(quad.height == 10);	
		}
		
		[Test]
		public function testKeepAspectLayout() : void 
		{
			var layout:Layout = new Layout(new Container(100, 100));
			var quad:Quad = new Quad(50, 50);
			layout.addElement(quad, $height(20, true));
			
			Assert.assertTrue(quad.height == 10);	
			Assert.assertTrue(quad.width == 10);	
		}
	}
}