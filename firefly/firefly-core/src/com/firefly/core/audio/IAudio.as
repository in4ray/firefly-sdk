package com.firefly.core.audio
{
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
		function load(source:*):void
			
		/**
		 * Release memory. 
		 */		
		function unload():void;
		
		/**
		 */		
		function update():void;
		
		/**
		 */		
		function get volume():Number;
		function set volume(value:Number):void;
		
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
		 * Pause playing effect. 
		 */		
		function pause():void;
		
		/**
		 * Continue playing effect. 
		 */		
		function resume():void;
		
		/**
		 */		
		function dispose():void;
	}
}