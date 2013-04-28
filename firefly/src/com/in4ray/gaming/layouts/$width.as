// =================================================================================================
//
//	in4ray Gaming SDK
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.in4ray.gaming.layouts
{
	/**
	 * Global function that returns layout constraint that sets width of target.
	 * 
	 * @param value Layout value
	 * @return Layout constraint. 
	 */
	public function $width(value:Number):ILayoutUnits
	{
		return new LayoutWidth(value, $width);
	}
}

import com.in4ray.gaming.consts.LayoutOrder;
import com.in4ray.gaming.layouts.LayoutBase;
import com.in4ray.gaming.layouts.LayoutTarget;
import com.in4ray.gaming.layouts.context.ILayoutContext;

class LayoutWidth extends com.in4ray.gaming.layouts.LayoutBase
{
	public function LayoutWidth(value:Number, globalFunc:Function)
	{
		super(value, globalFunc);	
	}
	
	override public function getOrder():uint
	{
		return LayoutOrder.SIZE;
	}
	
	override public function layout(context:ILayoutContext, target:LayoutTarget, targetContext:ILayoutContext):void
	{
		target.setWidth(context.getValueWidth(this));
	}
}