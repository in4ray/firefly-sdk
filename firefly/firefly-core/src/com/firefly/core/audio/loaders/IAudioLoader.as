package com.firefly.core.audio.loaders
{
	import com.firefly.core.async.Future;
	
	import flash.utils.ByteArray;

	public interface IAudioLoader
	{
		/** Loader unique identifier. */
		function get id():String;
		
		function load():Future;
		function get data():ByteArray;
		function release():void;
		
	}
}