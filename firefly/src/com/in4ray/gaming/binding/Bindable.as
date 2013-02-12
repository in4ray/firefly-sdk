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
	
	import starling.events.EventDispatcher;
	
	/**
	 * Base bindable property. 
	 */	
	public class Bindable implements IBinding
	{
		/**
		 * Constructor. 
		 * 
		 * @param value Initial value.
		 */		
		public function Bindable(value:Object = null)
		{
			_value = value;
			
			dispatcher = new EventDispatcher();
		}
		
		/**
		 * Event dispatcher object. 
		 */		
		protected var dispatcher:EventDispatcher;
		
		private var _value:Object;
		
		/**
		 * Get property value.
		 *  
		 * @return Value of bindable property. 
		 */		
		public function getValue():Object
		{
			return _value;
		}
		
		/**
		 * Set property value.
		 * @param value Value of bindable property. 
		 * 
		 */		
		public function setValue(value:Object):void
		{
			if(_value != value)
			{
				_value = value;
				
				updateWrappers();
				notify();
			}
		}
		
		/**
		 * Update bindable chain. 
		 */		
		protected function updateWrappers():void
		{
			for each (var item:BindingWrapper in chains) 
			{
				try
				{
					item.setValue(_value[item.property]);
				} 
				catch(error:Error) 
				{
					CONFIG::debugging {trace("[in4ray] Can't find property " + item.property + " in object [" + _value + "]")};
				}
			}
		}
		
		/**
		 * Fire binding. 
		 */		
		public function notify():void
		{
			dispatcher.dispatchEvent(new BindingEvent(_value));
		}
		
		private var chains:Vector.<BindingWrapper> = new Vector.<BindingWrapper>();
		
		/**
		 * @inheritDoc 
		 */		
		public function next(property:String):IBinding
		{
			var wrapper:BindingWrapper = new BindingWrapper(property);
			chains.push(wrapper);
			
			return wrapper;
		}
		
		/**
		 * @inheritDoc 
		 */	
		public function bindListener(listener:Function):void
		{
			dispatcher.addEventListener(BindingEvent.PROPERTY_CHANGE, listener);
			
			if(_value)
				listener(new BindingEvent(_value));
		}
		
		/**
		 * @inheritDoc 
		 */	
		public function unbindListener(listener:Function):void
		{
			dispatcher.removeEventListener(BindingEvent.PROPERTY_CHANGE, listener);
		}
		
		/**
		 * @inheritDoc 
		 */	
		public function bindProperty(host:Object, property:String):Function
		{
			dispatcher.addEventListener(BindingEvent.PROPERTY_CHANGE, listener);
			function listener(event:BindingEvent):void
			{
				applyValue(host, property, event.data);
			};
			
			if(_value)
				applyValue(host, property, _value);
			
			return listener;
		}
		
		/**
		 * Apply property value.
		 *  
		 * @param host Object that contains property
		 * @param property Name of property
		 * @param value Property value.
		 */		
		protected function applyValue(host:Object, property:String, value:Object):void
		{
			try
			{
				host[property] = value;
			} 
			catch(error:Error) 
			{
				CONFIG::debugging {trace("[in4ray] Can't find property " + property + " in object [" + host + "]")};
			}
		}
	}
}