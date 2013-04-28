// =================================================================================================
//
//	in4ray Gaming SDK
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.in4ray.gaming.locale
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	/**
	 * Bundle with localized strings. 
	 */
	public class LocaleBundle
	{
		private static const pattern:RegExp = /\${([^}]*)}/g;
		
		/**
		 * Constructor.
		 *  
		 * @param locale Locale code.
		 * @param path Path for resource file.
		 * 
		 */		
		public function LocaleBundle(locale:String, path:String)
		{
			this.path = path;
			_locale = locale;
		}
		
		private var strings:Dictionary;
		
		private var _locale:String;
		
		/**
		 * Locale code.
		 */		
		public function get locale():String
		{
			return _locale;
		}
		
		/**
		 * Localize String. 
		 * @param text String to localize
		 * @return Localized String
		 */		
		public function localize(text:String):String
		{
			if(strings)
			{
				var res:Array;
				do
				{
					res = pattern.exec(text);
					if(res && res.length >= 2)
					{
						var replace:String = strings[res[1]];
						if(replace)
							text = text.substring(0, pattern.lastIndex - res[0].length) + replace + text.substring(pattern.lastIndex, text.length); 
					}
				}
				while(res)
			}	
			return text;
		}
		
		
		private var path:String;
		
		private var callBack:Function;
		
		/**
		 * Load bundle.
		 */		
		public function load(callBack:Function):void
		{
			this.callBack = callBack;
			strings = new Dictionary();
			
			var loader:URLLoader = new URLLoader();
			var request:URLRequest = new URLRequest(path);
			loader.load(request);
			loader.addEventListener(Event.COMPLETE, loadHandler);
		}
		
		protected function loadHandler(event:Event):void
		{
			var xml:XML = new XML(event.currentTarget.data);
			for each (var stringXML:XML in xml.str) 
			{
				strings[stringXML.@key.toString()] = stringXML.@value.toString();
			}
			
			if(callBack)
				callBack(this);
		}
		
		/**
		 * Unload bundle. 
		 */		
		public function unload():void
		{
			strings = null;
		}
	}
}