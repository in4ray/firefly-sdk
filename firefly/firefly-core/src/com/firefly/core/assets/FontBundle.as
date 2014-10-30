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
	import com.firefly.core.assets.loaders.FontXMLLoader;
	import com.firefly.core.assets.loaders.XMLLoader;
	import com.firefly.core.async.Completer;
	import com.firefly.core.async.Future;
	import com.firefly.core.async.GroupCompleter;
	import com.firefly.core.concurrency.GreenThread;
	import com.firefly.core.utils.CommonUtils;
	import com.firefly.core.utils.Log;
	import com.firefly.core.utils.SingletonLocator;
	
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	
	import avmplus.getQualifiedClassName;
	
	import starling.text.BitmapFont;
	import starling.textures.Texture;
	
	use namespace firefly_internal;
	
	/** Font bundle class for loading, creating and storing fonts.
	 *  
	 *  @example The following code shows how to register font xml for loading:
	 *  <listing version="3.0">
	 *************************************************************************************
 public class GameFontBundle extends FontBundle
 {
 	override protected function regFonts():void
	{
		regFontXML("myFont", "../fonts/Mauryssel.fnt");
	}
 
	public function get myFont():BitmapFont { return getBitmapFont("myFont"); }
 }
	 *************************************************************************************
	 *  </listing> */	
	public class FontBundle implements IAssetBundle
	{
		/** @private */
		protected static const thread:GreenThread = new GreenThread();
		
		/** @private */
		firefly_internal var _loaders:Dictionary;
		/** @private */
		firefly_internal var _fontXmls:Dictionary;
		/** @private */
		firefly_internal var _fonts:Dictionary;
		
		/** @private */
		private var _name:String;
		/** @private */
		private var _loaded:Boolean;
		
		/** @private */
		protected var _singleton:FontBundle;
		
		/** Constructor. */
		public function FontBundle()
		{
			this._name = getQualifiedClassName(this);
			this._singleton = SingletonLocator.getInstance(getDefinitionByName(_name) as Class, this);
			
			if(_singleton == this)
			{
				_loaders = new Dictionary();
				_fontXmls = new Dictionary();
				_fonts = new Dictionary();
				regFonts();
			}
		}
		
		/** Unique name of bundle. */
		public function get name():String { return _name; }
		
		/** Return font xml by unique identifier.
		 *  @param id Unique identifier of the xml.
		 *  @return Font xml stored in the bundle. */
		public function getFontXML(id:String):XML
		{
			if(_singleton != this)
				return _singleton.getFontXML(id);
			
			if(id in _fontXmls)
				return _fontXmls[id];
			
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
			
			if(id in _fonts)
				return _fonts[id];
			
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
			
			if(!_loaded && !CommonUtils.isEmptyDict(_loaders))
			{
				var group:GroupCompleter = new GroupCompleter();
				for each (var loader:XMLLoader in _loaders) 
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
		 *  @return Created bitmap font. */		
		public function buildBitmapFont(id:String, texture:Texture):BitmapFont
		{
			if(_singleton != this)
				return _singleton.buildBitmapFont(id, texture);
			
			var xml:XML;
			if(id in _fontXmls)
				xml = _fontXmls[id];
			
			CONFIG::debug {
				if (!xml)
					Log.error("Font xml {0} is not found.", id);
			};
			
			var bitmapFont:BitmapFont = new BitmapFont(texture, xml);
			_fonts[id] = bitmapFont;
			
			return bitmapFont;
		}
		
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
			
			if(!(id in _loaders))
				_loaders[id] = new FontXMLLoader(id, path, autoScale);
		}
		
		/** @private */		
		private function onFontLoaded(loader:XMLLoader, completer:Completer):void
		{
			loader.build(this);
			loader.release();
			
			completer.complete();
		}
		
		/** @private
		 *  Save font xml in the font bundle.
		 * 	@param id Unique identifier of the font xml.
		 *  @param xml XML data for font creation. **/
		firefly_internal function addFontXML(id:String, xml:XML):void
		{
			if (!(id in _fontXmls))
				_fontXmls[id] = xml;
		}
	}
}