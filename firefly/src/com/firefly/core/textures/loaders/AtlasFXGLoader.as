// =================================================================================================
//
//	Firefly Framework
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.textures.loaders
{
	import com.firefly.core.firefly_internal;
	import com.firefly.core.async.Completer;
	import com.firefly.core.async.Future;
	import com.firefly.core.async.GroupCompleter;
	import com.firefly.core.concurrency.GreenThread;
	import com.firefly.core.textures.TextureBundle;
	
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import avmplus.getQualifiedClassName;
	
	use namespace firefly_internal;
	
	[ExcludeClass]
	/** The loader that loads FXG asset for creation texture atlas based on bitmap data. */
	public class AtlasFXGLoader implements ITextureLoader
	{
		private var _fxgs:Array;
		private var _id:String
		private var _xmlPath:String;
		private var _autoScale:Boolean;
		private var _xmlLoader:AtlasXMLLoader;
		private var _fxgLoaders:Vector.<FXGLoader>;
		protected var _bitmapData:BitmapData;
		
		/** Constructor.
		 * 
		 *  @param id Unique identifier.
		 *  @param fxgs List of source classes of FXG data.
		 * 	@param xmlPath Path to the xml file.
		 *  @param autoScale Specifies whether use autoscale algorithm. Based on design size and stage size texture will be 
		 * 		   proportionally scale to stage size. E.g. design size is 1024x768 and stage size is 800x600 the formula is
		 * 		   <code>var scale:Number = Math.min(1024/800, 768/600);</code></br> 
		 * 		   Calculated scale is 1.28, all bitmaps and described textures in xml scale based on it. */
		public function AtlasFXGLoader(id:String, fxgs:Array, xmlPath:String, autoScale:Boolean = true)
		{
			this._id = id;
			this._fxgs = fxgs;
			this._xmlPath = xmlPath;
			this._autoScale = autoScale;
			
			_fxgLoaders = new Vector.<FXGLoader>(); 
		}
		
		/** Unique identifier. */
		public function get id():* { return _id; }
		
		/** Load bitmap and xml assets asynchronously. 
		 *  @return Future object for callback.*/
		public function load():Future
		{
			var completer:Completer = new Completer();
			var group:GroupCompleter = new GroupCompleter();
			for each (var SourceClass:Class in _fxgs) 
			{
				var loader:FXGLoader = new FXGLoader(SourceClass, _autoScale);
				_fxgLoaders.push(loader);
				group.append(TextureBundle.thread.schedule(loader.load));
			}
			
			_xmlLoader = new AtlasXMLLoader(id, _xmlPath, _autoScale);
			group.append(_xmlLoader.load());
			
			group.future.then(loadingComplete, completer);
			
			return completer.future;
		}
		
		private function loadingComplete(completer:Completer):void
		{
			var right:Number = 0;
			var bottom:Number = 0;
			var xml:XML;
			// find size of atlas
			for each (xml in _xmlLoader.xml.SubTexture) 
			{
				right = Math.max(right, parseFloat(xml.@x) + parseFloat(xml.@width));
				bottom = Math.max(bottom, parseFloat(xml.@y) + parseFloat(xml.@height));
			}
			
			_bitmapData = new BitmapData(right, bottom, true, 0x00ffffff);
			
			for each (var loader:FXGLoader in _fxgLoaders) 
			{
				var name:String = getQualifiedClassName(loader.id).split("::")[1];
				xml = _xmlLoader.xml.SubTexture.(@name==name)[0];
				if(xml)
					_bitmapData.copyPixels(loader.bitmapData, new Rectangle(0,0,_bitmapData.width,_bitmapData.height), new Point(parseFloat(xml.@x),parseFloat(xml.@y))); 
			}
			
			completer.complete();
		}
		
		/** Unload loaded data. */	
		public function unload():void
		{
			for each (var loader:FXGLoader in _fxgLoaders) 
			{
				loader.unload();
			}
			_fxgLoaders.length = 0;
			
			if (_xmlLoader)
			{
				_xmlLoader.unload();
				_xmlLoader = null;
			}
			
			_bitmapData.dispose();
			_bitmapData = null;
		}
		
		/** Build texture atlas from the loaded data.
		 * 	@param visitor Texture bundle to call method of texture atlas creation from bitmap data and xml.
		 *  @return Future object for callback.*/
		public function build(visitor:TextureBundle):Future
		{
			visitor.createTextureAtlasFromBitmapData(id, _bitmapData, _xmlLoader.xml);
			
			return null;
		}
	}
}