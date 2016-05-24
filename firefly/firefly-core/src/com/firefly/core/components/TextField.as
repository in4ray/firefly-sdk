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
	import starling.text.TextFormat;
	
	use namespace firefly_internal;
	
	/** Starling text field component with capability of localization.
	 * 
	 *  @see com.firefly.core.components.helpers.LocalizationField;
	 *  @see com.firefly.core.assets.LocalizationBundle;
	 *  
	 *  @example The following code shows how to create text field with 
	 *  localization supporting:
	 *  <listing version="3.0">
	 *************************************************************************************
public class MyComponent extends Component
{
	 public function MyComponent()
	 {
		 super();
		 
		 var localization:MyLocalizationBundle = new MyLocalizationBundle();
		 var tf:TextField = new TextField(localizationBundle.getLocaleField("myKey"), "Verdana", 50, 0xffffff);
		 layout.addElement(tf, $x(10).cpx, $y(10).cpx, $width(200).cpx, $height(70).cpx);
	 }
}
	 *************************************************************************************
	 *  </listing> */
	public class TextField extends starling.text.TextField implements ILocalizedComponent
	{
		/** @private */
		private var _locField:LocalizationField;
		
		/** Constructor. 
		 *  @param localeField Localization field with localized text.
		 *  @param fontName Font name, if not specified than default font from Firefly will be used.
		 *  @param fontSize Font size.
		 *  @param color Color of the text. */		
		public function TextField(locField:LocalizationField, fontName:String="", fontSize:Number=12, color:uint=0)
		{
			if(!fontName || fontName == "")
				fontName = Firefly.current.defaultFont;
			
			super(1, 1, "", new TextFormat(fontName, fontSize, color));
			
			_locField = locField;
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}
		
		/** Locale field with localized text. */	
		public function get locField():LocalizationField { return _locField; }
		
		/** Invokes to localize text in the component.
		 *  @param text Localized string. */
		public function localize(text:String):void
		{ 
			this.text = text; 
		}
		
		/** @inheritDoc */		
		override public function dispose():void
		{
			if (_locField)
            {
                _locField.unlink(this);
                _locField = null;
            }

			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			
			super.dispose();
		}
		
		/** @private */
		private function onAddedToStage(e:Event):void
		{
			if (_locField)
                _locField.link(this);
		}
		
		/** @private */
		private function onRemovedFromStage(e:Event):void
		{
			if (_locField)
                _locField.unlink(this);
		}

		/** Create instance of <code>TextField</code> class without supporting of localization.
		 *  @param text Text which will be showed in text field.
		 *  @param fontName Font name, if not specified than default font from Firefly will be used.
		 *  @param fontSize Font size.
		 *  @param color Color of the text.
		 *  @return Instance of TextField */		
        public static function simple(text:String, fontName:String="", fontSize:Number=12, color:uint=0):com.firefly.core.components.TextField
        {
            var tf:com.firefly.core.components.TextField = new com.firefly.core.components.TextField(null, fontName, fontSize, color);
            tf.text = text;
            return tf;
        }
	}
}