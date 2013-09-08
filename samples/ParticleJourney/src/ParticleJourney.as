package
{
	import com.firefly.core.components.GameApp;
	import com.in4ray.particle.journey.screens.MainScreen;
	
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
			starling  = new Starling(MainScreen, stage, new Rectangle(0,0, stage.stageWidth,stage.stageHeight));
			starling.start();
			Starling.current.showStats = true;
			
		}
	}
}