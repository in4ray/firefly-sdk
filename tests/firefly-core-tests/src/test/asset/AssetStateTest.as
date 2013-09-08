package test.asset
{
	import com.firefly.core.assets.AssetState;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import test.asset.helpers.CommonTextures;
	import test.asset.helpers.MenuTextures;

	public class AssetStateTest extends EventDispatcher
	{
		private var _state:AssetState;
		
		[Before]
		public function prepareState() : void 
		{
			_state = new AssetState("state", new CommonTextures(), new MenuTextures());
		}
		
		[Test(async, timeout="1000")]
		public function testLoad() : void 
		{
			_state.load().then(function():void
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