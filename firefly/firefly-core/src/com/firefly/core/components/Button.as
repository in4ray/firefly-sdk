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
	import com.firefly.core.display.ILocalizedComponent;
	
	import starling.display.Button;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	
	use namespace firefly_internal;
	
	/** Starling button component with capability of localization and default click sound. */
	public class Button extends starling.display.Button implements ILocalizedComponent
	{
		/** @private */
		private var _localizationField:LocalizationField;
		/** @private */
		private var _clickSound:IAudio;
		
		/** Constructor. 
		 *  @param upState Texture for up state.
		 *  @param localeField Locale field with localized text.
		 *  @param downState Texture for down state.
		 *  @param clickSound Click sound effect. */		
		public function Button(upState:Texture, localizationField:LocalizationField=null, downState:Texture=null, clickSound:IAudio=null)
		{
			super(upState, "", downState);
			
			_localizationField = localizationField;
			_clickSound = clickSound;
			
			addEventListener(TouchEvent.TOUCH, onTouch);
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
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
			_localizationField.unlink(this);
			_localizationField = null;
			_clickSound = null
			
			removeEventListener(TouchEvent.TOUCH, onTouch);
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			
			super.dispose();
		}
		
		/** @private */
		private function onTouch(e:TouchEvent):void
		{
			if(_clickSound && e.getTouch(this, TouchPhase.BEGAN))
				_clickSound.play();
		}
		
		/** @private */
		private function onAddedToStage(e:Event):void
		{
			_localizationField.link(this);
		}
		
		/** @private */
		private function onRemovedFromStage(e:Event):void
		{
			_localizationField.unlink(this);
		}
	}
}