package test.textures.loaders
{
	import com.firefly.core.firefly_internal;
	import com.firefly.core.textures.loaders.FontXMLLoader;
	import com.firefly.core.textures.loaders.atlases.AtlasXMLLoader;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	use namespace firefly_internal;
	
	public class FontXMLLoaderTest extends EventDispatcher
	{
		private var _xmlLoader:FontXMLLoader;
		
		[Before]
		public function prepareXMLLoader() : void 
		{
			_xmlLoader = new FontXMLLoader("xml", "../textures/game_sprites.xml");
		}
		
		[Test(async, timeout="1000")]
		public function loadAtlasXML() : void 
		{
			_xmlLoader.load().then(function():void
			{
				Assert.assertNotNull(_xmlLoader.xml);	
				
				dispatchEvent(new Event(Event.COMPLETE));
			});
			
			// wait for completion
			Async.handleEvent(this, this, Event.COMPLETE, function():void{}, 1000);
		}
		
		[Test(async, timeout="1000")]
		public function releaseLoadedData() : void 
		{
			_xmlLoader.load().then(function():void
			{
				_xmlLoader.unload();
				
				Assert.assertNull(_xmlLoader.xml);	
				
				dispatchEvent(new Event(Event.COMPLETE));
			});
			
			// wait for completion
			Async.handleEvent(this, this, Event.COMPLETE, function():void{}, 1000);
		}
	}
}