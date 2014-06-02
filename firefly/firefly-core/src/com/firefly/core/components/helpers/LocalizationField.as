// =================================================================================================
//
//	Firefly Framework
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.components.helpers
{
	import com.firefly.core.firefly_internal;
	import com.firefly.core.display.ILocalizedComponent;

	/** Helper view object class for storing localized string and key. */	
	public class LocalizationField
	{
		/** @private */
		private var _key:String;
		/** @private */
		private var _str:String;
		/** @private */
		private var _components:Vector.<ILocalizedComponent>;
		
		/** Constructor.
		 *  @param key Key of the localization string.
		 *  @param str Localized string. */		
		public function LocalizationField(key:String, str:String)
		{
			_key = key;
			_str = str;
			_components = new Vector.<ILocalizedComponent>();
		}
		
		/** Key of the localization string. */		
		public function get key():String { return _key; }
		/** @private */
		public function set key(val:String):void { _key = val; }
		
		/** Localized string. */
		public function get str():String { return _str; }
		/** @private */
		public function set str(val:String):void
		{
			_str = val;
			_components.forEach(function (comp:ILocalizedComponent, i:int, arr:Vector.<ILocalizedComponent>):void
			{
				comp.localize(_str);
			});
		}
		
		/** @private
		 *  Link component with localization field.
		 *  @param comp Localization component. */
		firefly_internal function link(comp:ILocalizedComponent):void
		{
			if (_components.indexOf(comp) == -1)
			{
				_components.push(comp);
				comp.localize(_str);
			}
		}
		
		/** @private
		 *  Unlink component from localization field.
		 *  @param comp Localization component. */
		firefly_internal function unlink(comp:ILocalizedComponent):void
		{
			var index:int = _components.indexOf(comp);
			if (index != -1)
				_components.splice(index, 1);
		}
	}
}