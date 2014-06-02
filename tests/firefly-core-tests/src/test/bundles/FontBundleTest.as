package test.bundles
{
	import com.firefly.core.firefly_internal;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import starling.textures.Texture;
	
	import test.bundles.helpers.GameFontBundle;
	
	use namespace firefly_internal;
	
	public class FontBundleTest extends EventDispatcher
	{
		private var _fontBundle:GameFontBundle;
		
		[Before]
		public function prepareFontBundle() : void 
		{
			_fontBundle = new GameFontBundle();
		}
		
		[Test(async, timeout="1000")]
		public function loadAndCheckFontXml() : void 
		{
			_fontBundle.load().then(function():void
			{
				Assert.assertNotNull(_fontBundle.getFontXML("font"));	
				
				dispatchEvent(new Event(Event.COMPLETE));
			});
			
			// wait for completion
			Async.handleEvent(this, this, Event.COMPLETE, function():void{}, 1000);
		}
		
		[Test(async, timeout="1000")]
		public function loadAndCheckFont() : void 
		{
			_fontBundle.load().then(function():void
			{
				_fontBundle.buildBitmapFont("font", Texture.empty(100,100));
				Assert.assertNotNull(_fontBundle.getBitmapFont("font"));	
				
				dispatchEvent(new Event(Event.COMPLETE));
			});
			
			// wait for completion
			Async.handleEvent(this, this, Event.COMPLETE, function():void{}, 1000);
		}
	}
}