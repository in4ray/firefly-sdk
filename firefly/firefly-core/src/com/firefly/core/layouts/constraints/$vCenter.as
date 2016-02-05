// =================================================================================================
//
//	Firefly Framework
//	Copyright 2016 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.layouts.constraints
{
	/** Global function that returns "verticalCenter" layout constraint. (similar to Flex verticalCenter constraint).
	 *  @param value Layout value
	 *  @return Layout constraint. */	
	public function $vCenter(value:Number):ILayoutUnits
	{
		return new ConstraintVCenter(value, $vCenter);
	}
}

import com.firefly.core.layouts.constraints.LayoutConstraint;
import com.firefly.core.layouts.helpers.LayoutContext;
import com.firefly.core.layouts.helpers.LayoutElement;

class ConstraintVCenter extends LayoutConstraint
{
	public function ConstraintVCenter(value:Number, globalFunc:Function)
	{
		super(value, SECOND_CONSTRAINS, globalFunc);	
	}
	
	override public function layout(context:LayoutContext, element:LayoutElement):void
	{
		element.y = context.layoutToRealByY(value, units) + (context.height - element.height)/2;
	}
}