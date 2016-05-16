// =================================================================================================
//
//	Firefly Framework
//	Copyright 2016 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.controllers
{
	import com.firefly.core.components.ToggleButton;
	import com.firefly.core.events.RadioButtonGroupEvent;
	
	import starling.display.DisplayObject;
	import starling.events.EventDispatcher;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	/** Controller for managing radio buttons group.
	 * 
	 *  @see com.firefly.core.components.ToggleButton */
	public class RadioGroupCtrl extends EventDispatcher
	{
		/** @private */
		private var _buttons:Vector.<ToggleButton> = new Vector.<ToggleButton>();
		/** @private */
		private var _selectedIndex:int;
		/** @private */
		private var _selectedButton:ToggleButton;
		
		/** Constructor. */		
		public function RadioGroupCtrl() { }
		
		/** Add button to the controller.
		 *  @param toggleButton Toggle button component. */		
		public function addButton(toggleButton:ToggleButton):void
		{
			if(_buttons.indexOf(toggleButton) == -1)
			{
				_buttons.push(toggleButton);
				toggleButton.addEventListener(TouchEvent.TOUCH, touchHandler);
			}
		}
		
		/** Remove button from the controller.
		 *  @param toggleButton ToggleButton object. */	
		public function removeButton(toggleButton:ToggleButton):void
		{
			var index:int = _buttons.indexOf(toggleButton);
			if(index != -1)
			{
				_buttons.splice(index, 1);
				toggleButton.removeEventListener(TouchEvent.TOUCH, touchHandler);
			}
		}
		
		/** Index of the selected button. */		
		public function get selectedIndex():int { return _selectedIndex; }
		public function set selectedIndex(value:int):void
		{
			_selectedIndex = value;
			
			for (var i:int = 0; i < _buttons.length; i++) 
			{
				_buttons[i].selected = (i == _selectedIndex);
			}
		}
		
		/** Selected button component. */		
		public function get selectedButton():ToggleButton { return _selectedButton; }
		
		/** @private */		
		private function touchHandler(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(event.currentTarget as DisplayObject);
			if(touch && touch.phase == TouchPhase.ENDED)
			{
				var notify:Boolean = (selectedButton != event.currentTarget);
				
				selectedIndex =  _buttons.indexOf(event.currentTarget as ToggleButton);
				
				if(notify)
					dispatchEvent(new RadioButtonGroupEvent(RadioButtonGroupEvent.CHANGE, selectedIndex));
				
				event.stopImmediatePropagation();
			}
			
		}
	}
}