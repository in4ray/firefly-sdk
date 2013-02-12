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
	import com.in4ray.gaming.core.GameGlobals;
	
	import flash.events.Event;

	/**
	 * Call function on next players frame.
	 * 
	 * @param func Function to ba called.
	 * @param params Parameters to be send into function above. 
	 */	
	public function callNextFrame(func:Function, ...params):void
	{
		GameGlobals.gameApplication.stage.addEventListener(Event.ENTER_FRAME, function enterFrameHandler(event:Event):void
		{
			GameGlobals.gameApplication.stage.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
			
			func.apply(null, params);
		});
	}
}