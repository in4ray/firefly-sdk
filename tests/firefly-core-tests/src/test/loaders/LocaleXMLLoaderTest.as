package test.loaders
{
	import com.firefly.core.assets.loaders.LocaleXMLLoader;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;

	public class LocaleXMLLoaderTest extends EventDispatcher
	{
		private var _xmlLoader:LocaleXMLLoader;
		
		[Before]
		public function prepareXMLLoader() : void 
		{
			_xmlLoader = new LocaleXMLLoader("ua", "../locale/ua.xml");
		}
		
		[Test(async, timeout="1000")]
		public function loadLocaleXML() : void 
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
				_xmlLoader.release();
				
				Assert.assertNull(_xmlLoader.xml);	
				
				dispatchEvent(new Event(Event.COMPLETE));
			});
			
			// wait for completion
			Async.handleEvent(this, this, Event.COMPLETE, function():void{}, 1000);
		}
	}
}