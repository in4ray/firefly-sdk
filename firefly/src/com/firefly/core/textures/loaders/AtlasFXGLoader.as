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
	import com.firefly.core.async.DelayedCompleter;
	import com.firefly.core.async.Future;
	import com.firefly.core.textures.TextureBundle;
	import com.firefly.core.utils.TextureUtil;
	import com.firefly.core.utils.XMLUtil;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	import spark.core.SpriteVisualElement;
	
	use namespace firefly_internal;
	
	[ExcludeClass]
	/** The loader that loads FXG asset for creation texture atlas based on bitmap data. */
	public class AtlasFXGLoader implements ITextureLoader
	{
		private var _SourceClass:Class;
		private var _xmlPath:String;
		private var _autoScale:Boolean;
		private var _fxgLoader:FXGLoader;
		private var _xmlLoader:AtlasXMLLoader;
		
		/** Constructor.
		 * 
		 *  @param source Source of fxg data.
		 * 	@param xmlPath Path to the xml file.
		 *  @param autoScale Specifies whether use autoscale algorithm. Based on design size and stage size texture will be 
		 * 		   proportionally scale to stage size. E.g. design size is 1024x768 and stage size is 800x600 the formula is
		 * 		   <code>var scale:Number = Math.min(1024/800, 768/600);</code></br> 
		 * 		   Calculated scale is 1.28, all bitmaps and described textures in xml scale based on it. */
		public function AtlasFXGLoader(source:Class, xmlPath:String, autoScale:Boolean = true)
		{
			this._SourceClass = source;
			this._xmlPath = xmlPath;
			this._autoScale = autoScale;
		}
		
		/** Unique identifier. */
		public function get id():* { return _SourceClass; }
		
		/** Loader which loads FXG asset. */
		public function get bitmapLoader():FXGLoader { return _fxgLoader; }
		
		/** Loader which loads xml asset. */
		public function get xmlLoader():AtlasXMLLoader { return _xmlLoader; }
		
		/** Load bitmap and xml assets asynchronously. 
		 *  @return Future object for callback.*/
		public function load():Future
		{
			_fxgLoader = new FXGLoader(_SourceClass, _autoScale);
			_xmlLoader = new AtlasXMLLoader(id, _xmlPath, _autoScale);
			
			return Future.forEach(_fxgLoader.load(), _xmlLoader.load());
		}
		
		/** Unload loaded data. */	
		public function unload():void
		{
			if (_fxgLoader)
			{
				_fxgLoader.unload();
				_fxgLoader = null;
			}
			if (_xmlLoader)
			{
				_xmlLoader.unload();
				_xmlLoader = null;
			}
		}
		
		/** Build texture atlas from the loaded data.
		 * 	@param visitor Texture bundle to call method of texture atlas creation from bitmap data and xml.
		 *  @return Future object for callback.*/
		public function build(visitor:TextureBundle):Future
		{
			visitor.createTextureAtlasFromBitmapData(id, _fxgLoader.bitmapData, _xmlLoader.xml);
			
			return null;
		}
	}
}