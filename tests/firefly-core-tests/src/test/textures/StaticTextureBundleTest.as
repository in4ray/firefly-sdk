package test.textures
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import test.textures.helpers.TextureAtlasesBundle;
	
	public class StaticTextureBundleTest extends EventDispatcher
	{
		private var _staticTextureBundle:TextureAtlasesBundle;
		
		[Before]
		public function prepareBitmapLoader() : void 
		{
			_staticTextureBundle = new TextureAtlasesBundle();
		}
		
		[Test(async, timeout="1000")]
		public function loadAndCheckBitmapTextureAtlas() : void 
		{
			_staticTextureBundle.load().then(function():void
			{
				Assert.assertNotNull(_staticTextureBundle.bitmapTextureAtlas);	
				
				dispatchEvent(new Event(Event.COMPLETE));
			});
			
			// wait for completion
			Async.handleEvent(this, this, Event.COMPLETE, function():void{}, 1000);
		}
		
		[Test(async, timeout="1000")]
		public function loadAndCheckATFTextureAtlas() : void 
		{
			_staticTextureBundle.load().then(function():void
			{
				Assert.assertNotNull(_staticTextureBundle.atfTextureAtlas);	
				
				dispatchEvent(new Event(Event.COMPLETE));
			});
			
			// wait for completion
			Async.handleEvent(this, this, Event.COMPLETE, function():void{}, 1000);
		}
		
		[Test(async, timeout="1000")]
		public function loadAndCheckFXGTextureAtlas() : void 
		{
			_staticTextureBundle.load().then(function():void
			{
				Assert.assertNotNull(_staticTextureBundle.fxgTextureAtlas);	
				
				dispatchEvent(new Event(Event.COMPLETE));
			});
			
			// wait for completion
			Async.handleEvent(this, this, Event.COMPLETE, function():void{}, 1000);
		}
	}
}