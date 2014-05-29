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
	import com.firefly.core.controllers.helpers.LocaleField;
	import com.firefly.core.display.ILocalizedComponent;
	
	import starling.text.TextField;
	
	use namespace firefly_internal;
	
	/** Starling text field component with capability of localization. */
	public class TextField extends starling.text.TextField implements ILocalizedComponent
	{
		/** @private */
		private var _localeField:LocaleField;
		
		/** Constructor. 
		 *  @param localeField Locale field with localized text.
		 *  @param fontName Font name.
		 *  @param fontSize Font size.
		 *  @param color Color of the text.
		 *  @param bold Font weight. */		
		public function TextField(localeField:LocaleField, fontName:String="Verdana", fontSize:Number=12, color:uint=0, bold:Boolean=false)
		{
			super(1, 1, "", fontName, fontSize, color, bold);
			
			_localeField = localeField;
			_localeField.component = this;
		}
		
		/** Locale field with localized text. */	
		public function get localeField():LocaleField { return _localeField; }
		
		/** Invokes to localize text in the component.
		 *  @param text Localized string. */
		public function localize(text:String):void { this.text = text; }
	}
}