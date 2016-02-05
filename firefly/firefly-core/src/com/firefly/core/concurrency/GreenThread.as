// =================================================================================================
//
//	Firefly Framework
//	Copyright 2016 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.concurrency
{
	import com.firefly.core.firefly_internal;
	import com.firefly.core.async.Future;
	
	use namespace firefly_internal;
	
	/** GreenThread simulates concurrency via timer with little delay. */
	public class GreenThread
	{
		private var _running:Boolean;
		private var _waitingNextFrame:Boolean;
		private var _tasks:Vector.<Task> = new Vector.<Task>();
		
		/** Constructor. */		
		public function GreenThread()
		{
		}
		
		/** Is thread currently working. */		
		public function get running():Boolean { return _running; }
		
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
			_running = false;
		}
		
		/** Resume thread. */	
		public function resume():void
		{
			if(!_waitingNextFrame)
				Future.nextFrame().then(nextFrame);
			
			_waitingNextFrame = true;
			_running = true;
		}
		
		/** @private */		
		private function nextFrame():void
		{
			_waitingNextFrame = false;
			
			if(_running)
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
		}
		
		/** @private */		
		private function taskComplete(task:Task):void
		{
			// complete task
			task.complete();
			
			if(isComplete)
				pause();
			else
				Future.nextFrame().then(nextFrame);
		}
	}
}