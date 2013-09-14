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
	import com.firefly.core.async.Future;
	import com.firefly.core.textures.TextureBundle;
	
	use namespace firefly_internal;
	
	[ExcludeClass]
	/** The loader for loading bitmap asset (PNG/JPEG) and atlas xml needed for creation texture atlas based on bitmap data. */
	public class AtlasBitmapLoader implements ITextureLoader
	{
		private var _id:String
		private var _bitmapPath:String;
		private var _xmlPath:String;
		private var _autoScale:Boolean;
		private var _checkPolicyFile:Boolean;
		private var _bitmapLoader:BitmapLoader;
		private var _xmlLoader:AtlasXMLLoader;
		
		/** Constructor.
		 * 
		 *  @param id Unique identifier of the loader.
		 *  @param bitmapPath Path to the bitmap file.
		 * 	@param xmlPath Path to the xml file.
		 *  @param autoScale Specifies whether use autoscale algorithm. Based on design size and stage size texture will be 
		 * 		   proportionally scale to stage size. E.g. design size is 1024x768 and stage size is 800x600 the formula is
		 * 		   <code>var scale:Number = Math.min(1024/800, 768/600);</code></br> 
		 * 		   Calculated scale is 1.28, all bitmaps and described textures in xml scale based on it.
		 *  @param checkPolicyFile Specifies whether the application should attempt to download a URL 
		 * 		   policy file from the loaded object's server before beginning to load the object itself. */	
		public function AtlasBitmapLoader(id:String, bitmapPath:String, xmlPath:String, autoScale:Boolean = true, checkPolicyFile:Boolean = false)
		{
			this._id = id;
			this._bitmapPath = bitmapPath;
			this._xmlPath = xmlPath;
			this._autoScale = autoScale;
			this._checkPolicyFile = checkPolicyFile;
		}
		
		/** Unique identifier. */
		public function get id():* { return _id; }
		
		/** Loader which loads bitmap asset. */
		public function get bitmapLoader():BitmapLoader { return _bitmapLoader; }
		
		/** Loader which loads xml asset. */
		public function get xmlLoader():AtlasXMLLoader { return _xmlLoader; }
		
		/** Load bitmap and xml assets asynchronously. 
		 *  @return Future object for callback.*/
		public function load():Future
		{
			_bitmapLoader = new BitmapLoader(_id, _bitmapPath, _autoScale, false, "", "", _checkPolicyFile);
			_xmlLoader = new AtlasXMLLoader(_id, _xmlPath, _autoScale);
			
			return Future.forEach(_bitmapLoader.load(), _xmlLoader.load());
		}
		
		/** Unload loaded data. */	
		public function unload():void
		{
			if (_bitmapLoader)
			{
				_bitmapLoader.unload();
				_bitmapLoader = null;
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
			visitor.createTextureAtlasFromBitmapData(_id, _bitmapLoader.bitmapData, _xmlLoader.xml);
			
			return null;
		}
	}
}