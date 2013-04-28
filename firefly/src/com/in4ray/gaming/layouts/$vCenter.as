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
	 * Global function that returns "verticalCenter" layout constraint. (similar to Flex verticalCenter constraint).
	 * 
	 * @param value Layout value
	 * @return Layout constraint. 
	 */	
	public function $vCenter(value:Number):ILayoutUnits
	{
		return new LayoutVCenter(value, $vCenter);
	}
}

import com.in4ray.gaming.consts.LayoutOrder;
import com.in4ray.gaming.layouts.LayoutBase;
import com.in4ray.gaming.layouts.LayoutTarget;
import com.in4ray.gaming.layouts.context.ILayoutContext;

class LayoutVCenter extends com.in4ray.gaming.layouts.LayoutBase
{
	public function LayoutVCenter(value:Number, globalFunc:Function)
	{
		super(value, globalFunc);	
	}
	
	override public function getOrder():uint
	{
		return LayoutOrder.THIRD_CONSTRAINS;
	}
	
	override public function layout(context:ILayoutContext, target:LayoutTarget, targetContext:ILayoutContext):void
	{
		target.setY(context.getValueY(this) + (context.height - target.height)/2 + target.pivotY);
	}
}