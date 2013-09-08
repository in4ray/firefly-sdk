package test.textures.loaders
{
	import com.firefly.core.firefly_internal;
	import com.firefly.core.textures.loaders.ATFLoader;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	use namespace firefly_internal;
	
	public class ATFLoaderTest extends EventDispatcher
	{
		private var _atfLoader:com.firefly.core.textures.loaders.ATFLoader;
		
		[Before]
		public function prepareATFLoader() : void 
		{
			_atfLoader = new ATFLoader("atfTexture", "../textures/atf_texture.atf");
		}
		
		[Test(async, timeout="1000")]
		public function loadATFTexture() : void 
		{
			_atfLoader.load().then(function():void
			{
				Assert.assertNotNull(_atfLoader.data);	
				
				dispatchEvent(new Event(Event.COMPLETE));
			});
			
			// wait for completion
			Async.handleEvent(this, this, Event.COMPLETE, function():void{}, 1000);
		}
		
		[Test(async, timeout="1000")]
		public function releaseLoadedData() : void 
		{
			_atfLoader.load().then(function():void
			{
				_atfLoader.release();
				
				Assert.assertNull(_atfLoader.data);	
				
				dispatchEvent(new Event(Event.COMPLETE));
			});
			
			// wait for completion
			Async.handleEvent(this, this, Event.COMPLETE, function():void{}, 1000);
		}
	}
}