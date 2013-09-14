package com.firefly.core.async
{
	import com.firefly.core.Firefly;
	import com.firefly.core.firefly_internal;
	
	import flash.events.Event;

	use namespace firefly_internal;
	
	/** Class that used to trigger Future objects on next Flash frame.
	 *  
	 *  @example The following code shows how to trigger Future objects on next frame:
	 *  <listing version="3.0">
*************************************************************************************
function main():void
{
	var completer:NextFrameCompleter = new NextFrameCompleter();
	completer.future.then(callbackFunction);
}
&#xA0;
function callbackFunction():void
{
	trace("Triggered on next frame.");
}
*************************************************************************************
	 *  </listing> */	
	public class NextFrameCompleter extends Completer
	{
		/** Constructor. */		
		public function NextFrameCompleter()
		{
			super();
			
			Firefly.current.main.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		/** @private */		
		protected function onEnterFrame(event:Event):void
		{
			Firefly.current.main.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			
			complete();
		}
	}
}