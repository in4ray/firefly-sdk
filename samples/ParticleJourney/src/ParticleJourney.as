package
{
	import com.firefly.core.components.GameApp;
	import com.in4ray.particle.journey.screens.MainScreen;
	
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.utils.setTimeout;
	
	import starling.core.Starling;
	
	
	public class ParticleJourney extends GameApp
	{
		private var starling:Starling;
		
		public function ParticleJourney()
		{
			super();
			
			//setGlobalLayoutContext(1152, 1536);
			setGlobalLayoutContext(768, 1360);
		
			setTimeout(init, 1000);
		}
		
		
		protected function init():void
		{
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