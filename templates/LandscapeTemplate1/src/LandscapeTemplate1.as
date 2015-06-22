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
import com.in4ray.particle.journey.model.Model;
import com.in4ray.particle.journey.splash.CompanySplash;
import com.in4ray.particle.journey.splash.FireflySplash;
import com.in4ray.particle.journey.screens.MainScreen;

import starling.core.Starling;
import starling.utils.VAlign;
	
	[SWF(frameRate="60")]
	public class LandscapeTemplate1 extends GameApp
	{
		private var starling:Starling;
		
		public function LandscapeTemplate1()
		{
			super(CompanySplash);
			
			setGlobalLayoutContext(1024, 768, VAlign.CENTER);
			
			regNavigator(MainScreen);
			regModel(new Model());
			regSplash(new FireflySplash(), 2);
		}
		
		override protected function init():void
		{
			super.init();
			
			Starling.current.showStats = true;
		}
	}
}