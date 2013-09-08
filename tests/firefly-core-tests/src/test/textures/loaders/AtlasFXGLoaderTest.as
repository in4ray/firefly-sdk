package test.textures.loaders
{
	import com.firefly.core.firefly_internal;
	import com.firefly.core.textures.loaders.AtlasFXGLoader;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import textures.TestFXG;
	
	use namespace firefly_internal;
	
	public class AtlasFXGLoaderTest extends EventDispatcher
	{
		private var _atlasLoader:com.firefly.core.textures.loaders.AtlasFXGLoader;
		
		[Before]
		public function prepareSWFLoader() : void 
		{
			_atlasLoader = new AtlasFXGLoader(TestFXG);
		}
		
		[Test(async, timeout="1000")]
		public function loadFXGTextureAtlas() : void 
		{
			_atlasLoader.load().then(function():void
			{
				Assert.assertNotNull(_atlasLoader.bitmapData);	
				
				dispatchEvent(new Event(Event.COMPLETE));
			});
			
			// wait for completion
			Async.handleEvent(this, this, Event.COMPLETE, function():void{}, 1000);
		}
		
		[Test(async, timeout="1000")]
		public function releaseLoadedData() : void 
		{
			_atlasLoader.load().then(function():void
			{
				_atlasLoader.release();
				
				Assert.assertNull(_atlasLoader.bitmapData);	
				
				dispatchEvent(new Event(Event.COMPLETE));
			});
			
			// wait for completion
			Async.handleEvent(this, this, Event.COMPLETE, function():void{}, 1000);
		}
	}
}