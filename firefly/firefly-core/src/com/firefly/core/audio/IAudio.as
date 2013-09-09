package com.firefly.core.audio
{
	import flash.utils.ByteArray;

	/**
	 * Interface for audio effects.
	 * 
	 */	
	public interface IAudio
	{
		/**
		 * Initialize audio.
		 *  
		 * @param source Audio source file (for androind .mp3/.ogg files and for IOS .mp3 only).
		 */		
		function load(source:ByteArray):void
			
		/**
		 * Play audio  
		 * @param loop Flag that indicate whether effect should be looped. 
		 * @param volume Effect volume value in range from 0 to 1.
		 */			
		function play(loop:int = 0, volume:Number = 1):void;
		
		/**
		 * Stop playing effect. 
		 */		
		function stop():void;
		
		/**
		 * Release memory. 
		 */		
		function unload():void;
	}
}