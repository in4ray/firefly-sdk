// =================================================================================================
//
//	Firefly Framework
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.assets
{
	import com.firefly.core.firefly_internal;
	import com.firefly.core.assets.loaders.LocaleXMLLoader;
	import com.firefly.core.assets.loaders.XMLLoader;
	import com.firefly.core.async.Completer;
	import com.firefly.core.async.Future;
	import com.firefly.core.async.GroupCompleter;
	import com.firefly.core.components.helpers.LocalizationField;
	import com.firefly.core.concurrency.GreenThread;
	import com.firefly.core.utils.CommonUtils;
	import com.firefly.core.utils.Log;
	import com.firefly.core.utils.SingletonLocator;
	
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	
	import avmplus.getQualifiedClassName;
	
	use namespace firefly_internal;

	/** Localization bundle class for loading, creating and storing localization strings.
	 *  
	 *  @example The following code shows how to register localization xml for loading:
	 *  <listing version="3.0">
	 *************************************************************************************
public class GameLocalizationBundle extends LocalizationBundle
{
	 override protected function regLocales():void
	 {
	 	regLocaleXML("en", "../locale/en.xml");
		regLocaleXML("ua", "../locale/en.xml");
		regLocaleXML("da", "../locale/da.xml"); 
	 }
}
	 *************************************************************************************
	 *  </listing> 
	 *	@example The following code shows how to use localization bundle for using localized strings. Localization xml files should be loaded before.
	 *  <listing version="3.0">
	 *************************************************************************************
public class MySprite extends Sprite
{
	 public function MySprite()
	 {
		 super();
		 
		 var layout:Layout = new Layout(this);
		 var localization:GameLocalizationBundle = new GameLocalizationBundle();
		 var tf:TextField = new TextField(localizationBundle.getLocaleField("myKey"), 200, 70, "Verdana", 50, 0xffffff);
		 layout.addElement(tf, $x(10).cpx, $y(10).cpx, $width(200).cpx, $height(70).cpx);
	 }
}
	 *************************************************************************************
	 *  </listing> */
	public class LocalizationBundle implements IAssetBundle
	{
		/** @private */
		protected static const thread:GreenThread = new GreenThread();
		
		/** @private */
		firefly_internal var _loaders:Dictionary;
		/** @private */
		firefly_internal var _localeBunches:Dictionary;
		/** @private */
		firefly_internal var _localizedStrings:Dictionary;
		/** @private */
		firefly_internal var _currentLocaleBunch:Dictionary;
		
		/** @private */
		private var _name:String;
		/** @private */
		private var _loaded:Boolean;
		/** @private */
		private var _locale:String;
		
		/** @private */
		protected var _singleton:LocalizationBundle;
		
		/** Constructor. */
		public function LocalizationBundle()
		{
			this._name = getQualifiedClassName(this);
			this._singleton = SingletonLocator.getInstance(getDefinitionByName(_name) as Class, this);
			
			if(_singleton == this)
			{
				_loaders = new Dictionary();
				_localeBunches = new Dictionary();
				_localizedStrings = new Dictionary();
				regLocales();
			}
		}
		
		/** Unique name of bundle. */
		public function get name():String { return _name; }
		
		/** The current locale. Changing of this variable effects of changing all localization strings. */
		public function get locale():String { return _locale; }
		public function set locale(value:String):void 
		{
			if(_singleton != this)
			{
				_singleton.locale = value;
				return;
			}
			
			if (_locale != value)
			{
				_locale = value;
				updateStrings();
			}
		}
		
		/** Return locale field object by key.
		 *  @param key The key of locale field.
		 *  @param args Arguments for string interpolation.
		 *  @return Locale field stored in the bundle. */		
		public function getLocaleField(key:String, args:Array):LocalizationField
		{
			if(_singleton != this)
				return _singleton.getLocaleField(key, args);
			
			if(key in _localizedStrings)
			{
				_localizedStrings[key].args = args;
				return _localizedStrings[key];
			}
			else if (_currentLocaleBunch)
			{
				_localizedStrings[key] = new LocalizationField(key, _currentLocaleBunch[key], args);
				return _localizedStrings[key];
			}
			
			CONFIG::debug {
				Log.error("Locale field {0} is not found.", key);
			};
			
			return null;
		}
		
		/** Load localization data asynchronously.
		 *  @return Future object for callback. */
		public function load():Future
		{
			if(_singleton != this)
				return _singleton.load();
			
			if(!_loaded && !CommonUtils.isEmptyDict(_loaders))
			{
				var group:GroupCompleter = new GroupCompleter();
				for each (var loader:XMLLoader in _loaders) 
				{
					var completer:Completer = new Completer();
					thread.schedule(loader.load).then(onLocaleLoaded, loader, completer);
					group.append(completer.future);
				}
				
				_loaded = true;
				
				return group.future;
			}
			return Future.nextFrame();
		}
		
		/** Release localization data. */	
		public function unload():void
		{
			if(_singleton != this)
				return _singleton.unload();
			
			_loaded = false;
		}
		
		/** Register locales. This method calls after creation of the localization bundle. */
		protected function regLocales():void { }
		
		/** Register localization xml for loading.
		 *  @param locale Unique identifier of the loader and locale bunch of the strings.
		 *  @param path Path to the xml file.*/
		protected function regLocaleXML(locale:String, path:String):void
		{
			if(_singleton != this)
				return _singleton.regLocaleXML(locale, path);
			
			if(!(locale in _loaders))
				_loaders[locale] = new LocaleXMLLoader(locale, path);
		}
		
		/** @private */	
		private function onLocaleLoaded(loader:XMLLoader, completer:Completer):void
		{
			loader.build(this);
			loader.release();
			
			completer.complete();
		}
		
		/** @private */	
		private function updateStrings():void
		{
			if(_localeBunches && _locale in _localeBunches)
			{
				_currentLocaleBunch = _localeBunches[_locale];
				for (var key:String in _currentLocaleBunch) 
				{
					if (key in _localizedStrings)
						(_localizedStrings[key] as LocalizationField).str = _currentLocaleBunch[key];
					else
						_localizedStrings[key] = new LocalizationField(key, _currentLocaleBunch[key]);
				}
			}
		}
		
		/** @private
		 *  Create locale bunches and localization strings.
		 * 	@param id Unique identifier of the loader and locale bunch of the strings.
		 *  @param xml XML data for localization bunch creation. **/
		firefly_internal function createLocaleBunch(locale:String, xml:XML):void
		{
			var strings:Dictionary = new Dictionary();
			var stringList:XMLList = xml.str;
			for each (var strXML:XML in stringList) 
			{
				strings[strXML.@key.toString()] = strXML.@value.toString();
			}
			
			if (!(locale in _localeBunches))
				_localeBunches[locale] = strings;
			
			if (locale == _locale)
				updateStrings();
		}
	}
}