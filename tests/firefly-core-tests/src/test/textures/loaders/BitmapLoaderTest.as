package test.textures.loaders
{
	import com.firefly.core.firefly_internal;
	import com.firefly.core.textures.loaders.BitmapLoader;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	use namespace firefly_internal;
	
	public class BitmapLoaderTest extends EventDispatcher
	{
		private var _bitmapLoader:com.firefly.core.textures.loaders.BitmapLoader;
		
		[Before]
		public function prepareBitmapLoader() : void 
		{
			_bitmapLoader = new BitmapLoader("bitmapTexture", "../textures/bitmap_texture.png");
		}
		
		[Test(async, timeout="1000")]
		public function loadBitmapDataTexture() : void 
		{
			_bitmapLoader.load().then(function():void
			{
				Assert.assertNotNull(_bitmapLoader.bitmapData);	
				
				dispatchEvent(new Event(Event.COMPLETE));
			});
			
			// wait for completion
			Async.handleEvent(this, this, Event.COMPLETE, function():void{}, 1000);
		}
		
		[Test(async, timeout="1000")]
		public function releaseLoadedData() : void 
		{
			_bitmapLoader.load().then(function():void
			{
				_bitmapLoader.unload();
				
				Assert.assertNull(_bitmapLoader.bitmapData);	
				
				dispatchEvent(new Event(Event.COMPLETE));
			});
			
			// wait for completion
			Async.handleEvent(this, this, Event.COMPLETE, function():void{}, 1000);
		}
	}
}