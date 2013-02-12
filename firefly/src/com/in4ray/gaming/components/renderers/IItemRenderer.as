// =================================================================================================
//
//	in4ray Gaming SDK
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.in4ray.gaming.components.renderers
{
	import com.in4ray.gaming.components.IVisualElement;

	/**
	 *  Interface for item renderers.
	 */	
	public interface IItemRenderer extends IVisualElement
	{
		/**
		 * Draw UI for item data.
		 * 
		 * @param data Data item object
		 */		
		function prepare(data:Object):void
			
		/**
		 * Renderer is released and goes to recycle queue. 
		 */			
		function release():void
	}
}