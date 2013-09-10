package com.firefly.core.audio.loaders
{
	import com.firefly.core.async.Future;
	
	import flash.utils.ByteArray;

	public interface IAudioLoader
	{
		/** Loader unique identifier. */
		function get id():*;
		
		function load():Future;
		function get data():*;
		function release():void;
		
	}
}