package test.effects
{
	import com.firefly.core.effects.LayoutAnimation;
	import com.firefly.core.effects.Move;
	import com.firefly.core.layouts.Layout;
	import com.firefly.core.layouts.constraints.$x;
	import com.firefly.core.layouts.constraints.$y;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import starling.display.Quad;
	
	import test.layouts.helpers.Container;
	
	public class MoveAnimationTest extends EventDispatcher
	{
		[Test(async, timeout="600")]
		public function testMoveBaseOnPxWithDuration() : void 
		{
			var layout:Layout = new Layout(new Container(100, 100));
			var quad:Quad = new Quad(50, 50);
			layout.addElement(quad, $x(10).px, $y(10).px);
			
			var animation:Move = new Move(quad, 0.5, $x(40).px, $y(40).px);
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
		public function testMoveBaseOnPx() : void 
		{
			var layout:Layout = new Layout(new Container(100, 100));
			var quad:Quad = new Quad(50, 50);
			layout.addElement(quad, $x(10).px, $y(10).px);
			
			var animation:Move = new Move(quad, NaN, $x(40).px, $y(40).px);
			animation.speed = 200;
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
		public function testMoveBaseOnCpx() : void 
		{
			var layout:Layout = new Layout(new Container(100, 100));
			var quad:Quad = new Quad(50, 50);
			layout.addElement(quad, $x(10).px, $y(10).px);
			
			var animation:Move = new Move(quad, NaN, $x(40).cpx, $y(40).cpx);
			animation.speed = 300;
			animation.play().then(function():void
			{
				Assert.assertTrue(quad.x == 20);
				Assert.assertTrue(quad.y == 20);
				
				dispatchEvent(new Event(Event.COMPLETE));
			});
			
			// wait for completion
			Async.handleEvent(this, this, Event.COMPLETE, function():void{}, 600);
		}
	}
}