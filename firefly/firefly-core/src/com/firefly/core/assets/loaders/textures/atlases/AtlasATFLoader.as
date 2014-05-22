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
	import com.firefly.core.async.Future;
	import com.firefly.core.assets.TextureBundle;
	import com.firefly.core.assets.loaders.textures.ATFLoader;
	
	use namespace firefly_internal;
	
	[ExcludeClass]
	/** The loader for loading ATF asset and atlas xml needed for creation texture atlas based on ATF data. */
	public class AtlasATFLoader extends AtlasLoader
	{
		/** Constructor.
		 *  @param id Unique identifier of the loader.
		 *  @param atfPath Path to ATF file.
		 * 	@param xmlPath Path to the xml file.*/	
		public function AtlasATFLoader(id:String, atfPath:String, xmlPath:String)
		{
			super(id, [new ATFLoader(id,atfPath)], xmlPath, false);
		}
		
		/** Build texture atlas from the loaded data.
		 * 	@param visitor Texture bundle to call method of texture atlas creation from byte array and xml.
		 *  @return Future object for callback.*/
		override public function build(visitor:TextureBundle):Future
		{
			visitor.createTextureAtlasFromByteArray(_id, _loaders[0].data, _xmlLoader.xml);
			
			return null;
		}
	}
}