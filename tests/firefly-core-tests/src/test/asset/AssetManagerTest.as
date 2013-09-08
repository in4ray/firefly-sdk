package test.asset
{
	import com.firefly.core.assets.AssetManager;
	import com.firefly.core.assets.AssetState;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import test.asset.helpers.CommonTextures;
	import test.asset.helpers.GameTextures;
	import test.asset.helpers.MenuTextures;

	public class AssetManagerTest extends EventDispatcher
	{
		private var _menuState:AssetState;
		private var _gameState:AssetState;
		private var _manager:AssetManager;
		
		[Before]
		public function prepareState() : void 
		{
			_menuState = new AssetState("MenuState", new CommonTextures(), new MenuTextures());
			_gameState = new AssetState("GameState", new CommonTextures(), new GameTextures());
			
			_manager = new AssetManager(_menuState, _gameState);
		}
		
		[Test(async, timeout="1000")]
		public function switchByState() : void 
		{
			_manager.switchToState(_menuState).then(function():void
			{
				Assert.assertNotNull(new MenuTextures().background);	
				Assert.assertNotNull(new CommonTextures().logo);	
				
				dispatchEvent(new Event(Event.COMPLETE));
			});
			
			// wait for completion
			Async.handleEvent(this, this, Event.COMPLETE, function():void{}, 1000);
		}
		
		[Test(async, timeout="1000")]
		public function switchByStateName() : void 
		{
			_manager.switchToStateName("GameState").then(function():void
			{
				Assert.assertNotNull(new GameTextures().gameName);	
				Assert.assertNotNull(new CommonTextures().logo);	
				
				dispatchEvent(new Event(Event.COMPLETE));
			});
			
			// wait for completion
			Async.handleEvent(this, this, Event.COMPLETE, function():void{}, 1000);
		}
		
		[Test(async, timeout="1000")]
		public function switchByStateIndex() : void 
		{
			_manager.switchToStateIndex(0).then(function():void
			{
				Assert.assertNotNull(new MenuTextures().background);	
				Assert.assertNotNull(new CommonTextures().logo);	
				
				dispatchEvent(new Event(Event.COMPLETE));
			});
			
			// wait for completion
			Async.handleEvent(this, this, Event.COMPLETE, function():void{}, 1000);
		}
	}
}