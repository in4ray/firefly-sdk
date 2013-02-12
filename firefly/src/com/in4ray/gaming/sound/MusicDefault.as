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
	import flash.media.SoundTransform;

	[ExcludeClass]
	public class MusicDefault extends SoundDefault
	{
		public function MusicDefault()
		{
			super();
		}
		
		override protected function bindVolume():void
		{
			Audio.musicVolume.bindListener(volumeHandler);
		}
		
		override public function play(loop:int = 0, volume:Number = 1):void
		{
			super.play(loop, volume);
			
			if(channel)
				channel.soundTransform = new SoundTransform(_userVolume*Audio.musicVolume.value);
		}
	}
}