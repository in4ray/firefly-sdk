// =================================================================================================
//
//	Firefly Framework
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.components
{
	import com.firefly.core.firefly_internal;
	import com.firefly.core.audio.IAudio;
	import com.firefly.core.components.helpers.LocalizationField;
	
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	
	/** Toggle button component with capability of localization and default click sound. */
	public class ToggleButton extends Button
	{
		/** @private */
		private var _upStateNormal:Texture;
		/** @private */
		private var _upStateSelected:Texture;
		/** @private */
		private var _downStateNormal:Texture;
		/** @private */
		private var _downStateSelected:Texture;
		/** @private */
		private var _locFieldSelected:LocalizationField;
		/** @private */
		private var _selected:Boolean;
		
		/** Constructor. 
		 *  @param upStateNormal Texture for normal up state.
		 *  @param upStateSelected Texture for selected up state.
		 *  @param locField Localization field with localized text in normal state.
		 *  @param locFieldSelected Localization field with localized text in selected state.
		 *  @param downStateNormal Texture for normal down state.
		 *  @param downStateSelected Texture for selected up state.
		 *  @param clickSound Click sound effect. */		
		public function ToggleButton(upStateNormal:Texture, upStateSelected:Texture = null, locField:LocalizationField=null, locFieldSelected:LocalizationField=null,
									 downStateNormal:Texture=null, downStateSelected:Texture=null, clickSound:IAudio=null)
		{
			super(upStateNormal, locField, downStateNormal, clickSound);
			
			_upStateNormal = upStateNormal;
			_upStateSelected = upStateSelected ? upStateSelected : upStateNormal;
			_downStateNormal = downStateNormal ? downStateNormal : upStateNormal;
			_downStateSelected = downStateSelected ? downStateSelected : upStateSelected;
			_locFieldSelected = locFieldSelected;
		}
		
		/** Localization field with localized text in selected state. */
		public function get locFieldSelected():LocalizationField { return _locFieldSelected; }
		/** @private */
		public function set locFieldSelected(value:LocalizationField):void
		{
			if (_locFieldSelected)
				_locFieldSelected.firefly_internal::unlink(this);
			
			_locFieldSelected = value;
			
			if (_locFieldSelected && stage)
				_locFieldSelected.firefly_internal::link(this);
		}
		
		/** Define is selected state in the toggle button. */		
		public function get selected():Boolean { return _selected; }
		/** @private */
		public function set selected(value:Boolean):void
		{
			if(_selected != value)
			{
				_selected = value;
				updateBtn();
			}
		}

		/** Texture for normal down state. */
		public function get downStateNormal():Texture { return _downStateNormal; }
		/** @private */
		public function set downStateNormal(value:Texture):void
		{ 
			_downStateNormal = value;
			updateBtn();
		}
		
		/** Texture for selected up state. */
		public function get downStateSelected():Texture { return _downStateSelected; }
		/** @private */
		public function set downStateSelected(value:Texture):void 
		{ 
			_downStateSelected = value;
			updateBtn();
		}

		/** Texture for normal up state. */
		public function get upStateNormal():Texture { return _upStateNormal; }
		/** @private */
		public function set upStateNormal(value:Texture):void
		{
			_upStateNormal = value;
			updateBtn();
		}
		
		/** Texture for selected up state. */
		public function get upStateSelected():Texture { return _upStateSelected; }
		/** @private */
		public function set upStateSelected(value:Texture):void
		{
			_upStateSelected = value;
			updateBtn();
		}
		
		/** @inheritDoc */
		override public function localize(text:String):void
		{ 
			this.text = _selected && _locFieldSelected ? _locFieldSelected.str : locField.str;
		}
		
		/** @inheritDoc */
		override protected function onTouch(e:TouchEvent):void
		{
			super.onTouch(e);
			
			if (e.getTouch(this, TouchPhase.ENDED))
				selected = !selected;
		}
		
		/** @inheritDoc */
		override protected function onAddedToStage(e:Event):void
		{
			super.onAddedToStage(e);
			
			_locFieldSelected.firefly_internal::link(this);
		}
		
		/** @inheritDoc */
		override protected function onRemovedFromStage(e:Event):void
		{
			super.onRemovedFromStage(e);
			
			_locFieldSelected.firefly_internal::unlink(this);
		}
		
		/** @private */
		private function updateBtn():void
		{
			upState = _selected ? _upStateSelected : _upStateNormal;
			downState = _selected ? _downStateSelected : _downStateNormal;
			text = _selected && _locFieldSelected ? _locFieldSelected.str : locField.str;
		}
	}
}