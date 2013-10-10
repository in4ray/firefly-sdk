package
{
	import com.firefly.core.components.GameApp;
	import com.in4ray.particle.journey.components.CompanySplash;
	import com.in4ray.particle.journey.screens.MainScreen;
	
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import starling.core.Starling;
	
	
	public class ParticleJourney extends GameApp
	{
		private var starling:Starling;
		
		public function ParticleJourney()
		{
			super(CompanySplash);
			
			setGlobalLayoutContext(768, 1360);
			
			//setGlobalLayoutContext(1152, 1536);
			//setTimeout(init, 1000);
		}
		
		override protected function init():void
		{
			super.init();
			
			Starling.handleLostContext = true;
			
			starling  = new Starling(MainScreen, stage, new Rectangle(0,0, stage.stageWidth,stage.stageHeight));
			starling.start();
			
			Starling.current.showStats = true;
			
			NativeApplication.nativeApplication.addEventListener(flash.events.Event.ACTIVATE, activate);
			NativeApplication.nativeApplication.addEventListener(flash.events.Event.DEACTIVATE, deactivate);
		}
		
		private function activate(evetn:flash.events.Event):void
		{
			stage.frameRate = 30;
		}
		
		private function deactivate(evetn:flash.events.Event):void
		{
			stage.frameRate = 1;
		}
	}
}