package com.firefly.core.audio
{
	import com.firefly.core.Firefly;
	import com.firefly.core.firefly_internal;
	import com.firefly.core.assets.IAssetBundle;
	import com.firefly.core.async.Future;
	import com.firefly.core.async.GroupCompleter;
	import com.firefly.core.audio.loaders.AudioLoader;
	import com.firefly.core.audio.loaders.EmbededAudioLoader;
	import com.firefly.core.audio.loaders.IAudioLoader;
	import com.firefly.core.concurrency.GreenThread;
	import com.firefly.core.consts.SystemType;
	import com.firefly.core.utils.Log;
	import com.firefly.core.utils.SingletonLocator;
	
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	
	import avmplus.getQualifiedClassName;
	
	import starling.textures.Texture;
	
	use namespace firefly_internal;

	public class AudioBundle implements IAssetBundle
	{
		protected static const thread:GreenThread = new GreenThread();
		
		/** @private */
		firefly_internal var loaders:Dictionary;
		/** @private */
		firefly_internal var audios:Dictionary;
		
		private var _name:String;
		
		protected var singleton:AudioBundle;
		
		public function AudioBundle()
		{
			this._name = getQualifiedClassName(this);
			this.singleton = SingletonLocator.getInstance(getDefinitionByName(_name) as Class, this);
			
			if(singleton == this)
			{
				loaders = new Dictionary();
				audios = new Dictionary();
				regAudio();
			}
		}
		
		/** Unique name of bundle. */
		public function get name():String
		{
			return _name;
		}
		
		protected function regSFX(id:String, path:String, poolCount:int=1, checkPolicyFile:Boolean = false):void
		{
			if(singleton != this)
				return singleton.regSFX(id, path);
			
			if(!(id in loaders))
			{
				loaders[id] = new AudioLoader(id, path, checkPolicyFile);
				audios[id] = new SFXPool(poolCount);
			}
		}
		
		protected function regEmbededSFX(source:Class, poolCount:int=1):void
		{
			if(singleton != this)
				return singleton.regEmbededSFX(source);
			
			if(!(source in loaders))
			{
				loaders[source] = new EmbededAudioLoader(source);
				audios[source] = new SFXPool(poolCount);
			}
		}
		
		protected function regMusic(id:String, path:String, checkPolicyFile:Boolean = false):void
		{
			if(singleton != this)
				return singleton.regMusic(id, path);
			
			if(!(id in loaders))
			{
				loaders[id] = new AudioLoader(id, path, checkPolicyFile);
				
				if(Firefly.current.os == SystemType.ANDROID)
					audios[id] = new MusicAndroid();
				else
					audios[id] = new MusicDefault();
			}
		}
		
		protected function regEmbededMusic(source:Class, checkPolicyFile:Boolean = false):void
		{
			if(singleton != this)
				return singleton.regEmbededMusic(source);
			
			if(!(source in loaders))
			{
				loaders[source] = new EmbededAudioLoader(source);
				
				if(Firefly.current.os == SystemType.ANDROID)
					audios[source] = new MusicAndroid();
				else
					audios[source] = new MusicDefault();
			}
		}
		
		/** Register sounds. This method calls after creation of the sound bundle. */
		protected function regAudio():void
		{
			
		}
		
		public function getAudio(id:*):Texture
		{
			if(singleton != this)
				return singleton.getAudio(id);
			
			if(id in audios)
				return audios[id];
			
			CONFIG::debug {
				Log.error("Audio {0} is not found.", id);
			};
			
			return null;
		}
		
		public function load():Future
		{
			if(singleton != this)
				return singleton.load();
			
			var group:GroupCompleter = new GroupCompleter();
			
			for each (var loader:IAudioLoader in loaders) 
			{
				//group.append(thread.schedule(loadInternal, loader));
			}
			
			return group.future;
		}
		
		public function release():void
		{
			// TODO Auto Generated method stub
			
		}
	}
}