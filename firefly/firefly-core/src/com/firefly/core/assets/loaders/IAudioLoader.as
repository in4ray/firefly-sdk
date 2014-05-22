// =================================================================================================
//
//	Firefly Framework
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.assets.loaders
{
	import com.firefly.core.async.Future;
	
	/** Interface for audio source loaders. */	
	public interface IAudioLoader
	{
		/** Loader unique identifier. */
		function get id():*;
		
		/** Load audio data asynchronously. 
		 *  @return Future object for callback.*/		
		function load():Future;
		
		/** Get audio source (ByteArray or Sound). */		
		function get data():*;
		
		/** Release audio source data from RAM. */		
		function release():void;
	}
}