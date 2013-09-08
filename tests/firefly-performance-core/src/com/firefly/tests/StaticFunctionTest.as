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
	
	import avmplus.getQualifiedClassName;

	public class StaticFunctionTest implements ITest
	{
		public function StaticFunctionTest(className:Class, func:String, args:Array)
		{
			this.className = className;
			this.args = args;
			this.func = func;
		}
		
		
		protected var func:String;
		
		protected var className:Class;
		
		protected var args:Array;
		
		public var before:Function;
		public var testFunc:Function;
		public var after:Function;
		
		public function run():void
		{
			// actual test
			var startTime:Number;
			var totalTime:Number = 0;
			var i:int = 0;
			var runFunc:Function;
			var runArgs:Array = [];
			while(totalTime < 100 || i <= 3)
			{
				runFunc = getRunFunc();
				
				runArgs.length = 0;
				for each (var arg:* in args) 
				{
					if(arg is ClassFactory)
						runArgs.push(arg.newInstance());
					else
						runArgs.push(arg);
				}
				
				runBefore();
				
				startTime = new Date().time;
				runFunc.apply(null, runArgs);
				totalTime += new Date().time - startTime;
				i++;
				
				runAfter();
			}
			
			_duration = totalTime/i;
		}
		
		protected function runBefore():void
		{
			if(before != null)
				before();
		}
		
		
		protected function runAfter():void
		{
			if(after != null)
				after();
		}
		
		protected function getRunFunc():Function
		{
			return className[func];
		}
		
		public function toString():String
		{
			return Utility.formatString(getQualifiedClassName(className) + "." + func);
		}
		
		private var _duration:Number;

		
		public function get duration():Number
		{
			return _duration;
		}
	}
}