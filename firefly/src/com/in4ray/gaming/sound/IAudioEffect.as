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
	/**
	 * Interface for audio effects.
	 * 
	 * @example The following example shows how to play game music:
	 *
	 * <listing version="3.0">
import com.in4ray.games.core.components.Sprite;
import com.in4ray.games.core.sound.Audio;
import com.in4ray.games.core.sound.IAudioEffect;

import starling.events.Event;
 
public class MainView extends Sprite
{
	[Embed(source="/sounds/sound1.mp3", mimeType="application/octet-stream")]
	private static var SoundClass:Class;
	
	private var audioEffect:IAudioEffect;
	
	public function MainView()
	{
		addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
	}
	
	private function addedToStageHandler(e:Event):void
	{
		audioEffect = Audio.getMusic(new SoundClass());
		audioEffect.play();
	}
}
	 * </listing> 
	 */	
	public interface IAudioEffect
	{
		/**
		 * Initialize audio effect.
		 *  
		 * @param source Audio source file (for androind .mp3/.ogg files and for IOS .mp3 only).
		 */		
		function init(source:*):void
			
		/**
		 * Play effect  
		 * @param loop Flag that indicate whether effect should be looped. 
		 * @param volume Effect volume value in range from 0 to 1.
		 */			
		function play(loop:int = 0, volume:Number = 1):void;
		
		/**
		 * Stop playing effect. 
		 */		
		function stop():void;
		
		/**
		 * Dispose effect, release memory. 
		 */		
		function dispose():void;
	}
}