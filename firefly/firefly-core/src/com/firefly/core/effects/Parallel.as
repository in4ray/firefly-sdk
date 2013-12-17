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
	import com.firefly.core.effects.easing.IEaser;
	
	import starling.animation.Juggler;
	
	public class Parallel implements IAnimation
	{
		public function Parallel()
		{
		}
		
		public function get target():Object
		{
			return null;
		}
		
		public function set target(value:Object):void
		{
		}
		
		public function get duration():Number
		{
			return 0;
		}
		
		public function set duration(value:Number):void
		{
		}
		
		public function get delay():Number
		{
			return 0;
		}
		
		public function set delay(value:Number):void
		{
		}
		
		public function get loop():Boolean
		{
			return false;
		}
		
		public function set loop(value:Boolean):void
		{
		}
		
		public function get repeatCount():int
		{
			return 0;
		}
		
		public function set repeatCount(value:int):void
		{
		}
		
		public function get repeatDelay():Number
		{
			return 0;
		}
		
		public function set repeatDelay(value:Number):void
		{
		}
		
		public function get disposeOnComplete():Boolean
		{
			return false;
		}
		
		public function set disposeOnComplete(value:Boolean):void
		{
		}
		
		public function get juggler():Juggler
		{
			return null;
		}
		
		public function set juggler(value:Juggler):void
		{
		}
		
		public function get easer():IEaser
		{
			return null;
		}
		
		public function set easer(value:IEaser):void
		{
		}
		
		public function get isPlaying():Boolean
		{
			return false;
		}
		
		public function get isPause():Boolean
		{
			return false;
		}
		
		public function get isDefaultJuggler():Boolean
		{
			return false;
		}
		
		public function play():Future
		{
			return null;
		}
		
		public function pause():void
		{
		}
		
		public function resume():void
		{
		}
		
		public function stop():void
		{
		}
		
		public function end():void
		{
		}
		
		public function dispose():void
		{
		}
	}
}