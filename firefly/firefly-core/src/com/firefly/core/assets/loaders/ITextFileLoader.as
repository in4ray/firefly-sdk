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
	import com.firefly.core.assets.IAssetBundle;
	import com.firefly.core.async.Future;

	/** Intreface for loaders that will be used in text file bundles to group all loaders. */
	[ExcludeClass]
	public interface ITextFileLoader
	{
		/** Unique identifier. */
		function get id():*;
		
		/** Load file data asynchronously. 
		 *  @return Future object for callback. */		
		function load():Future;
		
		/** Unload loaded data. */	
		function release():void;
		
		/** Build result from the loaded data.
		 * 	@param assetBundle Asset bundle.
		 *  @return Future object for callback.*/
		function build(assetBundle:IAssetBundle):Future;
	}
}