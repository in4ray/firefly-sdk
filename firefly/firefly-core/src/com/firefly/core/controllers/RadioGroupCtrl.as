package com.firefly.core.controllers
{
	import com.firefly.core.components.ToggleButton;
	import com.firefly.core.events.RadioButtonGroupEvent;
	
	import starling.display.DisplayObject;
	import starling.events.EventDispatcher;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	/** Radio buttons manager. */
	public class RadioGroupCtrl extends EventDispatcher
	{
		private var _buttons:Vector.<ToggleButton> = new Vector.<ToggleButton>();
		private var _selectedIndex:int;
		private var _selectedButton:ToggleButton;
		
		
		/** Constructorr.*/		
		public function RadioGroupCtrl(){}
		
		
		/** Manage button.
		 *  
		 * @param toggleButton ToggleButton object. */		
		public function addButton(toggleButton:ToggleButton):void
		{
			if(_buttons.indexOf(toggleButton) == -1)
			{
				_buttons.push(toggleButton);
				toggleButton.addEventListener(TouchEvent.TOUCH, touchHandler);
			}
		}
		
		/** Remove button from manager.
		 *  
		 * @param toggleButton ToggleButton object. */	
		public function removeButton(toggleButton:ToggleButton):void
		{
			var index:int = _buttons.indexOf(toggleButton);
			if(index != -1)
			{
				_buttons.splice(index, 1);
				toggleButton.removeEventListener(TouchEvent.TOUCH, touchHandler);
			}
		}
		
		/** Index of selected button. */		
		public function get selectedIndex():int { return _selectedIndex; }
		public function set selectedIndex(value:int):void
		{
			_selectedIndex = value;
			
			for (var i:int = 0; i < _buttons.length; i++) 
			{
				if(i != _selectedIndex)
					_buttons[i].selected = false;
			}
			
			_buttons[selectedIndex].selected = true;
		}
		
		/** Selected button object. */		
		public function get selectedButton():ToggleButton { return _selectedButton; }
		private function touchHandler(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(event.currentTarget as DisplayObject);
			if(touch && touch.phase == TouchPhase.BEGAN)
			{
				for each (var button:ToggleButton in _buttons) 
				{
					if(button != event.currentTarget)
					{
						button.selected = false;
					}
				}
				
				var notify:Boolean = (selectedButton != event.currentTarget);
				
				_selectedIndex =  _buttons.indexOf(event.currentTarget as ToggleButton);
				
				if(notify)
					dispatchEvent(new RadioButtonGroupEvent(RadioButtonGroupEvent.CHANGE, selectedIndex));
			}
		}
	}
}