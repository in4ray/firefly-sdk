package com.firefly.core.assets
{
	import com.firefly.core.firefly_internal;
	import com.firefly.core.assets.loaders.LocaleXMLLoader;
	import com.firefly.core.assets.loaders.XMLLoader;
	import com.firefly.core.async.Completer;
	import com.firefly.core.async.Future;
	import com.firefly.core.async.GroupCompleter;
	import com.firefly.core.concurrency.GreenThread;
	import com.firefly.core.localization.LocaleBunch;
	import com.firefly.core.utils.Log;
	import com.firefly.core.utils.SingletonLocator;
	
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	
	import avmplus.getQualifiedClassName;
	
	use namespace firefly_internal;
	
	public class LocalizationBundle implements IAssetBundle
	{
		/** @private */
		protected static const thread:GreenThread = new GreenThread();
		
		/** @private */
		firefly_internal var loaders:Dictionary;
		/** @private */
		firefly_internal var localeBunches:Dictionary;
		
		/** @private */
		private var _name:String;
		/** @private */
		private var _loaded:Boolean;
		
		/** @private */
		protected var _singleton:LocalizationBundle;
		
		public function LocalizationBundle()
		{
			this._name = getQualifiedClassName(this);
			this._singleton = SingletonLocator.getInstance(getDefinitionByName(_name) as Class, this);
			
			if(_singleton == this)
			{
				loaders = new Dictionary();
				localeBunches = new Dictionary();
				regLocales();
			}
		}
		
		/** Unique name of bundle. */
		public function get name():String { return _name; }
		
		protected function regLocales():void { }
		
		protected function regLocaleXML(id:String, path:String):void
		{
			if(_singleton != this)
				return _singleton.regLocaleXML(id, path);
			
			if(!(id in loaders))
				loaders[id] = new LocaleXMLLoader(id, path);
		}
		
		public function getLocaleBunch(id:String):LocaleBunch
		{
			if(_singleton != this)
				return _singleton.getLocaleBunch(id);
			
			if(id in localeBunches)
				return localeBunches[id];
			
			CONFIG::debug {
				Log.error("Locale bunch {0} is not found.", id);
			};
			
			return null;
		}
		
		public function load():Future
		{
			if(_singleton != this)
				return _singleton.load();
			
			if(!_loaded)
			{
				var group:GroupCompleter = new GroupCompleter();
				for each (var loader:XMLLoader in loaders) 
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
		
		private function onLocaleLoaded(loader:XMLLoader, completer:Completer):void
		{
			loader.build(this);
			loader.unload();
			
			completer.complete();
		}
		
		public function unload():void
		{
			if(_singleton != this)
				return _singleton.unload();
			
			_loaded = false;
		}
		
		firefly_internal function createLocaleBunch(id:String, xml:XML):void
		{
			var localeBunch:LocaleBunch = new LocaleBunch(id);
			var strings:XMLList = xml.str;
			for each (var strXML:XML in strings) 
			{
				localeBunch.addStr(strXML.@key.toString(), strXML.@value.toString());
			}
			
			if (!(id in localeBunches))
				localeBunches[id] = localeBunch;
		}
	}
}