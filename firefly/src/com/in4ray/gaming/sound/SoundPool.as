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
	import com.in4ray.gaming.sound.Audio;
	import com.in4ray.gaming.sound.IAudioEffect;
	
	/**
	 * Pool of cached sounds that are played repeatedly.
	 */	
	public class SoundPool implements IAudioEffect
	{
		private var sounds:Vector.<IAudioEffect> = new Vector.<IAudioEffect>();
		
		private var index:uint = 0;
		
		/**
		 * Constructor.
		 *  
		 * @param source Sound source
		 * @param count Number of cached sound effects.
		 */		
		public function SoundPool(source:*, count:uint = 3)
		{
			for (var i:int = 0; i < count; i++) 
			{
				sounds.push(Audio.getSound(source));
			}
		}
		
		/**
		 * @inheritDoc
		 */		
		public function init(source:*):void
		{
			for each (var sound:IAudioEffect in sounds) 
			{
				sound.init(source);
			}
		}
		
		/**
		 * @inheritDoc
		 */	
		public function play(loop:int=0, volume:Number=1):void
		{
			sounds[index].play(loop, volume);

			index++;
			
			if(index >= sounds.length)
				index = 0;
		}
		
		/**
		 * @inheritDoc
		 */	
		public function stop():void
		{
			for each (var sound:IAudioEffect in sounds) 
			{
				sound.stop();
			}
		}
		
		/**
		 * @inheritDoc
		 */	
		public function dispose():void
		{
			for each (var sound:IAudioEffect in sounds) 
			{
				sound.dispose();
			}
		}
	}
}