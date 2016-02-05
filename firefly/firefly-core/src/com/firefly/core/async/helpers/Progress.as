// =================================================================================================
//
//	Firefly Framework
//	Copyright 2016 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.async.helpers
{
	
	/** Progress value object. */	
	public class Progress
	{
		/** Constructor.
		 *  @param current Current completed events.
		 *  @param total Total events. */		
		public function Progress(current:Number, total:Number)
		{
			this.current = current;
			this.total = total;
		}
		
		/** Current completed events. */		
		public var total:Number;
		
		/** Total events. */		
		public var current:Number;
	}
	
}