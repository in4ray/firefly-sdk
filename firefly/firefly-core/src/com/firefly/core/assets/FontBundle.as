package com.firefly.core.assets
{
	import com.firefly.core.firefly_internal;
	import com.firefly.core.assets.loaders.FontXMLLoader;
	import com.firefly.core.assets.loaders.IAudioLoader;
	import com.firefly.core.assets.loaders.XMLLoader;
	import com.firefly.core.async.Completer;
	import com.firefly.core.async.Future;
	import com.firefly.core.async.GroupCompleter;
	import com.firefly.core.concurrency.GreenThread;
	import com.firefly.core.utils.Log;
	import com.firefly.core.utils.SingletonLocator;
	
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	
	import avmplus.getQualifiedClassName;
	
	import starling.text.BitmapFont;
	import starling.textures.Texture;
	
	use namespace firefly_internal;
	
	public class FontBundle implements IAssetBundle
	{
		protected static const thread:GreenThread = new GreenThread();
		
		/** @private */
		firefly_internal var loaders:Dictionary;
		/** @private */
		firefly_internal var fontXmls:Dictionary;
		/** @private */
		firefly_internal var fonts:Dictionary;
		
		/** @private */
		private var _name:String;
		/** @private */
		private var _loaded:Boolean;
		
		/** @private */
		protected var _singleton:FontBundle;
		
		public function FontBundle()
		{
			this._name = getQualifiedClassName(this);
			this._singleton = SingletonLocator.getInstance(getDefinitionByName(_name) as Class, this);
			
			if(_singleton == this)
			{
				loaders = new Dictionary();
				fontXmls = new Dictionary();
				fonts = new Dictionary();
				regFonts();
			}
		}
		
		/** Unique name of bundle. */
		public function get name():String { return _name; }
		
		/** Register fonts. This method calls after creation of the font bundle. */
		protected function regFonts():void { }
		
		/** Register font xml for loading.
		 *
		 *  @param id Unique identifier of the loader.
		 *  @param path Path to the xml file.
		 *  @param autoScale Specifies whether use autoscale algorithm. Based on design size and stage size texture will be 
		 * 		   proportionally scale to stage size. E.g. design size is 1024x768 and stage size is 800x600 the formula is
		 * 		   <code>var scale:Number = Math.min(1024/800, 768/600);</code></br> 
		 * 		   Calculated scale is 1.28 and all bitmaps scale based on it. */
		protected function regFontXML(id:String, path:String, autoScale:Boolean = true):void
		{
			if(_singleton != this)
				return _singleton.regFontXML(id, path, autoScale);
			
			if(!(id in loaders))
				loaders[id] = new FontXMLLoader(id, path, autoScale);
		}
		
		/** Return font xml by unique identifier.
		 *  @param id Unique identifier of the xml.
		 *  @return Font xml stored in the bundle. */
		public function getFontXML(id:String):XML
		{
			if(_singleton != this)
				return _singleton.getFontXML(id);
			
			if(id in fontXmls)
				return fontXmls[id];
			
			CONFIG::debug {
				Log.error("Font xml {0} is not found.", id);
			};
			
			return null;
		}
		
		/** Return bitmap font by unique identifier.
		 *  @param id Unique identifier of the bitmap font.
		 *  @return Bitmap font stored in the bundle. */
		public function getBitmapFont(id:String):BitmapFont
		{
			if(_singleton != this)
				return _singleton.getBitmapFont(id);
			
			if(id in fonts)
				return fonts[id];
			
			CONFIG::debug {
				Log.error("Bitmap font {0} is not found.", id);
			};
			
			return null;
		}
		
		/** Load font data asynchronously.
		 *  @return Future object for callback. */
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
					
					thread.schedule(loader.load).then(onFontLoaded, loader, completer);
					group.append(completer.future);
				}
				
				_loaded = true;
				
				return group.future;
			}
			return Future.nextFrame();
		}
		
		/** @private */		
		private function onFontLoaded(loader:XMLLoader, completer:Completer):void
		{
			loader.build(this);
			loader.unload();
			
			completer.complete();
		}
		
		/** Release font data from RAM. */		
		public function unload():void
		{
			if(_singleton != this)
				return _singleton.unload();
			
			_loaded = false;
		}
		
		/** Create and store bitmap font using loaded xml file and bitmap texture from the param.
		 * 	The identifier should be the same as registered font xml.
		 * 	@param id Unique identifier of the font.
		 * 	@param texture Bitmap texture of the font.
		 *  @return BitmapFont Created bitmap font. */		
		public function createBitmapFont(id:String, texture:Texture):BitmapFont
		{
			if(_singleton != this)
				return _singleton.createBitmapFont(id, texture);
			
			var fontXml:XML;
			if(id in fontXmls)
				fontXml = fontXmls[id];
			
			CONFIG::debug {
				if (!fontXml)
					Log.error("Font xml {0} is not found.", id);
			};
			
			var bitmapFont:BitmapFont = new BitmapFont(texture, fontXml);
			fonts[id] = bitmapFont;
			
			return bitmapFont;
		}
		
		/** @private
		 *  Save font xml in texture bundle.
		 * 	@param id Unique identifier of the font xml.
		 *  @param xml XML data for font creation. **/
		firefly_internal function addFontXML(id:String, xml:XML):void
		{
			if (!(id in fontXmls))
				fontXmls[id] = xml;
		}
	}
}