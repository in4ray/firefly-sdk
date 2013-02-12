// =================================================================================================
//
//	in4ray Gaming SDK
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.in4ray.gaming.binding
{
	import com.in4ray.gaming.events.BindingEvent;
	
	/**
	 * Wrapper for bindable properties used to create binding chain. 
	 */	
	public class BindingWrapper extends Bindable
	{
		/**
		 * Constructor.
		 *  
		 * @param property Name of property to be wrapped.
		 */		
		public function BindingWrapper(property:String="")
		{
			super();
			this.property = property;
		}
		
		/**
		 * Name of property. 
		 */		
		public var property:String;
		
		/**
		 * @inheritDoc 
		 */		
		override public function notify():void
		{
			dispatcher.dispatchEvent(new BindingEvent((getValue() as Bindable).getValue()));
		}
		
		/**
		 * @inheritDoc 
		 */
		override public function setValue(value:Object):void
		{
			super.setValue(value);
			
			(value as Bindable).bindListener(targetValueChanged);
		}
		
		/**
		 * @inheritDoc 
		 */
		protected function targetValueChanged(event:BindingEvent):void
		{
			updateWrappers();
			notify();
		}
	}
}