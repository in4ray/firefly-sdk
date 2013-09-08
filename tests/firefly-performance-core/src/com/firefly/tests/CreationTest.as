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

	public class CreationTest implements ITest
	{
		private var factory:ClassFactory;
		
		public function CreationTest(factory:ClassFactory):void
		{
			this.factory = factory;
		}
		
		public function run():void
		{
			// to load class
			factory.newInstance();
			
			// actual test
			var startTime:Number = new Date().time;
			var totalTime:Number = 0;
			var i:int = 0;
			while(totalTime < 100 || i <= 3)
			{
				factory.newInstance();
				
				totalTime = new Date().time - startTime;
				i++;
			}
			
			_duration = totalTime/i;
		}
		
		public function toString():String
		{
			return Utility.formatString(getQualifiedClassName(factory.className));
		}
		
		private var _duration:Number;
		
		public function get duration():Number
		{
			return _duration;
		}
	}
}