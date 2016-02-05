// =================================================================================================
//
//	Firefly Framework
//	Copyright 2016 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.async
{
	import com.firefly.core.firefly_internal;
	import com.firefly.core.async.helpers.Progress;
	
	use namespace firefly_internal;
	
	/** Class that groups several Future objects in one and call progress function for each complition.
	 *  Complete callback will be called then all Future objects is completed. 
	 * 
	 *  @example The following code sets progress callback function:
	 *  <listing version="3.0">
*************************************************************************************
function main():void
{
	var group:GroupCompleter = new GroupCompleter(new DelayedCompleter(1).future, new DelayedCompleter(2).future);
	completer.future.progress(onProgressFunction, 10).then(completeFunction);
}
&#xA0;
function onProgressFunction(ratio:Number, arg1:String):void
{
	trace("Progress: " + ratio~~100 + "% arg1: " + arg1);
}
&#xA0;
function completeFunction():void
{
	trace("Group completed.");
}
*************************************************************************************
	 *  </listing> */	
	public class GroupCompleter extends Completer
	{
		private var _futures:Vector.<Future> = new Vector.<Future>();
		private var _completed:Vector.<Future> = new Vector.<Future>();
		
		/**Constructor.
		 * @param args one or several Future objects to be grouped.*/		
		public function GroupCompleter(...args)
		{
			super();
			
			args.forEach(addInternal);
			
			sendCurrentProgress();
		}
		
		/** Append Future object into group.
		 *  @param future Fututre object to be grouped.
		 *  @param args Rest Fututre objects to be grouped. */		
		public function append(future:Future, ...args):void
		{
			_completed.length = 0;
			
			addInternal(future);
			
			if(args)
				args.forEach(addInternal);
			
			sendCurrentProgress();
		}
		
		/** @private */		
		private function addInternal(future:Future, index:int=0, args:Array=null):void
		{
			_futures.push(future);
			future.then(futureComplete, future);
			future.progress(futureProgress, future);
		}
		
		/** @private */	
		private function futureComplete(...args):void
		{
			var index:int = _futures.indexOf(args[args.length-1]);
			if(index >= 0)
				_completed.push(_futures.splice(index, 1)[0]);
			
			sendCurrentProgress();
			
			if(_futures.length == 0)
			{
				complete();
				_completed.length = 0;
			}
		}
		
		/** @private */	
		private function futureProgress(ratio:Number, ...args):void
		{
			if(ratio < 1)
				sendCurrentProgress();
		}
		
		/** @private */	
		private function sendCurrentProgress():void
		{
			var completeCount:Number = 0;
			var totalCount:Number = 0;
			var f:Future;
			
			for each (f in _completed) 
			{
				totalCount += f.currentProgress ? f.currentProgress.total : 1;
				completeCount += f.currentProgress ? f.currentProgress.current : 1;
			}
			
			for each (f in _futures) 
			{
				totalCount += f.currentProgress ? f.currentProgress.total : 1;
				completeCount += f.currentProgress ? f.currentProgress.current : 0;
			}
			
			sendProgress(new Progress(completeCount, totalCount));
		}
	}
}