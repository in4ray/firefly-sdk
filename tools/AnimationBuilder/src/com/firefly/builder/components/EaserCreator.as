// =================================================================================================
//
//	Firefly Framework
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.builder.components
{
	import com.firefly.builder.events.EaseDataEvent;
	import com.firefly.core.effects.easing.Back;
	import com.firefly.core.effects.easing.Bounce;
	import com.firefly.core.effects.easing.Circular;
	import com.firefly.core.effects.easing.Elastic;
	import com.firefly.core.effects.easing.IEaser;
	import com.firefly.core.effects.easing.Linear;
	import com.firefly.core.effects.easing.Power;
	import com.firefly.core.effects.easing.Sine;
	
	import flash.events.Event;
	
	import mx.collections.ArrayList;
	
	import spark.components.ComboBox;
	import spark.components.supportClasses.SkinnableComponent;
	import spark.events.IndexChangeEvent;
	
	public class EaserCreator extends SkinnableComponent
	{
		private var _easeTypes:ArrayList; 
		private var _easer:IEaser = new Linear();

		[SkinPart(required="true")]
		public var easeTypeComboBox:ComboBox;
		
		[SkinPart(required="true")]
		public var easerEditor:EaserEditor;
		
		[SkinPart(required="true")]
		public var easerView:EaserView;
		
		public function EaserCreator()
		{
			super();
			
			easeTypes = new ArrayList(["Linear", "Sine", "Power", "Circular", "Bounce", "Back", "Elastic"]);
		}
		
		[Bindable]
		public function get easeTypes():ArrayList { return _easeTypes; }
		public function set easeTypes(value:ArrayList):void
		{
			if (_easeTypes != value)
			{
				_easeTypes = value;
				if (easeTypeComboBox)
					easeTypeComboBox.dataProvider = easeTypes;
			}
		}

		override protected function partAdded(partName:String, instance:Object):void
		{
			super.partAdded(partName, instance);
			
			if (instance == easeTypeComboBox)
			{
				easeTypeComboBox.dataProvider = easeTypes;
				easeTypeComboBox.selectedItem = "Linear";
				easeTypeComboBox.addEventListener(Event.CHANGE, onEaseTypeChange, false, 0, true);
			}
			else if (instance == easerEditor)
			{
				easerEditor.easer = _easer;
				easerEditor.addEventListener(EaseDataEvent.EASER_CHANGE, onEaserDataChange, false, 0, true);
			}
			else if (instance == easerView)
			{
				easerView.easer = _easer;
			}
		}
		
		override protected function partRemoved(partName:String, instance:Object):void
		{
			super.partRemoved(partName, instance);
			
			if (instance == easeTypeComboBox)
			{
				easeTypeComboBox.removeEventListener(Event.CHANGE, onEaseTypeChange);
			}
			else if (instance == easerEditor)
			{
				easerEditor.removeEventListener(EaseDataEvent.EASER_CHANGE, onEaserDataChange);
			}
		}
		
		protected function onEaseTypeChange(event:IndexChangeEvent):void
		{
			var type:String = easeTypeComboBox.selectedItem as String;
			if (type == "Sine")
				_easer = new Sine();
			else if (type == "Power")
				_easer = new Power();
			else if (type == "Circular")
				_easer = new Circular();
			else if (type == "Bounce")
				_easer = new Bounce();
			else if (type == "Bounce")
				_easer = new Bounce();
			else if (type == "Back")
				_easer = new Back();
			else if (type == "Elastic")
				_easer = new Elastic();
			else
				_easer = new Linear();
			
			easerView.easer = easerEditor.easer = _easer;
		}
		
		protected function onEaserDataChange(event:EaseDataEvent):void
		{
			_easer = easerView.easer = event.easer; 
		}
	}
}