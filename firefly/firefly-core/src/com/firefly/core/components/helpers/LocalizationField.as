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
	
	import mx.utils.StringUtil;

	/** Helper view object class for storing localized string and key. */	
	public class LocalizationField
	{
		/** @private */
		private var _key:String;
		/** @private */
		private var _str:String;
		
		/** @private */
		private var _args:Array;
		/** @private */
		private var _components:Vector.<ILocalizedComponent>;
		
		/** Constructor.
		 *  @param key Key of the localization string.
		 *  @param str Localized string. 
		 *  @param args Arguments for string interpolation.*/		
		public function LocalizationField(key:String, str:String, args:Array=null)
		{
			_key = key;
			_str = str;
			_args = args;
			_components = new Vector.<ILocalizedComponent>();
		}
		
		/** Key of the localization string. */		
		public function get key():String { return _key; }
		/** @private */
		public function set key(value:String):void { _key = value; }
		
		/** Localized string. */
		public function get str():String { return _str; }
		/** @private */
		public function set str(value:String):void
		{
			_str = value;
			updateComponents();
		}
		
		/** Arguments for string interpolation. */		
		public function get args():Array { return _args; }
		/** @private */
		public function set args(value:Array):void 
		{
			_args = value;
			updateComponents();
		}
		
		/** @private */
		private function updateComponents():void
		{
			_components.forEach(function (comp:ILocalizedComponent, i:int, arr:Vector.<ILocalizedComponent>):void
			{
				comp.localize(getLocalizetString());
			});
		}
		
		/** @private */
		private function getLocalizetString():String
		{
			if(_args && _args.length > 0)
				return StringUtil.substitute.apply(null, [_str].concat(_args));
			else
				return _str;
		}
		
		/** @private
		 *  Link component with localization field.
		 *  @param comp Localization component. */
		firefly_internal function link(comp:ILocalizedComponent):void
		{
			if (_components.indexOf(comp) == -1)
			{
				_components.push(comp);
				comp.localize(getLocalizetString());
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