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
	import com.firefly.core.async.GroupCompleter;
	
	/** The animation class thats animates list of animation in parallel mode. 
	 * 
	 *  @see com.firefly.core.effects.GroupAnimationBase
	 * 
	 *  @example The following code shows how to use this class to animate the list of animations in
	 *  loop with repeat delay:
	 *  <listing version="3.0">
	 *************************************************************************************
var quad:Quad = new Quad(140, 140, 0x000000);
addChild(quad);
 
var animation:Parallel = new Parallel(quad, 5, [new Fade(quad, 2, 0.1), new Rotate(quad, NaN, deg2rad(30))]);
animation.repeatDelay = 1;
animation.repeatCount = 0;
animation.play();
	 *************************************************************************************
	 *  </listing> */
	public class Parallel extends GroupAnimationBase
	{
		/** Constructor.
		 *  @param target Target of animation, will be used for child animations if they don't have own targets. 
		 *  @param duration Duration in seconds, will be used for child animations if they don't have own specified durations.
		 *  @param animations Array of animations to be played. */
		public function Parallel(target:Object, duration:Number=NaN, animations:Array=null)
		{
			super(target, duration, animations);
		}
		
		/** @inheritDoc */
		override public function pause():void
		{
			super.pause();
			
			for (var i:int = 0; i < length; i++) 
			{
				animations[i].pause();
			}
		}
		
		/** @inheritDoc */
		override public function resume():void
		{
			super.resume();
			
			for (var i:int = 0; i < length; i++) 
			{
				animations[i].resume();
			}
		}
		
		/** @inheritDoc */
		override public function stop():void
		{
			if(isPlaying || isPause)
			{
				for (var i:int = 0; i < length; i++) 
				{
					animations[i].stop();
				}
			}
			
			super.stop();
		}
		
		/** @inheritDoc */
		override public function end():void
		{
			if(isPlaying || isPause)
			{
				_repeatCountInternal = 1;
				
				for (var i:int = 0; i < length; i++) 
				{
					animations[i].end();
				}
			}
			
			super.end();
		}
		
		/** @private */
		override protected function playInternal():void
		{
			var group:GroupCompleter = new GroupCompleter();
			
			for (var i:int = 0; i < length; i++) 
			{
				animation = animations[i];
				
				if(!animation.target)
					animation.target = target;
				if(easer)
					animation.easer = easer;
				if(animation.isDefaultJuggler)
					animation.juggler = juggler;
				if (isNaN(animation.duration))
					animation.duration = duration;
				
				group.append(animation.play());
			}
			
			group.future.then(onComplete).progress(onUpdate);
		}
		
		/** @private */
		private function onUpdate(value:Number):void
		{
			progress.current = value;
			completer.sendProgress(progress);
		}
		
		/** @private */
		private function onComplete():void
		{
			if (_repeatCountInternal == 0 || _repeatCountInternal > 1)
			{
				Future.delay(repeatDelay).then(playNext);
				
				if (_repeatCountInternal > 1)
					_repeatCountInternal--;
			}
			else
			{
				finish();
				completer.complete();
			}
		}
	}
}