// =================================================================================================
//
//	Firefly Framework
//	Copyright 2016 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.assets
{
	import com.firefly.core.async.Future;

	/** Interface for Asset Bundles that will be grouped into AssetState 
	 *  and loaded by AssetManager. */	
	public interface IAssetBundle
	{
		/** Load Bundle asynchronously. 
		 *  @return Future object for callback. */		
		function load():Future;
		
		/** Release Bundle. */		
		function unload():void;
		
		/** Bundle name */		
		function get name():String;
		
		/** Needs to be reloaded. */		
		function isDirty():Boolean;
	}
}