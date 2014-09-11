package com.in4ray.audio
{
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;

	public class AudioInterface
	{
		private var soundPool:Vector.<AudioItem>;
		private var musicPool:Vector.<AudioItem>;
		private var index:uint;
		
		/**
		 * Constructor 
		 */		
		public function AudioInterface(maxStreams:int = 10)
		{
			soundPool = new Vector.<AudioItem>();
			musicPool = new Vector.<AudioItem>();
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
			var soundItem:AudioItem = new AudioItem();
			soundItem.audio = new Sound(); 
			soundItem.audio.addEventListener(Event.COMPLETE, onSoundLoaded); 
			var req:URLRequest = new URLRequest(path); 
			soundItem.audio.load(req); 
			
			index++;
			soundItem.id = index;
			soundPool.push(soundItem);
			
			function onSoundLoaded(event:Event):void
			{ 
				for each(var soundItem:AudioItem in soundPool)
				{
					if(soundItem.audio == event.target)
					{
						soundItem.isLoaded = true;
						break;
					}
				}
			}
			
			return soundItem.id;
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
			return true;
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
			for each(var soundItem:AudioItem in soundPool)
			{
				if(soundItem.id == soundID && soundItem.isLoaded)
				{
					soundItem.channel = soundItem.audio.play(0, loop);
					break;
				}
			}
			return soundID;
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
			for each(var soundItem:AudioItem in soundPool)
			{
				if(soundItem.id == streamID && soundItem.channel)
				{
					soundItem.channel.stop();
					break;
				}
			}
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
		}
		
		/**
		 * Set sound volume.
		 * 
		 * @param streamID - the value returned by the play() function.
		 * @param volumeFactor - volume coeficient (range = 0.0 to 1.0)
		 */		
		public function setSoundVolume(streamID:int, volumeFactor:Number = 1.0):void
		{
			for each(var soundItem:AudioItem in soundPool)
			{
				if(soundItem.id == streamID && soundItem.channel)
				{
					soundItem.channel.soundTransform = new SoundTransform(volumeFactor);
					break;
				}
			}
		}
		
		
		/**
		 * Load music from a specific path and store into hash table by mediaID.
		 *  
		 * @param mediaID - music id.
		 * @param path - path to sound file in the system 
		 */		
		public function loadMusic(mediaID:int, path:String):void
		{
			var musicItem:AudioItem = new AudioItem();
			musicItem.audio = new Sound(); 
			musicItem.audio.addEventListener(Event.COMPLETE, onMusicLoaded); 
			var req:URLRequest = new URLRequest(path); 
			musicItem.audio.load(req); 
			
			musicItem.id = mediaID;
			musicPool.push(musicItem);
			
			function onMusicLoaded(event:Event):void
			{ 
				for each(var musicItem:AudioItem in musicPool)
				{
					if(musicItem.audio == event.target)
					{
						musicItem.isLoaded = true;
						break;
					}
				}
			}
		}
		
		
		/**
		 * Unload music.
		 *  
		 * @param mediaIDD - music id.
		 */
		public function unloadMusic(mediaID:int):void
		{
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
			for each(var musicItem:AudioItem in musicPool)
			{
				if(musicItem.id == mediaID && musicItem.isLoaded)
				{
					musicItem.channel = musicItem.audio.play(0, loop ? int.MAX_VALUE : 0);
					break;
				}
			}
		}
		/**
		 * Stop music.
		 *  
		 * @param mediaID - music id.
		 */		
		public function stopMusic(mediaID:int):void
		{
			for each(var musicItem:AudioItem in musicPool)
			{
				if(musicItem.id == mediaID && musicItem.channel)
				{
					musicItem.channel.stop();
					break;
				}
			}
		}
		
		/**
		 * Set music volume.
		 *  
		 * @param mediaID - music id.
		 */		
		public function setMusicVolume(mediaID:int, volumeFactor:Number = 1.0):void
		{
			for each(var musicItem:AudioItem in musicPool)
			{
				if(musicItem.id == mediaID && musicItem.channel)
				{
					musicItem.channel.soundTransform = new SoundTransform(volumeFactor);
					break;
				}
			}
		}
		
		/**
		 * Is music playing.
		 *  
		 * @param mediaID - music id.
		 */		
		public function isMusicPlaying(mediaID:int):Boolean
		{
			var isMusicPlaying:Boolean;
			return isMusicPlaying;
		}
	}
}
import flash.media.Sound;
import flash.media.SoundChannel;

class AudioItem
{
	public var audio:Sound;
	public var channel:SoundChannel;
	public var isLoaded:Boolean;
	public var id:uint;
	
	public function AudioItem()
	{
	}
}