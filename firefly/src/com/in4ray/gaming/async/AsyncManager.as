// =================================================================================================
//
//	in4ray Gaming SDK
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.in4ray.gaming.async
{
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	/**
	 * Manager that emulates asyncronous calls.
	 */	
	public class AsyncManager
	{
		/**
		 * Constructor. 
		 */		
		public function AsyncManager()
		{
			timer = new Timer(10, int.MAX_VALUE);
			timer.addEventListener(TimerEvent.TIMER, timerHandler);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, timerCompleteHandler);
		}
		
		private var functions:Vector.<AsyncFunction> = new Vector.<AsyncFunction>();
		private var currentInsertFrame:int = -1;
		private var started:Boolean;
		private var timer:Timer;
		
		/**
		 * Add new function, will be placed right after last called function in queue. 
		 * 
		 * @param asyncFunction Function to be called.
		 */		
		public function add(asyncFunction:AsyncFunction):void
		{
			if(currentInsertFrame == -1)
			{
				functions.push(asyncFunction);
			}
			else
			{
				functions.splice(currentInsertFrame, 0, asyncFunction);
				currentInsertFrame++;
			}
			
			start();
		}
		
		/**
		 * Start async process. 
		 */		
		public function start():void
		{
			if(!started)
			{
				timer.start();
				started = true;
			}
		}
		
		/**
		 * Stop async process. 
		 */	
		public function stop():void
		{
			if(started)
			{
				timer.stop();
				started = false;
			}
		}
		
		/**
		 * Perform all operations in queue synchronously one by one.
		 */		
		public function flush():void
		{
			while(functions.length > 0)
			{
				functions.shift().call();
			}
			stop();
			currentInsertFrame = -1;
		}
		
		private function timerCompleteHandler(event:Event):void
		{
			timer.reset();
			if(functions.length > 0)
				timer.start();
		}
		
		private function timerHandler(event:Event):void
		{
			currentInsertFrame = 0;
			
			functions.shift().call();
			
			if(functions.length == 0)
				stop();
			
			currentInsertFrame = -1;
		}
	}
}