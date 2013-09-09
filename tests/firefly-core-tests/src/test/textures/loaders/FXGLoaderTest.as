package test.textures.loaders
{
	import com.firefly.core.firefly_internal;
	import com.firefly.core.textures.loaders.FXGLoader;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import textures.MenuBackground;
	
	use namespace firefly_internal;
	
	public class FXGLoaderTest extends EventDispatcher
	{
		private var _fxgLoader:com.firefly.core.textures.loaders.FXGLoader;
		
		[Before]
		public function prepareFXGLoader() : void 
		{
			_fxgLoader = new FXGLoader(MenuBackground);
		}
		
		[Test(async, timeout="1000")]
		public function loadFXGTexture() : void 
		{
			_fxgLoader.load().then(function():void
			{
				Assert.assertNotNull(_fxgLoader.bitmapData);	
				
				dispatchEvent(new Event(Event.COMPLETE));
			});
			
			// wait for completion
			Async.handleEvent(this, this, Event.COMPLETE, function():void{}, 1000);
		}
		
		[Test(async, timeout="1000")]
		public function releaseLoadedData() : void 
		{
			_fxgLoader.load().then(function():void
			{
				_fxgLoader.unload();
				
				Assert.assertNull(_fxgLoader.bitmapData);	
				
				dispatchEvent(new Event(Event.COMPLETE));
			});
			
			// wait for completion
			Async.handleEvent(this, this, Event.COMPLETE, function():void{}, 1000);
		}
	}
}