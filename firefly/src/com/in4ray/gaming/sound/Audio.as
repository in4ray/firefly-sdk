// =================================================================================================
//
//	in4ray Gaming SDK
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.in4ray.gaming.sound
{
	import com.in4ray.gaming.binding.BindableNumber;
	import com.in4ray.gaming.consts.SystemType;
	import com.in4ray.gaming.core.GameGlobals;

	/**
	 * Class that helps to create audio effects. 
	 */	
	public class Audio
	{
		/**
		 * Maximum count of audio streams. 
		 */		
		public static var maxAudioStreams:int = 10;
		
		/**
		 * Volume of all sounds 0-1. 
		 */		
		public static var soundVolume:BindableNumber = new BindableNumber(1);
		
		/**
		 * Volume of all musics 0-1.
		 */		
		public static var musicVolume:BindableNumber = new BindableNumber(1);
		
		/**
		 * Create sound effect depending on operation system (IOS or Android). 
		 * @param source Sound source file (mp3).
		 * @return Instance of sound effect.
		 */		
		public static function getSound(source:*):IAudioEffect
		{
			var audioEffect:IAudioEffect;
			if(GameGlobals.systemType == SystemType.ANDROID)
				audioEffect = new SoundAndroid();
			else
				audioEffect = new SoundDefault();
			
			audioEffect.init(source);
			
			return audioEffect;
		}
		
		/**
		 * Create music effect depending on operation system (IOS or Android). 
		 * @param source Music source file (mp3).
		 * @return Instance of music effect.
		 */	
		public static function getMusic(source:*):IAudioEffect
		{
			var audioEffect:IAudioEffect;
			if(GameGlobals.systemType == SystemType.ANDROID)
				audioEffect = new MusicAndroid();
			else
				audioEffect = new MusicDefault();
			
			audioEffect.init(source);
			
			return audioEffect;
		}
	}
}

