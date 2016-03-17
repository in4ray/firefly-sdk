// =================================================================================================
//
//	Firefly Framework
//	Copyright 2016 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.effects
{
	import com.firefly.core.async.Future;
	
	/** The animation class thats animates list of animation in sequence mode. 
	 * 
	 *  @see com.firefly.core.effects.GroupAnimationBase
	 * 
	 *  @example The following code shows how to use this class to animate the list of animations in
	 *  loop with repeat delay:
	 *  <listing version="3.0">
	 *************************************************************************************
var quad:Quad = new Quad(140, 140, 0x000000);
addChild(quad);
 
var animation:Sequence = new Sequence(quad, 5, [new Fade(quad, 2, 0.1), new Rotate(quad, NaN, deg2rad(30)), new Fade(quad, NaN, 1)]);
animation.repeatDelay = 1;
animation.repeatCount = 0;
animation.play();
	 *************************************************************************************
	 *  </listing> */
	public class Sequence extends GroupAnimationBase
	{
		/** @private */
		private var _currentIndex:int;
		
	   /** Constructor.
		*  @param target Target of animation. Will be used for child animations if they don't have own targets.
		*  @param duration Duration in seconds. Will be used for calculation average duration for child
		*  animations if they don't have own specified durations.
		*  @param animations Array of animations to be played. */
		public function Sequence(target:Object, duration:Number=NaN, animations:Array=null)
		{
			super(target, duration, animations);
		}
		
		/** @inheritDoc */
		override public function get isPlaying():Boolean 
		{ 
			if(_currentIndex > -1 && _currentIndex < length)
				return animations[_currentIndex].isPlaying;
			else
				return false;
		}
		
		/** @inheritDoc */
		override public function get isPause():Boolean 
		{ 
			if(_currentIndex > -1 && _currentIndex < length)
				return animations[_currentIndex].isPause;
			else
				return false;
		}
		
		/** @inheritDoc */
		override public function play():Future
		{
			_currentIndex = -1;
			calculateDuration();
			
			return super.play();
		}
		
		/** @inheritDoc */
		override public function pause():void
		{
			if(_currentIndex > -1 && _currentIndex < length)
				animations[_currentIndex].pause();
		}
		
		/** @inheritDoc */
		override public function resume():void
		{
			if(_currentIndex > -1 && _currentIndex < length)
				animations[_currentIndex].resume();
		}
		
		/** @inheritDoc */
		override public function stop():void
		{
			if(_currentIndex > -1 && _currentIndex < length)
				animations[_currentIndex].stop();
		}
		
		/** @inheritDoc */
		override public function end():void
		{
			if(_currentIndex > -1 && _currentIndex < length)
			{
				repeatCount = 1;
				
				for (var i:int = _currentIndex; i < length; i++) 
				{
					_currentIndex = length;
					
					if(!animations[i].target)
						animations[i].target = target;
					
					animations[i].end();
				}
			}
		}
		
		/** @private */
		override protected function playInternal():void
		{
			_currentIndex++;
			
			if(_currentIndex < length)
			{
				animation = animations[_currentIndex];
				
				if (animation.repeatCount == 0)
					animation.repeatCount = 1;
				if(!animation.target)
					animation.target = target;
				if(easer)
					animation.easer = easer;
				if(animation.isDefaultJuggler)
					animation.juggler = juggler;
				
				animation.play().then(playInternal).progress(onUpdate);
			}
			else if (repeatCount == 0 || repeatCount > 1)
			{
				Future.delay(repeatDelay).then(play);
				
				if (repeatCount > 1)
					repeatCount--;
			}
			else
			{
				animation = null;
				progress = null;
				completer.complete();
			}
		}
		
		/** @private */
		private function onUpdate(value:Number):void
		{
			progress.current = _currentIndex + value;
			progress.total = length;
			completer.sendProgress(progress);
		}
		
		/** @private */
		private function calculateDuration():void
		{
			var tDuration:Number = duration;
			var count:int = 0;
			var i:int;
			for (i = 0; i < length; i++) 
			{
				animation = animations[i];
				if (!isNaN(animation.duration))
					tDuration -= animation.duration;
				else
					count++;
			}
			
			if (tDuration > 0)
			{
				var avarageDuration:Number = tDuration/count;
				for (i = 0; i < length; i++) 
				{
					animation = animations[i];
					if (isNaN(animation.duration))
						animation.duration = avarageDuration;
				}
			}
		}
	}
}