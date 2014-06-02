// =================================================================================================
//
//	Firefly Framework
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.audio
{
	import com.firefly.core.Firefly;
	import com.firefly.core.consts.SystemType;
	
	/** Pool of cached sound effects that are played repeatedly. */	
	public class SFXPool implements IAudio
	{
		/** @private */		
		private var _sounds:Vector.<IAudio> = new Vector.<IAudio>();
		/** @private */
		private var _index:uint = 0;
		/** @private */
		private var _volume:Number = 1;
		
		/** Constructor.  
		 *  @param source Sound effect source
		 *  @param count Number of cached sound effects.
		 */		
		public function SFXPool(count:uint = 3)
		{
			for (var i:int = 0; i < count; i++) 
			{
				if(Firefly.current.systemType == SystemType.ANDROID)
					_sounds.push(new SFXAndroid());
				else
					_sounds.push(new SFXDefault());
			}
		}
		
		/** @inheritDoc */	
		public function get volume():Number { return _volume; }
		public function set volume(value:Number):void
		{
			_volume = value;
			
			for each (var sound:IAudio in _sounds) 
			{
				sound.volume = value;
			}
		}
		
		/** @inheritDoc */		
		public function load(sourceId:String, source:*):void
		{
			for each (var sound:IAudio in _sounds) 
			{
				sound.load(sourceId, source);
			}
		}
		
		/** @inheritDoc */		
		public function play(loop:int=0, volume:Number=1):void
		{
			_volume = volume;
			
			_sounds[_index].play(loop, volume);

			_index++;
			
			if(_index >= _sounds.length)
				_index = 0;
		}
		
		/** @inheritDoc */	
		public function update():void
		{
			for each (var sound:IAudio in _sounds) 
			{
				sound.update();
			}
		}
		
		/** @inheritDoc */	
		public function stop():void
		{
			for each (var sound:IAudio in _sounds) 
			{
				sound.stop();
			}
		}
		
		/** @inheritDoc */	
		public function unload():void
		{
			for each (var sound:IAudio in _sounds) 
			{
				sound.unload();
			}
		}
		
		/** @inheritDoc */	
		public function dispose():void
		{
			for each (var sound:IAudio in _sounds) 
			{
				sound.dispose();
			}
		}
	}
}