// =================================================================================================
//
//	Firefly Framework
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.async
{
	import com.firefly.core.firefly_internal;
	
	import flash.utils.setTimeout;
	
	import starling.animation.Juggler;
	import starling.core.Starling;
	
	use namespace firefly_internal;
	
	/** Class that used to trigger Future objects after specified delay.
	 * 
	 *  @example The following code shows how to trigger Future objects after 10 sec:
	 *  <listing version="3.0">
	 *************************************************************************************
 function main():void
 {
	 var completer:DelayedCompleter = new DelayedCompleter(10);
 	completer.future.then(callbackFunction);
 }
 &#xA0;
 function callbackFunction():void
 {
 	trace("Triggered after 10 sec.");
 }
	 *************************************************************************************
	 *  </listing> */	
	public class DelayedCompleter extends Completer
	{
		/** Constructor.
		 * @param delay Delay in sec after which Future objects will be triggered.
		 * @param juggler Juggler object. If not specified then <code>Starling.juggler</code> will be used. */		
		public function DelayedCompleter(delay:Number, juggler:Juggler=null)
		{
			super();
			
			this.juggler = juggler ? juggler : Starling.juggler;
			this.delay = delay;
			
			if(juggler)
				juggler.delayCall(onDelay, delay);
			else
				setTimeout(onDelay, delay*1000);
		}
		
		/** Delay in sec after which Future objects will be triggered. */		
		public var delay:Number;
		
		/** Juggler object to be used for timer. */		
		public var juggler:Juggler;
		
		/** @private */		
		private function onDelay():void
		{
			complete();
		}
	}
}