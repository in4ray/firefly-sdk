// =================================================================================================
//
//	Firefly Framework
//	Copyright 2016 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.assets.loaders.textures.atlases
{
	import com.firefly.core.firefly_internal;
	import com.firefly.core.assets.loaders.textures.FXGLoader;
	
	import avmplus.getQualifiedClassName;
	
	use namespace firefly_internal;
	
	[ExcludeClass]
	/** The loader that loads FXG asset for creation texture atlas based on bitmap data. */
	public class AtlasFXGLoader extends AtlasLoader 
	{
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
			var loaders:Array = [];
			for each (var SourceClass:Class in fxgs) 
			{
				loaders.push(new FXGLoader(SourceClass, SourceClass, autoScale));
			}
			
			super(id, loaders, xmlPath, autoScale);
		}
	}
}