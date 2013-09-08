package test.textures.loaders
{
	import com.firefly.core.firefly_internal;
	import com.firefly.core.textures.loaders.AtlasBitmapLoader;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	use namespace firefly_internal;
	
	public class AtlasBitmapLoaderTest extends EventDispatcher
	{
		private var _atlasLoader:com.firefly.core.textures.loaders.AtlasBitmapLoader;
		
		[Before]
		public function prepareSWFLoader() : void 
		{
			_atlasLoader = new AtlasBitmapLoader("atlasTexture", "../textures/game_sprites.png", "../textures/game_sprites.xml");
		}
		
		[Test(async, timeout="1000")]
		public function loadBitmapTextureAtlas() : void 
		{
			_atlasLoader.load().then(function():void
			{
				Assert.assertNotNull(_atlasLoader.bitmapLoader.bitmapData);	
				Assert.assertNotNull(_atlasLoader.xmlLoader.xml);	
				
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
				
				Assert.assertNull(_atlasLoader.bitmapLoader);	
				Assert.assertNull(_atlasLoader.xmlLoader);	
				
				dispatchEvent(new Event(Event.COMPLETE));
			});
			
			// wait for completion
			Async.handleEvent(this, this, Event.COMPLETE, function():void{}, 1000);
		}
	}
}