// =================================================================================================
//
//	Firefly Framework
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package
{
import com.firefly.core.components.GameApp;
import com.in4ray.particle.journey.GameModel;
	import com.in4ray.particle.journey.components.CompanySplash;
	import com.in4ray.particle.journey.components.FireflySplash;
	import com.in4ray.particle.journey.screens.MainScreen;
	
	import starling.core.Starling;
	import starling.utils.VAlign;
	
	public class ParticleJourney extends GameApp
	{
		private var starling:Starling;
		
		public function ParticleJourney()
		{
			super(CompanySplash);
			
			setGlobalLayoutContext(768, 1360, VAlign.TOP);
			
			regNavigator(MainScreen);
			regModel(new GameModel("ParticleJourney"));
			regSplash(new FireflySplash(), 2);
		}
		
		override protected function init():void
		{
			super.init();
			
			Starling.current.showStats = true;
		}
	}
}