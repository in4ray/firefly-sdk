// =================================================================================================
//
//	Firefly Framework
//	Copyright 2013 in4ray. All Rights Reserved.
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
		override public function get isPlaying():Boolean 
		{ 
			for (var i:int = 0; i < length; i++) 
			{
				if (animations[i].isPlaying)
					return true;
			}
			
			return false;
		}
		
		/** @inheritDoc */
		override public function get isPause():Boolean 
		{ 
			for (var i:int = 0; i < length; i++) 
			{
				if (animations[i].isPause)
					return true;
			}
			
			return false;
		}
		
		/** @inheritDoc */
		override public function pause():void
		{
			for (var i:int = 0; i < length; i++) 
			{
				animations[i].pause();
			}
		}
		
		/** @inheritDoc */
		override public function resume():void
		{
			for (var i:int = 0; i < length; i++) 
			{
				animations[i].resume();
			}
		}
		
		/** @inheritDoc */
		override public function stop():void
		{
			for (var i:int = 0; i < length; i++) 
			{
				animations[i].stop();
			}
		}
		
		/** @inheritDoc */
		override public function end():void
		{
			repeatCount = 1;
			
			for (var i:int = 0; i < length; i++) 
			{
				animations[i].end();
			}
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
				
				if(!animation.easer)
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
		private function onUpdate(val:Number):void
		{
			progress.current = val;
			completer.sendProgress(progress);
		}
		
		/** @private */
		private function onComplete():void
		{
			if (repeatCount == 0 || repeatCount > 1)
			{
				Future.delay(repeatDelay).then(play);
				
				if (repeatCount > 1)
					repeatCount--;
			}
			else
			{
				completer.complete();
			}
		}
	}
}