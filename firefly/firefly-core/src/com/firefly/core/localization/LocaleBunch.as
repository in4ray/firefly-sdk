package com.firefly.core.localization
{
	import flash.utils.Dictionary;

	public class LocaleBunch
	{
		private var _locale:String;
		private var _strings:Dictionary;
		
		public function LocaleBunch(locale:String)
		{
			_locale = locale;
			_strings = new Dictionary();
		}
		
		public function get locale():String { return _locale; }
		
		public function addStr(key:String, val:String):void
		{
			_strings[key] = val;
		}
		
		public function removeStr(key:String):void
		{
			if(key in _strings)
				delete _strings[key];
		}
		
		public function unload():void
		{
			_strings = null;
		}
	}
}