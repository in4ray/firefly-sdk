// =================================================================================================
//
//	Firefly Framework
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.tests
{
	import com.firefly.core.utils.ClassFactory;
	
	import flash.utils.setTimeout;

	public class PerformanceTest
	{
		public function PerformanceTest()
		{
		}
		
		private var tests:Vector.<ITest> = new Vector.<ITest>();
		
		public function testCreation(factory:ClassFactory):void
		{
			tests.push(new CreationTest(factory));
		}
		
		public function testStaticFunction(className:Class, func:String, ...args):StaticFunctionTest
		{
			var test:StaticFunctionTest = new StaticFunctionTest(className, func, args); 
			tests.push(test);
			
			return test;
		}
		
		public function testFunction(factory:ClassFactory, func:String, ...args):FunctionTest
		{
			var test:FunctionTest = new FunctionTest(factory, func, args); 
			tests.push(test);
			
			return test;
		}
		
		public function run(showFailures:Boolean = false):void
		{
			setTimeout(runInternal, 500, showFailures);
		}
		
		private function runInternal(showFailures:Boolean = false):void
		{
			for each (var test:ITest in tests) 
			{
				try
				{
					test.run();
					trace("[test] " + test.toString() + " " + test.duration.toFixed(5) + " ms.")
				} 
				catch(error:Error) 
				{
					trace("[test] " + test.toString() + " FAILED.")
					if(showFailures)
						trace(error.getStackTrace());
				}
				
			}
		}
	}
}