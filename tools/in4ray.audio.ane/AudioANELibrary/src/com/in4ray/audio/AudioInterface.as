package com.in4ray.audio
{
	import flash.external.ExtensionContext;

	public class AudioInterface
	{
		private static var extContext:ExtensionContext = null;
		
		/**
		 * Constructor 
		 */		
		public function AudioInterface(maxStreams:int = 10)
		{
			if (!extContext)
			{  
				extContext = ExtensionContext.createExtensionContext("com.in4ray.AudioInterface", "audioInterface");
				extContext.call("init", maxStreams);
			}
		}
		
		/**
		 * Load the sound from the specified path.
		 * 
		 * @param path - path to sound file in the system
		 * 
		 * @return - soundID
		 */		
		public function loadSound(path:String):int 
		{ 
			var soundID:int = extContext.call("loadSound", path) as int;
			return soundID;
		}
		
		
		/**
		 * Unload a sound from a sound ID. Unloads the sound specified by the soundID.
		 * This is the value returned by the load() function. Returns true if the sound
		 * is successfully unloaded, false if the sound was already unloaded. 
		 * 
		 * @param soundID - a soundID returned by the load() function.
		 * 
		 * @return - true if the sound is successfully unloaded, false if the sound was already unloaded.
		 */		
		public function unloadSound(soundID:int):Boolean
		{
			var unloaded:Boolean = extContext.call("unloadSound", soundID) as Boolean;
			return unloaded;
		}
		
		/**
		 * Play a sound from a sound ID. Play the sound specified by the soundID.
		 * This is the value returned by the load() function. Returns a non-zero
		 * streamID if successful, zero if it fails. The streamID can be used to
		 * further control playback.
		 * 
		 * @param soundID - the sound specified by the soundID.This is the value
		 * returned by the load() function
		 * @param volumeFactor - volume coeficient (range = 0.0 to 1.0)
		 * @param priority - stream priority.
		 * @param loop - A loop value of -1 means loop forever, a value of 0 means
		 * don't loop, other values indicate the number of repeats.
		 * @param rate - The playback rate allows the application to vary the
		 * playback rate (pitch) of the sound. A value of 1.0 means play back at
		 * the original frequency. A value of 2.0 means play back twice as fast,
		 * and a value of 0.5 means playback at half speed.
		 * 
		 * @return - streamID
		 */		
		public function playSound(soundID:int, volumeFactor:Number = 1.0, priority:int = 1, loop:int = 0, rate:Number = 1.0):int 
		{ 
			var streamID:int = extContext.call("playSound", soundID, volumeFactor, priority, loop, rate) as int;
			return streamID;
		}
		
		/**
		 * Stop a playback stream. Stop the stream specified by the streamID.
		 * This is the value returned by the play() function. If the stream is playing,
		 * it will be stopped. It also releases any native resources associated
		 * with this stream. If the stream is not playing, it will have no effect. 
		 * 
		 * @param streamID - the value returned by the play() function.
		 */		
		public function stopSound(streamID:int):void
		{
			extContext.call("stopSound", streamID);
		}
		
		/**
		 * Pause a playback stream. Pause the stream specified by the streamID.
		 * This is the value returned by the play() function. If the stream is playing,
		 * it will be paused. If the stream is not playing (e.g. is stopped or was
		 * previously paused), calling this function will have no effect.
		 * 
		 * @param streamID - the value returned by the play() function.
		 */		
		public function pauseSound(streamID:int):void
		{
			extContext.call("pauseSound", streamID);
		}
		
		/**
		 * Set sound volume.
		 * 
		 * @param streamID - the value returned by the play() function.
		 * @param volumeFactor - volume coeficient (range = 0.0 to 1.0)
		 */		
		public function setSoundVolume(streamID:int, volumeFactor:Number = 1.0):void
		{
			extContext.call("setSoundVolume", streamID, volumeFactor);
		}
		
		
		/**
		 * Load music from a specific path and store into hash table by mediaID.
		 *  
		 * @param mediaID - music id.
		 * @param path - path to sound file in the system 
		 */		
		public function loadMusic(mediaID:int, path:String):void
		{
			extContext.call("loadMusic", mediaID, path);
		}
		
		
		/**
		 * Unload music.
		 *  
		 * @param mediaIDD - music id.
		 */
		public function unloadMusic(mediaID:int):void
		{
			extContext.call("unloadMusic", mediaID);
		}
		
		/**
		 * Play music. Starts or resumes playback.
		 *  
		 * @param mediaID - music id.
		 * @param volumeFactor - volume coeficient (range = 0.0 to 1.0)
		 * @param loop - looping (true or false)
		 * 
		 */		
		public function playMusic(mediaID:int, volumeFactor:Number = 1.0, loop:Boolean = false):void
		{
			extContext.call("playMusic", mediaID, volumeFactor, loop);
		}
		
		/**
		 * Stop music.
		 *  
		 * @param mediaID - music id.
		 */		
		public function stopMusic(mediaID:int):void
		{
			extContext.call("stopMusic", mediaID);
		}
		
		/**
		 * Set music volume.
		 *  
		 * @param mediaID - music id.
		 * @param volumeFactor - volume coeficient (range = 0.0 to 1.0)
		 */		
		public function setMusicVolume(mediaID:int, volumeFactor:Number = 1.0):void
		{
			extContext.call("setMusicVolume", mediaID, volumeFactor);
		}
		
		/**
		 * Is music playing.
		 *  
		 * @param mediaID - music id.
		 */		
		public function isMusicPlaying(mediaID:int):Boolean
		{
			var isMusicPlaying:Boolean = extContext.call("isMusicPlaying", mediaID);
			return isMusicPlaying;
		}
	}
}