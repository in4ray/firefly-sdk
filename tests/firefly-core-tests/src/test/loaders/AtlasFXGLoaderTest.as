package test.loaders
{
	import com.firefly.core.firefly_internal;
	import com.firefly.core.assets.loaders.textures.atlases.AtlasFXGLoader;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import org.flexunit.async.Async;
	
	import test.bundles.helpers.FakeTextureBundle;
	
	import textures.TestFXG;
	
	use namespace firefly_internal;
	
	public class AtlasFXGLoaderTest extends EventDispatcher
	{
		private var _atlasLoader:AtlasFXGLoader;
		
		[Before]
		public function prepareSWFLoader() : void 
		{
			_atlasLoader = new AtlasFXGLoader("Test", [TestFXG], "../textures/TestFXG.xml");
		}
		
		[Test(async, timeout="1000")]
		public function loadFXGTextureAtlas() : void 
		{
			_atlasLoader.load().then(function():void
			{
				_atlasLoader.build(new FakeTextureBundle());
				
				dispatchEvent(new Event(Event.COMPLETE));
			});
			
			// wait for completion
			Async.handleEvent(this, this, Event.COMPLETE, function():void{}, 1000);
		}
	}
}