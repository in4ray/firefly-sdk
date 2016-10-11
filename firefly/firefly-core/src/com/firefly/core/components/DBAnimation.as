// =================================================================================================
//
//	Firefly Framework
//	Copyright 2016 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.components
{
	import com.firefly.core.async.Completer;
	import com.firefly.core.async.Future;
	
	import dragonBones.Armature;
	import dragonBones.events.AnimationEvent;
	
	import starling.animation.IAnimatable;
	import starling.animation.Juggler;
	import starling.core.Starling;
	import starling.display.Sprite;

	/** Dragon Bones aniamtion wrapper which adds simple interfaces, possibility to add Starling 
	 *  juggler and use <code>Future</code> class to wait completion of playing animation. */	
	public class DBAnimation extends Component implements IAnimatable
	{
		/** @private */		
		private var _armature:Armature;
		/** @private */
		private var _juggler:Juggler;
		/** @private */
		private var _completer:Completer;
		
		/** Constructor.
		 *  @param armature Armature class to wrap it. */		
		public function DBAnimation(armature:Armature)
		{
			_armature = armature;
			
			layout.addElement(_armature.display as Sprite);
		}
		
		/** Dragon bones armatire instance. */		
		public function get armature():Armature { return _armature; }
		public function set armature(value:Armature):void { _armature = value; }
		
		/** Juggler class to use it for animation. Default is Starling juggler. */		
		public function get juggler():Juggler { return _juggler; }
		public function set juggler(value:Juggler):void { _juggler = value; }
		
		/** Is the animation currently playing. */		
		public function get isPlaying():Boolean { return _armature.animation.isPlaying; }

		/** Play animation by name.
		 *  @param animationName Animation name.
		 *  @param duration Duration in seconds.
		 *  @param playTimes Count of times animation will be played.
		 *  @return Future object for callback. */		
		public function play(animationName:String, duration:Number=-1, playTimes:Number=NaN):Future
		{
			_armature.addEventListener(AnimationEvent.COMPLETE, onAnimComplete);
			_armature.animation.gotoAndPlay(animationName, -1, duration, playTimes);
			
			if (_juggler)
				_juggler.add(this);
			else
				Starling.juggler.add(this);
			
			_completer = new Completer();
			return _completer.future;
		}
		
		/** Go to animation frame and stop the animation, just show an image.
		 *  @param animationName Animation name.
		 *  @param time Time to stop in seconds. */		
		public function gotoAndStop(animationName:String, time:Number):void
		{
			_armature.addEventListener(AnimationEvent.COMPLETE, onAnimComplete);
			_armature.animation.gotoAndStop(animationName, time);
		}
		
		/** Stop playing animation. */		
		public function stop():void
		{
			_armature.animation.stop();
		}
		
		/** @inheritDoc */		
		public function advanceTime(time:Number):void
		{
			_armature.advanceTime(time);
		}
		
		/** @private */		
		protected function onAnimComplete(event:AnimationEvent):void
		{
			if (_juggler)
				_juggler.remove(this);
			else
				Starling.juggler.remove(this);
			
			_armature.removeEventListener(AnimationEvent.COMPLETE, onAnimComplete);
			_completer.complete();
		}
	}
}