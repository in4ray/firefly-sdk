// =================================================================================================
//
//	Zombie: Rising Up
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================
package com.in4ray.games.zombie.risingup.views.splash
{
	import com.in4ray.gaming.components.flash.Splash;
	
	import textures.CompanyLogo;

	public class CompanySplash extends Splash
	{
		public function CompanySplash()
		{
			super();
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			var logo:CompanyLogo = new CompanyLogo();
			logo.setActualSize(100, 100);
			logo.setActualPosition(200, 100);
			addElement(logo);
		}
	}
}