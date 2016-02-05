// =================================================================================================
//
//	Firefly Framework
//	Copyright 2016 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.assets.loaders
{
	import com.firefly.core.async.Future;
	import com.firefly.core.assets.TextureBundle;
	
	import flash.display.BitmapData;
	import flash.geom.Point;

	[ExcludeClass]
	/** Intreface for loaders that will be used in texture bundles to group all loaders. */
	public interface ITextureLoader
	{
		/** Loader unique identifier. */
		function get id():*;
		
		/** Load texture data asynchronously. 
		 *  @return Future object for callback.*/
		function load(canvas:BitmapData = null, position:Point = null):Future;
		
		/** Release loaded data. */	
		function release():void;
		
		/** Build texture, atlas etc. from the loaded data. 
		 *  @return Future object for callback.*/
		function build(visitor:TextureBundle):Future;
	}
}