package test.bundles
{
	import com.firefly.core.firefly_internal;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import starling.textures.Texture;
	
	import test.bundles.helpers.GameParticleBundle;
	
	use namespace firefly_internal;
	
	public class ParticleBundleTest extends EventDispatcher
	{
		private var _particleBundle:GameParticleBundle;
		
		[Before]
		public function prepareParticleBundle() : void 
		{
			_particleBundle = new GameParticleBundle();
		}
		
		[Test(async, timeout="1000")]
		public function loadAndCheckParticleXml() : void 
		{
			_particleBundle.load().then(function():void
			{
				Assert.assertNotNull(_particleBundle.getParticleXML("particle"));	
				
				dispatchEvent(new Event(Event.COMPLETE));
			});
			
			// wait for completion
			Async.handleEvent(this, this, Event.COMPLETE, function():void{}, 1000);
		}
		
		[Test(async, timeout="1000")]
		public function loadAndCheckParticle() : void 
		{
			_particleBundle.load().then(function():void
			{
				_particleBundle.buildParticle("particle", Texture.empty(100,100));
				Assert.assertNotNull(_particleBundle.getParticle("particle"));	
				
				dispatchEvent(new Event(Event.COMPLETE));
			});
			
			// wait for completion
			Async.handleEvent(this, this, Event.COMPLETE, function():void{}, 1000);
		}
	}
}