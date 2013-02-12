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
	 * Global function that returns layout constraint that sets height of target 
	 * and changing width to keep aspect ratio.
	 * 
	 * @param value Layout value
	 * @return Layout constraint. 
	 */
	public function $vRatio(value:Number):ILayoutUnits
	{
		return new LayoutVRatio(value, $vRatio);
	}
}
import com.in4ray.gaming.consts.LayoutOrder;
import com.in4ray.gaming.layouts.LayoutBase;
import com.in4ray.gaming.layouts.LayoutTarget;
import com.in4ray.gaming.layouts.context.ILayoutContext;

class LayoutVRatio extends LayoutBase
{
	public function LayoutVRatio(value:Number, globalFunc:Function)
	{
		super(value, globalFunc);	
	}
	
	override public function getOrder():uint
	{
		return LayoutOrder.SIZE;
	}
	
	override public function layout(context:ILayoutContext, target:LayoutTarget):void
	{
		var ratio:Number = target.width/target.height;
		target.setHeight(context.getValueHeight(this));
		target.setWidth(ratio*target.height);
	}
}

