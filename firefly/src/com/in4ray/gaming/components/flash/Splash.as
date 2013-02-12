// =================================================================================================
//
//	in4ray Gaming SDK
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.in4ray.gaming.components.flash
{
	/**
	 * Base class for splash screens.
	 *  
	 */	
	public class Splash extends Sprite
	{
		/**
		 * Constructor.
		 *  
		 * @param readyToRemove Flag that indicates whether splash should be removed 
		 * after it's been showing time specified in duration property.
		 */		
		public function Splash(readyToRemove:Boolean = true)
		{
			super();
			
			this.readyToRemove = readyToRemove;
		}
		
		/**
		 * Time to show splash in milliseconds. 
		 */		
		public var duration:Number = 1000;

		private var _readyToRemove:Boolean;

		/**
		 * Flag that indicates whether splash should be removed 
		 * after it's been showing time specified in duration property.
		 */		
		public function get readyToRemove():Boolean
		{
			return _readyToRemove;
		}

		public function set readyToRemove(value:Boolean):void
		{
			_readyToRemove = value;
		}

	}
}