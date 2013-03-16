package
{
	import com.freshplanet.ane.AirChartboost;
	import com.in4ray.gaming.analytics.GoogleAnalytics;
	import com.in4ray.gaming.analytics.IAnalytics;
	import com.in4ray.gaming.async.callNextFrame;
	import com.in4ray.gaming.components.flash.GameApplication;
	import com.in4ray.gaming.events.StarlingEvent;
	
	import flash.desktop.NativeApplication;
	import flash.desktop.SystemIdleMode;
	
	import consts.AppConsts;
	
	import starling.core.Starling;
	
	import testures.MenuTextures;
	
	import views.MainView;
	import views.splash.CompanySplash;
	import views.splash.GameSplash;
	
	[SWF (frameRate="30"]
	public class LandscapeGameTemplate4 extends GameApplication
	{
		private var gameSplash:GameSplash;
		private var chartBoost:AirChartboost;
		private var analytics:IAnalytics;
		
		public function LandscapeGameTemplate4()
		{
			super();
			
			// Initialize Chartboost (http://chartboost.com)
			chartBoost = AirChartboost.getInstance();
			chartBoost.startSession(AppConsts.CHARTBOOST_APP_ID, AppConsts.CHARTBOOST_SIGNATURE_ID);
			// Cache 'startup' interstitial
			chartBoost.cacheInterstitial("startup");
			
			// Initialize Google Analytics
			analytics = new GoogleAnalytics("Landscape Game Template 4", AppConsts.GA_TRACKER_ID);
			analytics.log("Page", "Init");
			
			// Kepp application always awake when launched
			NativeApplication.nativeApplication.systemIdleMode = SystemIdleMode.KEEP_AWAKE;
			
			// Set textures size. For this particular game it will be:
			// Landscape: 1024 x 768 and 240 dpi
			setDesignSize(1024, 768);
			setDesignDPI(240);
			
			// Initialize company and game splash screens. 
			addSplash(new CompanySplash(), 2000);
			gameSplash = new GameSplash(false);
			addSplash(gameSplash);
			
			addEventListener(StarlingEvent.STARLING_INITIALIZED, starlingInitializedHandler);
		}
		
		/**
		 * Starling initialized event handler.
		 * Place for textures and model registration, fonts loading.
		 */		
		protected function starlingInitializedHandler(event:StarlingEvent):void
		{
			// Show FPS and Memory (only for debug)
			Starling.current.showStats = true;
			
			registerFonts();
			
			// Load textures
			new MenuTextures().loadAsync(textureLoaded);
		}
		
		/**
		 * Texture loaded handler.
		 * Place for navigation to Main View and showing startup advertisement.
		 */		
		protected function textureLoaded():void
		{
			if(chartBoost.hasCachedInterstitial("startup"))
			{
				analytics.log("Page", "Chartboost Startup");
				callNextFrame(chartBoost.showInterstitial, "startup");
			}
			
			setMainView(new MainView());
			readyToRemoveSplash(gameSplash);
		}
		
		private function registerFonts():void
		{
			// Register bitmap fonts
			/*var texture:Texture = Texture.fromBitmap(new FontTexture());
			var xml:XML = XML(new FontXml());
			TextField.registerBitmapFont(new BitmapFont(texture, xml));*/
		}
	}
}

