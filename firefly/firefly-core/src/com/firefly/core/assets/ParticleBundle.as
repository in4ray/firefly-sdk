package com.firefly.core.assets
{
	import com.firefly.core.firefly_internal;
	import com.firefly.core.assets.loaders.ParticleXMLLoader;
	import com.firefly.core.assets.loaders.XMLLoader;
	import com.firefly.core.async.Completer;
	import com.firefly.core.async.Future;
	import com.firefly.core.async.GroupCompleter;
	import com.firefly.core.concurrency.GreenThread;
	import com.firefly.core.utils.Log;
	import com.firefly.core.utils.SingletonLocator;
	
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	
	import avmplus.getQualifiedClassName;
	
	import extensions.particles.PDParticleSystem;
	
	import starling.textures.Texture;
	
	use namespace firefly_internal;
	
	/** Particle bundle class for loading, creating and storing particles.
	 *  
	 *  @example The following code shows how to register particle xml for loading:
	 *  <listing version="3.0">
	 *************************************************************************************
 public class GameParticleBundle extends ParticleBundle
 {
 	override protected function regParticles():void
	{
		regParticleXML("myParticle", "../particles/particle.pex");
	}
 
	public function get myParticle():PDParticleSystem { return getParticle("myParticle"); }
 }
	 *************************************************************************************
	 *  </listing> 
	 *	@example The following code shows how to create particle in case the particle xml/pex file is loaded by
	 * 	ParticleBundle class:
	 *  <listing version="3.0">
	 *************************************************************************************
 public class MySprite extends Sprite
 {
 	public function MySprite()
	{
		super();
		
		var textureBundle:MyTextureBundle = new MyTextureBundle();
		var particleBundle:GameParticleBundle = new GameParticleBundle();
		var myParticle:PDParticleSystem = particleBundle.buildParticle("myParticle", textureBundle.getTexture("particleTexture"));
	}
 }
	 *************************************************************************************
	 *  </listing> */	
	public class ParticleBundle implements IAssetBundle
	{
		/** @private */
		protected static const thread:GreenThread = new GreenThread();
		
		/** @private */
		firefly_internal var loaders:Dictionary;
		/** @private */
		firefly_internal var particleXmls:Dictionary;
		/** @private */
		firefly_internal var particles:Dictionary;
		
		/** @private */
		private var _name:String;
		/** @private */
		private var _loaded:Boolean;
		
		/** @private */
		protected var _singleton:ParticleBundle;
		
		/** Constructor. */
		public function ParticleBundle()
		{
			this._name = getQualifiedClassName(this);
			this._singleton = SingletonLocator.getInstance(getDefinitionByName(_name) as Class, this);
			
			if(_singleton == this)
			{
				loaders = new Dictionary();
				particleXmls = new Dictionary();
				particles = new Dictionary();
				regParticles();
			}
		}
		
		/** Unique name of bundle. */
		public function get name():String { return _name; }
		
		/** Register particles. This method calls after creation of the particle bundle. */
		protected function regParticles():void { }
		
		/** Register particle xml/pex for loading.
		 *
		 *  @param id Unique identifier of the loader.
		 *  @param path Path to the xml file.
		 *  @param autoScale Specifies whether use autoscale algorithm. Based on design size and stage size texture will be 
		 * 		   proportionally scale to stage size. E.g. design size is 1024x768 and stage size is 800x600 the formula is
		 * 		   <code>var scale:Number = Math.min(1024/800, 768/600);</code></br> 
		 * 		   Calculated scale is 1.28 and all bitmaps scale based on it. */
		protected function regParticleXML(id:String, path:String, autoScale:Boolean = true):void
		{
			if(_singleton != this)
				return _singleton.regParticleXML(id, path, autoScale);
			
			if(!(id in loaders))
				loaders[id] = new ParticleXMLLoader(id, path, autoScale);
		}
		
		/** Return particle xml by unique identifier.
		 *  @param id Unique identifier of the xml.
		 *  @return Particle xml stored in the bundle. */
		public function getParticleXML(id:String):XML
		{
			if(_singleton != this)
				return _singleton.getParticleXML(id);
			
			if(id in particleXmls)
				return particleXmls[id];
			
			CONFIG::debug {
				Log.error("Particle xml {0} is not found.", id);
			};
			
			return null;
		}
		
		/** Return particle by unique identifier.
		 *  @param id Unique identifier of the particle.
		 *  @return Particle stored in the bundle. */
		public function getParticle(id:String):PDParticleSystem
		{
			if(_singleton != this)
				return _singleton.getParticle(id);
			
			if(id in particles)
				return particles[id];
			
			CONFIG::debug {
				Log.error("Particle {0} is not found.", id);
			};
			
			return null;
		}
		
		/** Load particle data asynchronously.
		 *  @return Future object for callback. */
		public function load():Future
		{
			if(_singleton != this)
				return _singleton.load();
			
			if(!_loaded)
			{
				var group:GroupCompleter = new GroupCompleter();
				for each (var loader:XMLLoader in loaders) 
				{
					var completer:Completer = new Completer();
					
					thread.schedule(loader.load).then(onParticleLoaded, loader, completer);
					group.append(completer.future);
				}
				
				_loaded = true;
				
				return group.future;
			}
			return Future.nextFrame();
		}
		
		/** @private */		
		private function onParticleLoaded(loader:XMLLoader, completer:Completer):void
		{
			loader.build(this);
			loader.unload();
			
			completer.complete();
		}
		
		/** Release paricle data from RAM. */		
		public function unload():void
		{
			if(_singleton != this)
				return _singleton.unload();
			
			_loaded = false;
		}
		
		/** Create and store particle using loaded xml file and bitmap texture from the param.
		 * 	The identifier should be the same as registered particle xml.
		 * 	@param id Unique identifier of the particle.
		 * 	@param texture Bitmap texture of the particle.
		 *  @return Created particle. */		
		public function buildParticle(id:String, texture:Texture):PDParticleSystem
		{
			if(_singleton != this)
				return _singleton.buildParticle(id, texture);
			
			var xml:XML;
			if(id in particleXmls)
				xml = particleXmls[id];
			
			CONFIG::debug {
				if (!xml)
					Log.error("Particle xml {0} is not found.", id);
			};
			
			var particle:PDParticleSystem = new PDParticleSystem(xml, texture);
			particles[id] = particle;
			
			return particle;
		}
		
		/** @private
		 *  Save particle xml in particle bundle.
		 * 	@param id Unique identifier of the particle xml.
		 *  @param xml XML data for particle creation. **/
		firefly_internal function addParticleXML(id:String, xml:XML):void
		{
			if (!(id in particleXmls))
				particleXmls[id] = xml;
		}
	}
}