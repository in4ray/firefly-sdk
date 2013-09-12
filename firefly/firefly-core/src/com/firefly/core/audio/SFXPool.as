
package com.firefly.core.audio
{
	import com.firefly.core.Firefly;
	import com.firefly.core.consts.SystemType;
	
	/**
	 * Pool of cached sounds that are played repeatedly.
	 */	
	public class SFXPool implements IAudio
	{
		private var sounds:Vector.<IAudio> = new Vector.<IAudio>();
		
		private var index:uint = 0;
		private var _volume:Number = 1;
		
		/**
		 * Constructor.
		 *  
		 * @param source Sound source
		 * @param count Number of cached sound effects.
		 */		
		public function SFXPool(count:uint = 3)
		{
			for (var i:int = 0; i < count; i++) 
			{
				if(Firefly.current.systemType == SystemType.ANDROID)
					sounds.push(new SFXAndroid());
				else
					sounds.push(new SFXDefault());
			}
		}
		
		/**
		 * @inheritDoc
		 */		
		public function load(source:*):void
		{
			for each (var sound:IAudio in sounds) 
			{
				sound.load(source);
			}
		}
		
		/**
		 * @inheritDoc
		 */	
		public function play(loop:int=0, volume:Number=1):void
		{
			_volume = volume;
			
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
			for each (var sound:IAudio in sounds) 
			{
				sound.stop();
			}
		}
		
		/**
		 * @inheritDoc
		 */	
		public function unload():void
		{
			for each (var sound:IAudio in sounds) 
			{
				sound.unload();
			}
		}
		
		public function dispose():void
		{
			for each (var sound:IAudio in sounds) 
			{
				sound.dispose();
			}
		}
		
		public function update():void
		{
			for each (var sound:IAudio in sounds) 
			{
				sound.update();
			}
		}
		
		public function get volume():Number
		{
			return _volume;
		}
		
		public function set volume(value:Number):void
		{
			_volume = value;
			
			for each (var sound:IAudio in sounds) 
			{
				sound.volume = value;
			}
		}
	}
}