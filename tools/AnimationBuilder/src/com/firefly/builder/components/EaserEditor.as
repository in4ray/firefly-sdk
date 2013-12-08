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
	import com.firefly.core.effects.easing.EaseBase;
	import com.firefly.core.effects.easing.IEaser;
	import com.firefly.core.effects.easing.Linear;
	import com.firefly.core.effects.easing.Power;
	
	import flash.events.Event;
	
	import spark.components.HSlider;
	import spark.components.NumericStepper;
	import spark.components.supportClasses.SkinnableComponent;
	
	[Event(name="easerChange", type="com.firefly.builder.events.EaseDataEvent")]
	
	[SkinState("normal")]
	[SkinState("power")]
	[SkinState("linear")]
	
	public class EaserEditor extends SkinnableComponent
	{
		private const NORMAL:String = "normal";
		private const POWER:String = "power";
		private const LINEAR:String = "linear";
		
		private var _viewState:String = NORMAL;
		private var _easerChanged:Boolean;
		private var _easer:IEaser;
		
		[SkinPart(required="true")]
		public var fractionStepper:NumericStepper;
		
		[SkinPart(required="true")]
		public var fractionSlider:HSlider;
		
		[SkinPart(required="true")]
		public var easeInFractionStepper:NumericStepper;
		
		[SkinPart(required="true")]
		public var easeInFractionSlider:HSlider;
		
		[SkinPart(required="true")]
		public var easeOutFractionStepper:NumericStepper;
		
		[SkinPart(required="true")]
		public var easeOutFractionSlider:HSlider;
		
		[SkinPart(required="true")]
		public var exponentStepper:NumericStepper;
		
		[SkinPart(required="true")]
		public var exponentSlider:HSlider;
		
		public function EaserEditor()
		{
			super();
		}
		
		public function get easer():IEaser { return _easer; }
		public function set easer(value:IEaser):void
		{
			_easer = value;
			
			_easerChanged = true;
			updateViewState();
		}
		
		override protected function partAdded(partName:String, instance:Object):void
		{
			super.partAdded(partName, instance);
			
			if (instance == fractionStepper)
			{
				fractionStepper.value = 0.5;
				fractionStepper.valueFormatFunction = numericFormatFunc;
				fractionStepper.valueParseFunction = numericParseFunc;
				fractionStepper.addEventListener(Event.CHANGE, onFractionStepperChange, false, 0, true);
			}
			else if (instance == fractionSlider)
			{
				fractionSlider.value = 0.5;
				fractionSlider.addEventListener(Event.CHANGE, onFractionSliderChange, false, 0, true);
			}
			else if (instance == easeInFractionStepper)
			{
				easeInFractionStepper.value = 0;
				easeInFractionStepper.valueFormatFunction = numericFormatFunc;
				easeInFractionStepper.valueParseFunction = numericParseFunc;
				easeInFractionStepper.addEventListener(Event.CHANGE, onInFractionStepperChange, false, 0, true);
			}
			else if (instance == easeInFractionSlider)
			{
				easeInFractionSlider.value = 0;
				easeInFractionSlider.addEventListener(Event.CHANGE, onInFractionSliderChange, false, 0, true);
			}
			else if (instance == easeOutFractionStepper)
			{
				easeOutFractionStepper.value = 0;
				easeOutFractionStepper.valueFormatFunction = numericFormatFunc;
				easeOutFractionStepper.valueParseFunction = numericParseFunc;
				easeOutFractionStepper.addEventListener(Event.CHANGE, onOutFractionStepperChange, false, 0, true);
			}
			else if (instance == easeOutFractionSlider)
			{
				easeOutFractionSlider.value = 0;
				easeOutFractionSlider.addEventListener(Event.CHANGE, onOutFractionSliderChange, false, 0, true);
			}
			else if (instance == exponentStepper)
			{
				exponentStepper.value = 2;
				exponentStepper.addEventListener(Event.CHANGE, onExponentStepperChange, false, 0, true);
			}
			else if (instance == exponentSlider)
			{
				exponentSlider.value = 2;
				exponentSlider.addEventListener(Event.CHANGE, onExponentSliderChange, false, 0, true);
			}
		}
		
		override protected function partRemoved(partName:String, instance:Object):void
		{
			super.partRemoved(partName, instance);
			
			if (instance == fractionStepper)
			{
				fractionStepper.removeEventListener(Event.CHANGE, onFractionStepperChange);
			}
			else if (instance == fractionSlider)
			{
				removeEventListener(Event.CHANGE, onFractionSliderChange);
			}
			else if (instance == easeInFractionStepper)
			{
				easeInFractionStepper.removeEventListener(Event.CHANGE, onInFractionStepperChange);
			}
			else if (instance == easeInFractionSlider)
			{
				easeInFractionSlider.removeEventListener(Event.CHANGE, onInFractionSliderChange);
			}
			else if (instance == easeOutFractionStepper)
			{
				easeOutFractionStepper.removeEventListener(Event.CHANGE, onOutFractionStepperChange);
			}
			else if (instance == easeOutFractionSlider)
			{
				easeOutFractionSlider.removeEventListener(Event.CHANGE, onOutFractionSliderChange);
			}
			else if (instance == exponentStepper)
			{
				exponentStepper.removeEventListener(Event.CHANGE, onExponentStepperChange);
			}
			else if (instance == easeOutFractionSlider)
			{
				exponentStepper.removeEventListener(Event.CHANGE, onExponentSliderChange);
			}
		}
		
		override protected function getCurrentSkinState():String
		{
			return _viewState;
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			if (_easerChanged)
			{
				if (_easer is EaseBase && easeInFractionStepper && easeInFractionSlider)
				{
					easeInFractionStepper.value = (_easer as EaseBase).fraction;
					easeInFractionSlider.value = (_easer as EaseBase).fraction;
					
					if (_easer is Power && exponentStepper && exponentSlider)	
					{
						exponentStepper.value = (_easer as Power).exponent;
						exponentSlider.value = (_easer as Power).exponent;
					}
				}
				else if (_easer is Linear && easeInFractionStepper && easeOutFractionStepper && easeInFractionSlider && easeOutFractionSlider)
				{
					easeInFractionStepper.value = (_easer as Linear).easeInFraction;
					easeInFractionSlider.value = (_easer as Linear).easeInFraction;
					easeOutFractionStepper.value = (_easer as Linear).easeOutFraction;
					easeOutFractionSlider.value = (_easer as Linear).easeOutFraction;
				}
				
				_easerChanged = false;
			}
		}
		
		protected function numericFormatFunc(val:Number):String 
		{ 
			return val.toString().replace(".", ","); 
		} 
		
		protected function numericParseFunc(val:String):Number 
		{ 
			var str:String = val.replace(",", "."); 
			return Number(str);     
		}
		
		private function updateViewState():void
		{
			if (_easer is Power)	
				_viewState = POWER;
			else if (_easer is Linear)
				_viewState = LINEAR;
			else 
				_viewState = NORMAL;
			
			invalidateSkinState();
		}
		
		protected function onFractionStepperChange(event:Event):void
		{
			(_easer as EaseBase).fraction = fractionSlider.value = fractionStepper.value;
			dispatchEvent(new EaseDataEvent(EaseDataEvent.EASER_CHANGE, _easer));
		}
		
		protected function onFractionSliderChange(event:Event):void
		{
			(_easer as EaseBase).fraction = fractionStepper.value = fractionSlider.value;
			dispatchEvent(new EaseDataEvent(EaseDataEvent.EASER_CHANGE, _easer));
		}
		
		protected function onInFractionStepperChange(event:Event):void
		{
			(_easer as Linear).easeInFraction = easeInFractionSlider.value = easeInFractionStepper.value;
			dispatchEvent(new EaseDataEvent(EaseDataEvent.EASER_CHANGE, _easer));
		}
		
		protected function onInFractionSliderChange(event:Event):void
		{
			(_easer as Linear).easeInFraction = easeInFractionStepper.value = easeInFractionSlider.value;
			dispatchEvent(new EaseDataEvent(EaseDataEvent.EASER_CHANGE, _easer));
		}
		
		protected function onOutFractionStepperChange(event:Event):void
		{
			(_easer as Linear).easeOutFraction = easeOutFractionSlider.value = easeOutFractionStepper.value;
			dispatchEvent(new EaseDataEvent(EaseDataEvent.EASER_CHANGE, _easer));
		}
		
		protected function onOutFractionSliderChange(event:Event):void
		{
			(_easer as Linear).easeOutFraction = easeOutFractionStepper.value = easeOutFractionSlider.value;
			dispatchEvent(new EaseDataEvent(EaseDataEvent.EASER_CHANGE, _easer));
		}
		
		protected function onExponentStepperChange(event:Event):void
		{
			(_easer as Power).exponent = exponentSlider.value = exponentStepper.value;
			dispatchEvent(new EaseDataEvent(EaseDataEvent.EASER_CHANGE, _easer));
		}
		
		protected function onExponentSliderChange(event:Event):void
		{
			(_easer as Power).exponent = exponentStepper.value = exponentSlider.value;
			dispatchEvent(new EaseDataEvent(EaseDataEvent.EASER_CHANGE, _easer));
		}
	}
}