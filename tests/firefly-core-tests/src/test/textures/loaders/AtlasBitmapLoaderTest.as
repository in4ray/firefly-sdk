package test.textures.loaders
{
	import com.firefly.core.firefly_internal;
	import com.firefly.core.textures.loaders.atlases.AtlasBitmapLoader;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import test.textures.helpers.FakeTextureBundle;
	
	use namespace firefly_internal;
	
	public class AtlasBitmapLoaderTest extends EventDispatcher
	{
		private var _atlasLoader:AtlasBitmapLoader;
		
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
				_atlasLoader.build(new FakeTextureBundle());
				
				dispatchEvent(new Event(Event.COMPLETE));
			});
			
			// wait for completion
			Async.handleEvent(this, this, Event.COMPLETE, function():void{}, 1000);
		}
	}
}