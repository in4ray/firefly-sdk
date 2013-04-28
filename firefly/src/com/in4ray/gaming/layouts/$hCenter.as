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
	 * Global function that returns "horizontalCenter" layout constraint. (similar to Flex horizontalCenter constraint).
	 * 
	 * @param value Layout value
	 * @return Layout constraint. 
	 */	
	public function $hCenter(value:Number):ILayoutUnits
	{
		return new LayoutHCenter(value, $hCenter);
	}
}

import com.in4ray.gaming.consts.LayoutOrder;
import com.in4ray.gaming.layouts.LayoutBase;
import com.in4ray.gaming.layouts.LayoutTarget;
import com.in4ray.gaming.layouts.context.ILayoutContext;

class LayoutHCenter extends com.in4ray.gaming.layouts.LayoutBase
{
	public function LayoutHCenter(value:Number, globalFunc:Function)
	{
		super(value, globalFunc);	
	}
	
	override public function getOrder():uint
	{
		return LayoutOrder.THIRD_CONSTRAINS;
	}
	
	override public function layout(context:ILayoutContext, target:LayoutTarget, targetContext:ILayoutContext):void
	{
		target.setX(context.getValueX(this) + (context.width - target.width)/2 + target.pivotX);
	}
}