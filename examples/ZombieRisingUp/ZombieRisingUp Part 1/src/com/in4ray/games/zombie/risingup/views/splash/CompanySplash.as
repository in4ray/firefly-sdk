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
	import com.in4ray.gaming.components.flash.TextField;
	
	import flash.text.TextFormat;

	public class CompanySplash extends Splash
	{
		public function CompanySplash()
		{
			super();
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			var logo:TextField = new TextField();
			logo.text = "Logo Splash";
			logo.setActualSize(300, 100);
			logo.setTextFormat(new TextFormat(null, 30));
			addElement(logo);
		}
	}
}