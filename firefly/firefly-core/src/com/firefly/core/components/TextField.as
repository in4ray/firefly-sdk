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
	import com.firefly.core.Firefly;
	import com.firefly.core.firefly_internal;
	import com.firefly.core.components.helpers.LocalizationField;
	import com.firefly.core.display.ILocalizedComponent;
	
	import starling.events.Event;
	import starling.text.TextField;
	
	use namespace firefly_internal;
	
	/** Starling text field component with capability of localization. */
	public class TextField extends starling.text.TextField implements ILocalizedComponent
	{
		/** @private */
		private var _localizationField:LocalizationField;
		
		/** Constructor. 
		 *  @param localeField Localization field with localized text.
		 *  @param fontName Font name, if not specified than default font from Firefly will be used.
		 *  @param fontSize Font size.
		 *  @param color Color of the text.
		 *  @param bold Font weight. */		
		public function TextField(localizationField:LocalizationField, fontName:String="", fontSize:Number=12, color:uint=0, bold:Boolean=false)
		{
			if(!fontName || fontName == "")
				fontName = Firefly.current.defaultFont;
			
			super(1, 1, "", fontName, fontSize, color, bold);
			
			_localizationField = localizationField;
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}
		
		/** Locale field with localized text. */	
		public function get localeField():LocalizationField { return _localizationField; }
		
		/** Invokes to localize text in the component.
		 *  @param text Localized string. */
		public function localize(text:String):void
		{ 
			this.text = text; 
		}
		
		/** @inheritDoc */		
		override public function dispose():void
		{
			if (_localizationField)
            {
                _localizationField.unlink(this);
                _localizationField = null;
            }

			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			
			super.dispose();
		}
		
		/** @private */
		private function onAddedToStage(e:Event):void
		{
			if (_localizationField)
                _localizationField.link(this);
		}
		
		/** @private */
		private function onRemovedFromStage(e:Event):void
		{
			if (_localizationField)
                _localizationField.unlink(this);
		}

		/** Create instance of <code>TextField</code> class without supporting of localization.
		 *  @param text Text field.
		 *  @param fontName Font name, if not specified than default font from Firefly will be used.
		 *  @param fontSize Font size.
		 *  @param color Color of the text.
		 *  @param bold Font weight.
		 *  @return Instance of TextField */		
        public static function simple(text:String, fontName:String="Verdana", fontSize:Number=12, color:uint=0, bold:Boolean=false):com.firefly.core.components.TextField
        {
            var tf:com.firefly.core.components.TextField = new com.firefly.core.components.TextField(null, fontName, fontSize, color, bold);
            tf.text = text;
            return tf;
        }
	}
}