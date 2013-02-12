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
	 * Global function that returns layout constraint that sets position by X-Axis for target.
	 * 
	 * @param value Layout value
	 * @return Layout constraint. 
	 */
	public function $x(value:Number):ILayoutUnits
	{
		return new LayoutX(value, $x);
	}
}

import com.in4ray.gaming.consts.LayoutOrder;
import com.in4ray.gaming.layouts.ILayoutUnits;
import com.in4ray.gaming.layouts.LayoutBase;
import com.in4ray.gaming.layouts.LayoutTarget;
import com.in4ray.gaming.layouts.context.ILayoutContext;


class LayoutX extends LayoutBase
{
	public function LayoutX(value:Number, globalFunc:Function):void
	{
		super(value, globalFunc);
	}
	
	override public function getOrder():uint
	{
		return LayoutOrder.POSITION;
	}
	
	override public function layout(context:ILayoutContext, target:LayoutTarget):void
	{
		target.setX(context.getValueX(this));
	}
}