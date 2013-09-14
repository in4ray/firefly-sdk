// =================================================================================================
//
//	in4ray Gaming SDK
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.in4ray.gaming.navigation
{
	import com.firefly.core.assets.AssetState;
	import com.in4ray.gaming.components.Sprite;
	import com.in4ray.gaming.consts.CreationPolicy;
	import com.in4ray.gaming.layouts.$height;
	import com.in4ray.gaming.layouts.$width;

	[ExcludeClass]
	/**
	 * View state value object 
	 */	
	public class ViewState
	{	
		public function ViewState(viewClass:Class = null, popUp:Boolean = false, name:String = "", assetState:AssetState = null, creaionPolicy:String = CreationPolicy.ONDEMAND)
		{
			this.popUp = popUp;
			this.name = name;
			this.creaionPolicy = creaionPolicy;
			this.assetState = assetState;
			this.viewClass = viewClass;
			
			if(creaionPolicy == CreationPolicy.INIT)
				getView();
		}
		
		public var viewClass:Class;
		public var assetState:AssetState;
		private var view:Sprite;
		public var creaionPolicy:String;
		public var name:String;
		public var popUp:Boolean;
		
		public function getView():Sprite
		{
			var viewInstance:Sprite;
			
			if(!view)
			{
				viewInstance = new viewClass();
				if(viewInstance.getLayouts().length == 0)
					viewInstance.addLayout($width(100).pct, $height(100).pct);
				
				if(creaionPolicy != CreationPolicy.NOCACHE)
					view = viewInstance;
			}
			else
			{
				viewInstance = view;
			}
			
			return viewInstance;
		}
	}
}