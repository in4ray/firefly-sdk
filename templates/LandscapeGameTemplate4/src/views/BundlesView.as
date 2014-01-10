package views
{
	import com.in4ray.gaming.components.Button;
	import com.in4ray.gaming.components.NavigationMap;
	import com.in4ray.gaming.components.Quad;
	import com.in4ray.gaming.components.Sprite;
	import com.in4ray.gaming.components.renderers.DataRenderer;
	import com.in4ray.gaming.events.NavigationMapEvent;
	import com.in4ray.gaming.events.ViewStateEvent;
	import com.in4ray.gaming.layouts.$bottom;
	import com.in4ray.gaming.layouts.$height;
	import com.in4ray.gaming.layouts.$left;
	import com.in4ray.gaming.layouts.$width;
	import com.in4ray.gaming.utils.ClassFactory;
	
	import consts.ViewStates;
	
	import layouts.BundlesTemplate;
	
	import model.GameModel;
	
	import sounds.SoundBundle;
	
	import starling.events.Event;
	
	import testures.MenuTextures;
	
	import views.components.BundleItemRenderer;
	
	public class BundlesView extends Sprite
	{
		private var map:NavigationMap;
		private var gameModel:GameModel;
		private var textureBundle:MenuTextures;
		
		public function BundlesView()
		{
			super();
			
			gameModel = GameModel.getInstance();
			
			textureBundle = new MenuTextures();
			
			// Background
			addElement(new Quad(0x555555), $width(100).pct, $height(100).pct);
			
			// Levels
			map = new NavigationMap();
			map.screenWidth = layoutContext.getValueWidth($width(440).rcpx);
			map.numScreens = gameModel.bundles.length;// Number of screens equals number of levels
			map.duration = 500;
			map.sensitivity = 20;
			addElement(map, $width(100).pct, $height(100).pct);
			map.addEventListener(NavigationMapEvent.SCREEN_MOVING, screenHandler);
			map.addEventListener(NavigationMapEvent.SCREEN_CHANGING, screenHandler);
			
			// Levels renderers
			var dataRenderer:DataRenderer = new DataRenderer(new BundlesTemplate(map));
			dataRenderer.itemRenderer = new ClassFactory(BundleItemRenderer);
			dataRenderer.dataProvider = gameModel.bundles;
			
			// Back
			var backBtn:Button = new Button(textureBundle.backUpButton, "", textureBundle.backDownButton, new SoundBundle().click);
			backBtn.addEventListener(Event.TRIGGERED, backHandler);
			addElement(backBtn, $left(20).rcpx, $bottom(20).rcpx);
		}
		
		private function backHandler(e:Event):void
		{
			dispatchEvent(new ViewStateEvent(ViewStateEvent.SWITCH_TO_STATE, ViewStates.MENU));
		}
		
		private function screenHandler(event:NavigationMapEvent):void
		{
			for (var i:int = 0; i < map.numChildren; i++) 
			{
				var renderer:BundleItemRenderer = map.getChildAt(i) as BundleItemRenderer;
				if(renderer)
					renderer.enabled = (event.type != NavigationMapEvent.SCREEN_MOVING);
			}
		}
	}
}