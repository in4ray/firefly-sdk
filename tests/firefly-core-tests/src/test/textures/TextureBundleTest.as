package test.textures
{
	import com.firefly.core.Firefly;
	import com.firefly.core.firefly_internal;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import starling.textures.Texture;
	
	import test.asset.helpers.MenuTextures;
	import test.textures.helpers.ScaleTextureBundle;
	import test.textures.helpers.TextureAtlasesBundle;
	
	use namespace firefly_internal;
	
	public class TextureBundleTest extends EventDispatcher
	{
		private var _textureBundle:MenuTextures;
		private var _scTextureBundle:ScaleTextureBundle;
		private var _textureAtlasesBundle:TextureAtlasesBundle;
		
		[Before]
		public function prepareBitmapLoader() : void 
		{
			_textureBundle = new MenuTextures();
			_scTextureBundle = new ScaleTextureBundle();
			_textureAtlasesBundle = new TextureAtlasesBundle();
		}
		
		[Test(async, timeout="1000")]
		public function loadAndCheckFXGTexture() : void 
		{
			_textureBundle.load().then(function():void
			{
				Assert.assertNotNull(_textureBundle.background);	
				
				dispatchEvent(new Event(Event.COMPLETE));
			});
			
			// wait for completion
			Async.handleEvent(this, this, Event.COMPLETE, function():void{}, 1000);
		}
		
		[Test(async, timeout="1000")]
		public function loadAndCheckBitmapTexture() : void 
		{
			_textureBundle.load().then(function():void
			{
				Assert.assertNotNull(_textureBundle.bitmapTexture);	
				
				dispatchEvent(new Event(Event.COMPLETE));
			});
			
			// wait for completion
			Async.handleEvent(this, this, Event.COMPLETE, function():void{}, 1000);
		}
		
		[Test(async, timeout="1000")]
		public function loadAndCheckATFTexture() : void 
		{
			_textureBundle.load().then(function():void
			{
				Assert.assertNotNull(_textureBundle.atfTexture);	
				
				dispatchEvent(new Event(Event.COMPLETE));
			});
			
			// wait for completion
			Async.handleEvent(this, this, Event.COMPLETE, function():void{}, 1000);
		}
		
		[Test(async, timeout="1000")]
		public function loadAndCheckSWFTexture() : void 
		{
			_textureBundle.load().then(function():void
			{
				Assert.assertNotNull(_textureBundle.swfTexture);	
				
				dispatchEvent(new Event(Event.COMPLETE));
			});
			
			// wait for completion
			Async.handleEvent(this, this, Event.COMPLETE, function():void{}, 1000);
		}
		
		[Test(async, timeout="1000")]
		public function loadAndCheckDragonBonesFactory() : void 
		{
			_textureBundle.load().then(function():void
			{
				Assert.assertNotNull(_textureBundle.dbFactory);	
				
				dispatchEvent(new Event(Event.COMPLETE));
			});
			
			// wait for completion
			Async.handleEvent(this, this, Event.COMPLETE, function():void{}, 1000);
		}
		
		[Test(async, timeout="1000")]
		public function checkAutoscaleTexture() : void 
		{
			var oldScale:Number = Firefly.current._textureScale;
			Firefly.current._textureScale = 1.5;
			
			_scTextureBundle.load().then(function():void
			{
				var texture:Texture = _scTextureBundle.bitmapTexture;
				Assert.assertTrue(texture.width == 102);	
				Assert.assertTrue(texture.height == 73);	
				
				Firefly.current._textureScale = oldScale;
				
				dispatchEvent(new Event(Event.COMPLETE));
			});
			
			// wait for completion
			Async.handleEvent(this, this, Event.COMPLETE, function():void{}, 1000);
		}
		
		
		[Test(async, timeout="1000")]
		public function loadAndCheckBitmapTextureAtlas() : void 
		{
			_textureAtlasesBundle.load().then(function():void
			{
				Assert.assertNotNull(_textureAtlasesBundle.bitmapTextureAtlas);	
				
				dispatchEvent(new Event(Event.COMPLETE));
			});
			
			// wait for completion
			Async.handleEvent(this, this, Event.COMPLETE, function():void{}, 1000);
		}
		
		[Test(async, timeout="1000")]
		public function loadAndCheckATFTextureAtlas() : void 
		{
			_textureAtlasesBundle.load().then(function():void
			{
				Assert.assertNotNull(_textureAtlasesBundle.atfTextureAtlas);	
				
				dispatchEvent(new Event(Event.COMPLETE));
			});
			
			// wait for completion
			Async.handleEvent(this, this, Event.COMPLETE, function():void{}, 1000);
		}
		
		[Test(async, timeout="1000")]
		public function loadAndCheckFXGTextureAtlas() : void 
		{
			_textureAtlasesBundle.load().then(function():void
			{
				Assert.assertNotNull(_textureAtlasesBundle.fxgTextureAtlas);	
				
				dispatchEvent(new Event(Event.COMPLETE));
			});
			
			// wait for completion
			Async.handleEvent(this, this, Event.COMPLETE, function():void{}, 1000);
		}
	}
}