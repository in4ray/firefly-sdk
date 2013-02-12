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
	/**
	 * Bindable property for Array type. 
	 */	
	public class BindableArray extends Bindable
	{
		/**
		 * Constuctor.
		 *  
		 * @param value Initial property value.
		 */		
		public function BindableArray(value:Array=null)
		{
			if(!value)
				value = new Array();
			
			super(value);
		}
		
		/**
		 * Flag that indicates whether binding should fire automatically each time number of children is changed. 
		 */		
		public var autoUpdate:Boolean = true;
		
		public function set value(value:Array):void
		{
			setValue(value);
		}
		
		/**
		 * Property array object. 
		 */		
		public function get value():Array
		{
			return source.slice();
		}
		
		private function get source():Array
		{
			return getValue() as Array;
		}
		
		/**
		 * Add item/items into array.
		 *  
		 * @param items Items to be added.
		 */		
		public function add(...items):void
		{
			for each (var item:Object in items) 
			{
				source.push(item);
			}
			
			if(autoUpdate)
				notify();
		}
		
		/**
		 * Add item/items into specified position of array.
		 *  
		 * @param items Items to be added.
		 * @param index Position
		 */		
		public function addAt(item:Object, index:uint):void
		{
			source.splice(index, 0, item);
			
			if(autoUpdate)
				notify();
		}
		
		/**
		 * Remove item/items from array
		 * @param items  Items to be removed.
		 */		
		public function remove(...items):void
		{
			for each (var item:Object in items) 
			{
				source.splice(source.indexOf(item), 1);
			}
			
			if(autoUpdate)
				notify();
		}
		
		/**
		 * Length of array. 
		 */		
		public function get length():uint
		{
			return source.length;
		}
		
		public function set length(value:uint):void
		{
			source.length = value;
			
			if(autoUpdate)
				notify();
		}
	}
}