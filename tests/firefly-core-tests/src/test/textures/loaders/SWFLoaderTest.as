package test.textures.loaders
{
	import com.firefly.core.firefly_internal;
	import com.firefly.core.textures.loaders.SWFLoader;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	use namespace firefly_internal;
	
	public class SWFLoaderTest extends EventDispatcher
	{
		private var _swfLoader:com.firefly.core.textures.loaders.SWFLoader;
		
		[Before]
		public function prepareSWFLoader() : void 
		{
			_swfLoader = new SWFLoader("swfTexture", "../textures/TestSWF.swf");
		}
		
		[Test(async, timeout="1000")]
		public function loadSWFTexture() : void 
		{
			_swfLoader.load().then(function():void
			{
				Assert.assertNotNull(_swfLoader.bitmapDatas);	
			
				dispatchEvent(new Event(Event.COMPLETE));
			});
			
			// wait for completion
			Async.handleEvent(this, this, Event.COMPLETE, function():void{}, 1000);
		}
		
		[Test(async, timeout="1000")]
		public function checkLength() : void 
		{
			_swfLoader.load().then(function():void
			{
				Assert.assertTrue(_swfLoader.bitmapDatas.length = 1);	
				
				dispatchEvent(new Event(Event.COMPLETE));
			});
			
			// wait for completion
			Async.handleEvent(this, this, Event.COMPLETE, function():void{}, 1000);
		}
		
		[Test(async, timeout="1000")]
		public function releaseLoadedData() : void 
		{
			_swfLoader.load().then(function():void
			{
				_swfLoader.unload();
				
				Assert.assertNull(_swfLoader.bitmapDatas);	
				
				dispatchEvent(new Event(Event.COMPLETE));
			});
			
			// wait for completion
			Async.handleEvent(this, this, Event.COMPLETE, function():void{}, 1000);
		}
	}
}