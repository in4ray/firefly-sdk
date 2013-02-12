// =================================================================================================
//
//	in4ray Gaming SDK
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.in4ray.gaming.components.supportClasses
{
	import com.in4ray.gaming.components.ToggleButton;
	import com.in4ray.gaming.events.RadioButtonGroupEvent;
	
	import starling.display.DisplayObject;
	import starling.events.EventDispatcher;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	/**
	 * Radio buttons manager.
	 */	
	public class RadioButtonGroup extends EventDispatcher
	{
		/**
		 * Constructorr. 
		 */		
		public function RadioButtonGroup()
		{
		}
		
		private var buttons:Vector.<ToggleButton> = new Vector.<ToggleButton>();
		
		/**
		 * Manage button.
		 *  
		 * @param toggleButton ToggleButton object.
		 */		
		public function addButton(toggleButton:ToggleButton):void
		{
			if(buttons.indexOf(toggleButton) == -1)
			{
				buttons.push(toggleButton);
				toggleButton.addEventListener(TouchEvent.TOUCH, touchHandler);
			}
		}
		
		/**
		 * Remove button from manager.
		 *  
		 * @param toggleButton ToggleButton object.
		 */	
		public function removeButton(toggleButton:ToggleButton):void
		{
			var index:int = buttons.indexOf(toggleButton);
			if(index != -1)
			{
				buttons.splice(index, 1);
				toggleButton.removeEventListener(TouchEvent.TOUCH, touchHandler);
			}
		}
		
		private var _selectedIndex:int;
		
		/**
		 * Index of selected button. 
		 */		
		public function get selectedIndex():int
		{
			return _selectedIndex;
		}
		
		public function set selectedIndex(value:int):void
		{
			_selectedIndex = value;
			
			for (var i:int = 0; i < buttons.length; i++) 
			{
				if(i != _selectedIndex)
					buttons[i].selected = false;
			}
			
			buttons[selectedIndex].selected = true;
		}
		
		private var _selectedButton:ToggleButton;
		
		/**
		 * Selected button object. 
		 */		
		public function get selectedButton():ToggleButton
		{
			return _selectedButton;
		}
		
		
		private function touchHandler(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(event.currentTarget as DisplayObject);
			if(touch && touch.phase == TouchPhase.BEGAN)
			{
				for each (var button:ToggleButton in buttons) 
				{
					if(button != event.currentTarget)
					{
						button.selected = false;
					}
				}
				
				var notify:Boolean = (selectedButton != event.currentTarget);
				
				_selectedIndex =  buttons.indexOf(event.currentTarget as ToggleButton);
				_selectedButton = event.currentTarget as ToggleButton;
				_selectedButton.selected = true;
				
				if(notify)
					dispatchEvent(new RadioButtonGroupEvent(RadioButtonGroupEvent.CHANGE, selectedIndex));
			}
		}
	}
}