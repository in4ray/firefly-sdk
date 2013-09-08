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
	/** The loader for loading ATF asset and atlas xml needed for creation texture atlas based on ATF data. */
	public class AtlasATFLoader implements ITextureLoader
	{
		private var _id:String
		private var _atfPath:String;
		private var _xmlPath:String;
		private var _atfLoader:ATFLoader;
		private var _xmlLoader:AtlasXMLLoader;
		
		/** Constructor.
		 *  @param id Unique identifier of the loader.
		 *  @param atfPath Path to ATF file.
		 * 	@param xmlPath Path to the xml file.*/	
		public function AtlasATFLoader(id:String, atfPath:String, xmlPath:String)
		{
			this._id = id;
			this._atfPath = atfPath;
			this._xmlPath = xmlPath;
		}
		
		/** Unique identifier. */
		public function get id():*
		{
			return _id;
		}
		
		/** Loader which loads ATF asset. */
		public function get atfLoader():ATFLoader
		{
			return _atfLoader;
		}
		
		/** Loader which loads xml asset. */
		public function get xmlLoader():AtlasXMLLoader
		{
			return _xmlLoader;
		}
		
		/** Load ATF and xml assets asynchronously. 
		 *  @return Future object for callback.*/
		public function load():Future
		{
			_atfLoader = new ATFLoader(_id, _atfPath);
			_xmlLoader = new AtlasXMLLoader(_id, _xmlPath, false);
			
			return Future.forEach(_atfLoader.load(), _xmlLoader.load());
		}
		
		/** Release loaded data. */	
		public function release():void
		{
			if (_atfLoader)
			{
				_atfLoader.release();
				_atfLoader = null;
			}
			if (_xmlLoader)
			{
				_xmlLoader.release();
				_xmlLoader = null;
			}
		}
		
		/** Build texture atlas from the loaded data.
		 * 	@param visitor Texture bundle to call method of texture atlas creation from byte array and xml.
		 *  @return Future object for callback.*/
		public function build(visitor:TextureBundle):Future
		{
			visitor.createTextureAtlasFromByteArray(_id, _atfLoader.data, _xmlLoader.xml);
			
			return null;
		}
	}
}