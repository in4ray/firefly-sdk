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
	 * Global function that returns "bottom" layout constraint. (similar to Flex bottom constraint).
	 * 
	 * @param value Layout value
	 * @return Layout constraint. 
	 */	
	public function $bottom(value:Number):ILayoutUnits
	{
		return new LayoutBottom(value, $bottom);
	}
}
import com.in4ray.gaming.consts.LayoutOrder;
import com.in4ray.gaming.layouts.LayoutBase;
import com.in4ray.gaming.layouts.LayoutTarget;
import com.in4ray.gaming.layouts.context.ILayoutContext;


class LayoutBottom extends com.in4ray.gaming.layouts.LayoutBase
{
	public function LayoutBottom(value:Number, globalFunc:Function)
	{
		super(value, globalFunc);	
	}
	
	override public function getOrder():uint
	{
		return LayoutOrder.SECOND_CONSTRAINS;
	}
	
	override public function layout(context:ILayoutContext, target:LayoutTarget):void
	{
		if(!target.yChanged)
			target.setY(context.height - context.getValueHeight(this) - target.height);
		else
			target.setHeight(context.height - context.getValueY(this) - target.y);
	}
}