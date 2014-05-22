// =================================================================================================
//
//	Firefly Framework
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.assets.loaders.textures.atlases
{
	import com.firefly.core.firefly_internal;
	import com.firefly.core.async.Completer;
	import com.firefly.core.async.Future;
	import com.firefly.core.async.GroupCompleter;
	import com.firefly.core.assets.TextureBundle;
	import com.firefly.core.assets.loaders.ITextureLoader;
	import com.firefly.core.utils.StringUtil;
	
	import flash.display.BitmapData;
	import flash.geom.Point;
	
	import avmplus.getQualifiedClassName;

	use namespace firefly_internal;
	
	[ExcludeClass]
	/** The loader that loads general asset for creation texture atlas based on bitmap data. */
	public class AtlasLoader implements ITextureLoader
	{
		protected var _loaders:Array;
		protected var _id:String
		protected var _xmlPath:String;
		protected var _autoScale:Boolean;
		protected var _xmlLoader:AtlasXMLLoader;
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
		public function AtlasLoader(id:String, loaders:Array, xmlPath:String, autoScale:Boolean = true)
		{
			this._id = id;
			this._loaders = loaders;
			this._xmlPath = xmlPath;
			this._autoScale = autoScale;
		}
		
		/** Unique identifier. */
		public function get id():* { return _id; }
		
		/** Load bitmap and xml assets asynchronously. 
		 *  @return Future object for callback.*/
		public function load(canvas:BitmapData = null, position:Point = null):Future
		{
			var completer:Completer = new Completer();
			
			_xmlLoader = new AtlasXMLLoader(id, _xmlPath, _autoScale);
			_xmlLoader.load().then(onXMLLoaded, completer);
			
			return completer.future;
		}
		
		/** @private */		
		private function onXMLLoaded(completer:Completer):void
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
			
			// load composit atlas
			if(_loaders.length > 1)
			{
				// load textures
				var group:GroupCompleter = new GroupCompleter();
				
				for each (var loader:ITextureLoader in _loaders) 
				{
					var name:String;
					if(loader.id is Class)
						name = StringUtil.getClassName(loader.id);
					else
						name = loader.id;
					
					xml = _xmlLoader.xml.SubTexture.(@name==name)[0];
					if(xml)
						group.append(TextureBundle.thread.schedule(loader.load, _bitmapData, new Point(parseFloat(xml.@x),parseFloat(xml.@y))));
				}
				group.future.then(completer.complete);
			}
			// load standard atlas
			else 
			{
				TextureBundle.thread.schedule(_loaders[0].load, _bitmapData).then(completer.complete);
			}
		}
		
		/** Unload loaded data. */	
		public function unload():void
		{
			for each (var loader:ITextureLoader in _loaders) 
			{
				loader.unload();
			}
			
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