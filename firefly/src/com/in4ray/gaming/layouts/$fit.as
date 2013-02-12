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
	 * Global function that returns layout constraint that sets size of target 
	 * keeping aspect ratio and fitting into square box with size of contsraint value.
	 * 
	 * @param value Layout value
	 * @return Layout constraint. 
	 */
	public function $fit(value:Number):ILayoutUnits
	{
		return new LayoutFit(value, $hRatio);
	}
}

import com.in4ray.gaming.consts.LayoutOrder;
import com.in4ray.gaming.layouts.LayoutBase;
import com.in4ray.gaming.layouts.LayoutTarget;
import com.in4ray.gaming.layouts.context.ILayoutContext;

class LayoutFit extends LayoutBase
{
	public function LayoutFit(value:Number, globalFunc:Function)
	{
		super(value, globalFunc);	
	}
	
	override public function getOrder():uint
	{
		return LayoutOrder.SIZE;
	}
	
	override public function layout(context:ILayoutContext, target:LayoutTarget):void
	{
		var w:Number = context.width - 2*context.getValueWidth(this);
		var h:Number = context.height - 2*context.getValueHeight(this);
		var ratio:Number = Math.min(w/target.width, h/target.height);
		target.setWidth(target.width*ratio);
		target.setHeight(target.height*ratio);
	}
}

