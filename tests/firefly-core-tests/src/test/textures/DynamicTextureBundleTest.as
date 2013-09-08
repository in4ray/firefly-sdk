package test.textures
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import test.textures.helpers.DynamicGameTextureBundle;

	public class DynamicTextureBundleTest extends EventDispatcher
	{
		private var _dynamicTextureBundle:DynamicGameTextureBundle;
		
		[Before]
		public function prepareBitmapLoader() : void 
		{
			_dynamicTextureBundle = new DynamicGameTextureBundle();
		}
		
		[Test(async, timeout="1000")]
		public function loadAndCheckDynamicTextureAtlas() : void 
		{
			_dynamicTextureBundle.load().then(function():void
			{
				Assert.assertNotNull(_dynamicTextureBundle.bitmapTexture);	
				Assert.assertNotNull(_dynamicTextureBundle.gameName);	
				Assert.assertNotNull(_dynamicTextureBundle.companyLogo);	
				Assert.assertNotNull(_dynamicTextureBundle.menuBackground);	
				
				dispatchEvent(new Event(Event.COMPLETE));
			});
			
			// wait for completion
			Async.handleEvent(this, this, Event.COMPLETE, function():void{}, 1000);
		}
	}
}