// =================================================================================================
//
//	Firefly Framework
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.concurrency
{
	import com.firefly.core.firefly_internal;
	import com.firefly.core.async.Future;
	
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	use namespace firefly_internal;
	
	/** GreenThread simulates concurrency via timer with little delay. */
	public class GreenThread
	{
		private var _timer:Timer;
		private var _tasks:Vector.<Task> = new Vector.<Task>();
		
		/** Constructor. */		
		public function GreenThread()
		{
			_timer = new Timer(1);
			_timer.addEventListener(TimerEvent.TIMER, timerHandler);
		}
		
		/** Is thread currently working. */		
		public function get running():Boolean { return _timer.running; }
		
		/** Is thread currently finished. */	
		public function get isComplete():Boolean { return _tasks.length == 0; }
		
		/** Add new task at the end of schedule.
		 *  @param func Function to be performed.
		 *  @param args Arguments to be passed to function.
		 *  @return Future object for callback. */		
		public function schedule(func:Function, ...args):Future
		{
			var task:Task = new Task(func, args);
			_tasks.push(task);
			
			resume();
			
			return task.future;
		}
		
		/** Pause thread. */		
		public function pause():void
		{
			if(running)
				_timer.stop();
		}
		
		/** Resume thread. */	
		public function resume():void
		{
			if(!running)
				_timer.start();
		}
		
		/** @private */		
		private function timerHandler(event:Event):void
		{
			var task:Task = _tasks.shift();
			
			if (!task)
				return pause();
			
			// proceed task
			var future:Future = task.proceed();
			
			if(future)
				future.then(taskComplete, task);
			else
				taskComplete(task);
		}
		
		/** @private */		
		private function taskComplete(task:Task):void
		{
			// complete task
			task.complete();
			
			if(isComplete)
				pause();
			else
				_timer.start();
		}
	}
}