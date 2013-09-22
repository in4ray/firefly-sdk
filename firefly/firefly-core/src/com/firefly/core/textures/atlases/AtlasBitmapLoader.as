// =================================================================================================
//
//	Firefly Framework
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.textures.atlases
{
	import com.firefly.core.firefly_internal;
	import com.firefly.core.textures.loaders.BitmapLoader;
	
	use namespace firefly_internal;
	
	[ExcludeClass]
	/** The loader for loading bitmap asset (PNG/JPEG) and atlas xml needed for creation texture atlas based on bitmap data. */
	public class AtlasBitmapLoader extends AtlasLoader
	{
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
			super(id, [new BitmapLoader(id, bitmapPath, autoScale, false, "", "", checkPolicyFile)], xmlPath, autoScale);
		}
	}
}