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
	 * Global function that returns "right" layout constraint. (similar to Flex right constraint).
	 * 
	 * @param value Layout value
	 * @return Layout constraint. 
	 */	
	public function $right(value:Number):ILayoutUnits
	{
		return new LayoutRight(value, $right);
	}
}

import com.in4ray.gaming.consts.LayoutOrder;
import com.in4ray.gaming.layouts.LayoutBase;
import com.in4ray.gaming.layouts.LayoutTarget;
import com.in4ray.gaming.layouts.context.ILayoutContext;


class LayoutRight extends com.in4ray.gaming.layouts.LayoutBase
{
	public function LayoutRight(value:Number, globalFunc:Function)
	{
		super(value, globalFunc);	
	}
	
	override public function getOrder():uint
	{
		return LayoutOrder.SECOND_CONSTRAINS;
	}
	
	override public function layout(context:ILayoutContext, target:LayoutTarget, targetContext:ILayoutContext):void
	{
		if(!target.xChanged)
			target.setX(context.width - context.getValueWidth(this) - target.width);
		else
			target.setWidth(context.width - context.getValueX(this) - target.x);
	}
}
