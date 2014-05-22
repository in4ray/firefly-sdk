package test.textures.loaders
{
	import com.firefly.core.firefly_internal;
	import com.firefly.core.assets.loaders.textures.atlases.AtlasATFLoader;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import org.flexunit.async.Async;
	
	import test.textures.helpers.FakeTextureBundle;
	
	use namespace firefly_internal;
	
	public class AtlasATFLoaderTest extends EventDispatcher
	{
		private var _atlasLoader:AtlasATFLoader;
		
		[Before]
		public function prepareSWFLoader() : void 
		{
			_atlasLoader = new AtlasATFLoader("atlasTexture", "../textures/game_sprites.atf", "../textures/game_sprites.xml");
		}
		
		[Test(async, timeout="1000")]
		public function loadATFTextureAtlas() : void 
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