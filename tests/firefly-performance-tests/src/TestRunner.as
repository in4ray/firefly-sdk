// =================================================================================================
//
//	Firefly Framework
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package
{
	import com.firefly.core.async.Completer;
	import com.firefly.core.async.Future;
	import com.firefly.core.async.GroupCompleter;
	import com.firefly.core.async.NextFrameCompleter;
	import com.firefly.core.components.GameApp;
	import com.firefly.core.utils.ClassFactory;
	import com.firefly.tests.PerformanceTest;
	
	import starling.animation.Tween;
	import starling.core.starling_internal;
	
	use namespace starling_internal;
	public class TestRunner extends GameApp
	{
		public function TestRunner()
		{
			super();
			
			var test:PerformanceTest = new PerformanceTest();
			test.testCreation(new ClassFactory(Future));
			test.testCreation(new ClassFactory(Completer));
			test.testCreation(new ClassFactory(GroupCompleter));
			test.testCreation(new ClassFactory(NextFrameCompleter));
			//test.testCreation(new ClassFactory(Tween, null, 0));
			/*test.testCreation(new ClassFactory(DelayedCompleter, 1))*/
			
			
			/*test.testCreation(new ClassFactory(Point));
			test.testFunction(new ClassFactory(Point), "setTo", 0, 0);
			test.testFunction(new ClassFactory(Rectangle), "offsetPoint", new ClassFactory(Point, 1,1));*/
			
			test.run(true);
			
		}
		
		public static function fromPool():void
		{
			Tween.fromPool(null,0);
		}
	}
}