package test.effects
{
	import com.firefly.core.effects.LayoutAnimation;
	import com.firefly.core.layouts.Layout;
	import com.firefly.core.layouts.constraints.$height;
	import com.firefly.core.layouts.constraints.$pivotX;
	import com.firefly.core.layouts.constraints.$pivotY;
	import com.firefly.core.layouts.constraints.$width;
	import com.firefly.core.layouts.constraints.$x;
	import com.firefly.core.layouts.constraints.$y;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import starling.display.Quad;
	
	import test.layouts.helpers.Container;
	
	public class LayoutAnimationTest extends EventDispatcher
	{
		[Test(async, timeout="600")]
		public function testMoveBaseOnPx() : void 
		{
			var layout:Layout = new Layout(new Container(100, 100));
			var quad:Quad = new Quad(50, 50);
			layout.addElement(quad, $x(10).px, $y(10).px);
			
			var animation:LayoutAnimation = new LayoutAnimation(quad, 0.5, [$x(40).px, $y(40).px]);
			animation.play().then(function():void
			{
				Assert.assertTrue(quad.x == 40);
				Assert.assertTrue(quad.y == 40);
				
				dispatchEvent(new Event(Event.COMPLETE));
			});
			
			// wait for completion
			Async.handleEvent(this, this, Event.COMPLETE, function():void{}, 600);
		}
		
		[Test(async, timeout="600")]
		public function testMoveBaseOnPct() : void 
		{
			var layout:Layout = new Layout(new Container(100, 100));
			var quad:Quad = new Quad(50, 50);
			layout.addElement(quad, $x(10).pct, $y(10).pct);
			
			var animation:LayoutAnimation = new LayoutAnimation(quad, 0.5, [$x(40).pct, $y(40).pct], null, layout.context);
			animation.play().then(function():void
			{
				Assert.assertTrue(Math.round(quad.x) == 40);
				Assert.assertTrue(Math.round(quad.y) == 40);
				
				dispatchEvent(new Event(Event.COMPLETE));
			});
			
			// wait for completion
			Async.handleEvent(this, this, Event.COMPLETE, function():void{}, 600);
		}
		
		[Test(async, timeout="600")]
		public function testMoveBaseOnCpx() : void 
		{
			var layout:Layout = new Layout(new Container(100, 100));
			var quad:Quad = new Quad(50, 50);
			layout.addElement(quad, $x(10).cpx, $y(10).cpx);
			
			var animation:LayoutAnimation = new LayoutAnimation(quad, 0.5, [$x(40).cpx, $y(40).cpx]);
			animation.play().then(function():void
			{
				Assert.assertTrue(quad.x == 20);
				Assert.assertTrue(quad.y == 20);
				
				dispatchEvent(new Event(Event.COMPLETE));
			});
			
			// wait for completion
			Async.handleEvent(this, this, Event.COMPLETE, function():void{}, 600);
		}
		
		[Test(async, timeout="600")]
		public function testResizeBaseOnPx() : void 
		{
			var layout:Layout = new Layout(new Container(100, 100));
			var quad:Quad = new Quad(50, 50);
			layout.addElement(quad, $width(50).px, $height(50).px);
			
			var animation:LayoutAnimation = new LayoutAnimation(quad, 0.5, [$width(10).px, $height(80).px]);
			animation.play().then(function():void
			{
				Assert.assertTrue(quad.width == 10);
				Assert.assertTrue(quad.height == 80);
				
				dispatchEvent(new Event(Event.COMPLETE));
			});
			
			// wait for completion
			Async.handleEvent(this, this, Event.COMPLETE, function():void{}, 600);
		}
		
		[Test(async, timeout="600")]
		public function testResizeBaseOnPct() : void 
		{
			var layout:Layout = new Layout(new Container(100, 100));
			var quad:Quad = new Quad(50, 50);
			layout.addElement(quad, $width(50).pct, $height(50).pct);
			
			var animation:LayoutAnimation = new LayoutAnimation(quad, 0.5, [$width(10).pct, $height(80).pct], null, layout.context);
			animation.play().then(function():void
			{
				Assert.assertTrue(Math.round(quad.width) == 10);
				Assert.assertTrue(Math.round(quad.height) == 80);
				
				dispatchEvent(new Event(Event.COMPLETE));
			});
			
			// wait for completion
			Async.handleEvent(this, this, Event.COMPLETE, function():void{}, 600);
		}
		
		[Test(async, timeout="600")]
		public function testResizeBaseOnCpx() : void 
		{
			var layout:Layout = new Layout(new Container(100, 100));
			var quad:Quad = new Quad(50, 50);
			layout.addElement(quad, $width(50).cpx, $height(50).cpx);
			
			var animation:LayoutAnimation = new LayoutAnimation(quad, 0.5, [$width(10).cpx, $height(80).cpx]);
			animation.play().then(function():void
			{
				Assert.assertTrue(quad.width == 5);
				Assert.assertTrue(quad.height == 40);
				
				dispatchEvent(new Event(Event.COMPLETE));
			});
			
			// wait for completion
			Async.handleEvent(this, this, Event.COMPLETE, function():void{}, 600);
		}
		
		[Test(async, timeout="600")]
		public function testPivotsBaseOnPx() : void 
		{
			var layout:Layout = new Layout(new Container(100, 100));
			var quad:Quad = new Quad(50, 50);
			layout.addElement(quad, $pivotX(0).px, $pivotY(0).px);
			
			var animation:LayoutAnimation = new LayoutAnimation(quad, 0.5, [$pivotX(10).px, $pivotY(10).px]);
			animation.play().then(function():void
			{
				Assert.assertTrue(quad.pivotX == 10);
				Assert.assertTrue(quad.pivotY == 10);
				
				dispatchEvent(new Event(Event.COMPLETE));
			});
			
			// wait for completion
			Async.handleEvent(this, this, Event.COMPLETE, function():void{}, 600);
		}
		
		[Test(async, timeout="600")]
		public function testPivotsBaseOnPct() : void 
		{
			var layout:Layout = new Layout(new Container(100, 100));
			var quad:Quad = new Quad(50, 50);
			layout.addElement(quad, $pivotX(0).pct, $pivotY(0).pct);
			
			var animation:LayoutAnimation = new LayoutAnimation(quad, 0.5, [$pivotX(50).pct, $pivotY(50).pct]);
			animation.play().then(function():void
			{
				Assert.assertTrue(Math.round(quad.pivotX) == 25);
				Assert.assertTrue(Math.round(quad.pivotY) == 25);
				
				dispatchEvent(new Event(Event.COMPLETE));
			});
			
			// wait for completion
			Async.handleEvent(this, this, Event.COMPLETE, function():void{}, 600);
		}
	}
}