// =================================================================================================
//
//	Firefly Framework
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.controllers.helpers
{
	import com.firefly.core.firefly_internal;
	import com.firefly.core.display.ILocalizedComponent;

	/** Helper view object class for storing localized string and key. */	
	public class LocaleField
	{
		/** @private */
		private var _key:String;
		/** @private */
		private var _str:String;
		/** @private */
		private var _component:ILocalizedComponent;
		
		/** Constructor.
		 *  @param key Key of the localization string.
		 *  @param str Localized string. */		
		public function LocaleField(key:String, str:String)
		{
			_key = key;
			_str = str;
		}
		
		/** Key of the localization string. */		
		public function get key():String { return _key; }
		/** Localized string. */
		public function get str():String { return _str; }
		
		/** @private */
		firefly_internal function set str(val:String):void
		{
			_str = val;
			if (_component)
				_component.localize(_str);
		}
		
		/** @private */
		firefly_internal function set component(val:ILocalizedComponent):void
		{
			_component = val;
			_component.localize(_str);
		}
	}
}