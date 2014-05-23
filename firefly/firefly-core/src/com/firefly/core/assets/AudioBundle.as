// =================================================================================================
//
//	Firefly Framework
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.assets
{
	import com.firefly.core.Firefly;
	import com.firefly.core.firefly_internal;
	import com.firefly.core.async.Completer;
	import com.firefly.core.async.Future;
	import com.firefly.core.async.GroupCompleter;
	import com.firefly.core.assets.loaders.audio.AudioLoader;
	import com.firefly.core.assets.loaders.audio.EmbededAudioLoader;
	import com.firefly.core.assets.loaders.IAudioLoader;
	import com.firefly.core.concurrency.GreenThread;
	import com.firefly.core.consts.SystemType;
	import com.firefly.core.utils.Log;
	import com.firefly.core.utils.SingletonLocator;
	
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	
	import avmplus.getQualifiedClassName;
	import com.firefly.core.audio.IAudio;
	import com.firefly.core.audio.MusicAndroid;
	import com.firefly.core.audio.MusicDefault;
	import com.firefly.core.audio.SFXPool;
	
	use namespace firefly_internal;
	
	/** Audio bundle class for loading, creating and storing audio musics and effects.
	 *  
	 *  @example The following code shows how to register different types of audio:
	 *  <listing version="3.0">
	 *************************************************************************************
public class GameAudioBundle extends AudioBundle
{
	override protected function regAudio():void
	{
		regMusic("trek1", "../audio/trek1.ogg");
		regSFX("effect1", "../audio/effect1.mp3", 3);
	}
	 
	public function get trek1():IAudio { return getAudio("trek1"); }
	public function get effect1():IAudio { return getAudio("effect1"); }
}
	 *************************************************************************************
	 *  </listing> */	
	public class AudioBundle implements IAssetBundle
	{
		/** @private */
		protected static const thread:GreenThread = new GreenThread();
		
		/** @private */
		firefly_internal var loaders:Dictionary;
		/** @private */
		firefly_internal var audios:Dictionary;
		
		/** @private */
		private var _name:String;
		/** @private */
		private var _loaded:Boolean;
		
		/** @private */
		protected var _singleton:AudioBundle;
		
		/** Constructor. */		
		public function AudioBundle()
		{
			this._name = getQualifiedClassName(this);
			this._singleton = SingletonLocator.getInstance(getDefinitionByName(_name) as Class, this);
			
			if(_singleton == this)
			{
				loaders = new Dictionary();
				audios = new Dictionary();
				regAudio();
			}
		}
		
		/** Unique name of bundle. */
		public function get name():String {	return _name; }
		
		/** Register Sound effect for loading from file system.
		 *  @param id Unique identifier.
		 *  @param path Source file path.
		 *  @param poolCount Cound of effect instances in pool. Only that count will be able to play audio concurrently.
		 *  @param checkPolicyFile Specifies whether the application should attempt to download a URL 
		 * 		   policy file from the loaded object's server before beginning to load the object itself. */		
		protected function regSFX(id:String, path:String, poolCount:int=1, checkPolicyFile:Boolean = false):void
		{
			if(_singleton != this)
				return _singleton.regSFX(id, path);
			
			if(!(id in loaders))
			{
				loaders[id] = new AudioLoader(id, path, checkPolicyFile);
				audios[id] = new SFXPool(poolCount);
			}
		}
		
		/** Register Sound effect for loading from embedded source.
		 *  @param source Embedded file.
		 *  @param poolCount Cound of effect instances in pool. Only that count will be able to play audio concurrently. */		
		protected function regEmbededSFX(source:Class, poolCount:int=1):void
		{
			if(_singleton != this)
				return _singleton.regEmbededSFX(source);
			
			if(!(source in loaders))
			{
				loaders[source] = new EmbededAudioLoader(source);
				audios[source] = new SFXPool(poolCount);
			}
		}
		
		/** Register Music for loading from file system.
		 *  @param id Unique identifier.
		 *  @param path Source file path.
		 *  @param checkPolicyFile Specifies whether the application should attempt to download a URL 
		 * 		   policy file from the loaded object's server before beginning to load the object itself. */
		protected function regMusic(id:String, path:String, checkPolicyFile:Boolean = false):void
		{
			if(_singleton != this)
				return _singleton.regMusic(id, path);
			
			if(!(id in loaders))
			{
				loaders[id] = new AudioLoader(id, path, checkPolicyFile);
				
				if(Firefly.current.systemType == SystemType.ANDROID)
					audios[id] = new MusicAndroid();
				else
					audios[id] = new MusicDefault();
			}
		}
		
		/** Register Sound effect for loading from embedded source.
		 *  @param source Embedded file. */		
		protected function regEmbededMusic(source:Class):void
		{
			if(_singleton != this)
				return _singleton.regEmbededMusic(source);
			
			if(!(source in loaders))
			{
				loaders[source] = new EmbededAudioLoader(source);
				
				if(Firefly.current.systemType == SystemType.ANDROID)
					audios[source] = new MusicAndroid();
				else
					audios[source] = new MusicDefault();
			}
		}
		
		/** Register audio data. This method calls after creation of the audio bundle. */
		protected function regAudio():void { }
		
		/** Get Audio instance (music or sfx) by identifier.
		 *  @param id Unique identifier.
		 *  @return Audio instance. */		
		public function getAudio(id:*):IAudio
		{
			if(_singleton != this)
				return _singleton.getAudio(id);
			
			if(id in audios)
				return audios[id];
			
			CONFIG::debug {
				Log.error("Audio {0} is not found.", id);
			};
			
			return null;
		}
		
		/** Load audio data asynchronously.
		 *  @return Future object for callback. */		
		public function load():Future
		{
			if(_singleton != this)
				return _singleton.load();
			
			if(!_loaded)
			{
				var group:GroupCompleter = new GroupCompleter();
				for each (var loader:IAudioLoader in loaders) 
				{
					var completer:Completer = new Completer();
					
					thread.schedule(loader.load).then(onAudioLoaded, loader, completer);
					group.append(completer.future);
				}
				
				_loaded = true;
				
				return group.future;
			}
			
			return Future.nextFrame();
		}
		
		/** @private */		
		private function onAudioLoaded(loader:IAudioLoader, completer:Completer):void
		{
			var audio:IAudio = audios[loader.id];
			
			if(audio)
				audio.load( loader.id, loader.data);
			
			loader.release();
			
			completer.complete();
		}
		
		/** Release audio data from RAM. */		
		public function unload():void
		{
			if(_singleton != this)
				return _singleton.unload();
			
			
			for each (var audio:IAudio in audios) 
			{
				audio.unload();
			}
			
			_loaded = false;
		}
	}
}