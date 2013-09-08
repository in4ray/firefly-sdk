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

	public class FunctionTest extends StaticFunctionTest
	{
		public function FunctionTest(factory:ClassFactory, func:String, args:Array)
		{
			super(factory.className, func, args)
			this.factory = factory;
		}
		
		private var factory:ClassFactory;
		
		override public function run():void
		{
			// to load class
			factory.newInstance();
			
			super.run();
		}
		
		private var currentInstance:Object;
		override protected function getRunFunc():Function
		{
			currentInstance = factory.newInstance();
			return currentInstance[func];
		}
		
		override protected function runBefore():void
		{
			if(before != null)
				before(currentInstance);
		}
		
		
		override protected function runAfter():void
		{
			if(after != null)
				after(currentInstance);
		}
	}
}