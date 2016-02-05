// =================================================================================================
//
//	Firefly Framework
//	Copyright 2016 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.audio
{
	/** Interface for audio classes. */	
	public interface IAudio
	{
		/** Initialize audio.
		 *  @param sourceId Unique identifier of Audio source.
		 *  @param source Audio source file (for androind .mp3/.ogg files and for IOS .mp3 only).
		 */		
		function load(sourceId:String, source:*):void
			
		/** Release memory. */		
		function unload():void;
		
		/** Update audio with global volume. */		
		function update():void;
		
		/** Audio volume value from 0 to 1 */		 
		function get volume():Number;
		function set volume(value:Number):void;
		
		/** Play audio  
		 *  @param loop Flag that indicate whether audio should be looped. 
		 *  @param volume Audio volume value in range from 0 to 1. */			
		function play(loop:int = 0, volume:Number = 1):void;
		
		/** Stop playing audio. */		
		function stop():void;
		
		/** Clean up class to be ready for garbage collection. */		
		function dispose():void;
	}
}