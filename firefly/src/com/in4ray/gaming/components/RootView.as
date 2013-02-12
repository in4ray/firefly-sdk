// =================================================================================================
//
//	in4ray Gaming SDK
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.in4ray.gaming.components
{
	import com.in4ray.gaming.components.Sprite;
	import com.in4ray.gaming.layouts.context.BasicLayoutContext;
	import com.in4ray.gaming.core.GameGlobals;
	
	[ExcludeClass]
	/**
	 * Used as root container fro Starling. 
	 */	
	public class RootView extends Sprite
	{
		/**
		 * Constructor. 
		 */		
		public function RootView()
		{
			super();
			layoutContext = new BasicLayoutContext(GameGlobals.gameApplication);
		}
	}
}