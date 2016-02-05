// =================================================================================================
//
//	Firefly Framework
//	Copyright 2016 in4ray. All Rights Reserved.
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
	import com.firefly.core.display.ILocalizedComponent;
	
	import starling.display.Button;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	
	/** Starling button component with capability of localization and default click sound. */
	public class Button extends starling.display.Button implements ILocalizedComponent
	{
		/** @private */
		private var _locField:LocalizationField;
		/** @private */
		private var _clickSound:IAudio;
		
		/** Constructor. 
		 *  @param upState Texture for up state.
		 *  @param locField Localization field with localized text.
		 *  @param downState Texture for down state.
		 *  @param clickSound Click sound effect. */		
		public function Button(upState:Texture, locField:LocalizationField=null, downState:Texture=null, clickSound:IAudio=null)
		{
			super(upState, "", downState);
			
			_clickSound = clickSound;
			this.locField = locField;
			
			addEventListener(TouchEvent.TOUCH, onTouch);
		}

		/** @private */
		public function get clickSound():IAudio { return _clickSound; }
		/** Click sound effect. */
		public function set clickSound(value:IAudio):void { _clickSound = value; }
		
		/** Texture for up state. */
		public function get locField():LocalizationField { return _locField; }
		/** @private */
		public function set locField(value:LocalizationField):void 
		{
			if (_locField)
			{
				_locField.firefly_internal::unlink(this);
				removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
				removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			}
				
			_locField = value;
			
			if (_locField)
			{
				_locField.firefly_internal::link(this);
				addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
				addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			}
		}

		/** Invokes to localize text in the component.
		 *  @param text Localized string. */
		public function localize(text:String):void
		{ 
			this.text = text; 
		}
		
		/** @inheritDoc */		
		override public function dispose():void
		{
			_locField.firefly_internal::unlink(this);
			_locField = null;
			_clickSound = null
			
			removeEventListener(TouchEvent.TOUCH, onTouch);
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			
			super.dispose();
		}
		
		/** @private */
		protected function onTouch(e:TouchEvent):void
		{
			if(_clickSound && e.getTouch(this, TouchPhase.BEGAN))
				_clickSound.play();
		}
		
		/** @private */
		protected function onAddedToStage(e:Event):void
		{
			_locField.firefly_internal::link(this);
		}
		
		/** @private */
		protected function onRemovedFromStage(e:Event):void
		{
			_locField.firefly_internal::unlink(this);
		}
		
		/** Create instance of <code>Button</code> class without supporting of localization.
		 *  @param upState Texture for up state.
		 *  @param text Text field.
		 *  @param downState Texture for down state.
		 *  @param clickSound Click sound effect.
		 *  @return Instance of Button */		
		public static function simple(upState:Texture, text:String="", downState:Texture=null, clickSound:IAudio=null):com.firefly.core.components.Button
		{
			var btn:com.firefly.core.components.Button = new com.firefly.core.components.Button(upState, null, downState, clickSound);
			btn.text = text;
			return btn;
		}
	}
}