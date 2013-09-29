// =================================================================================================
//
//	Firefly Framework
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.layouts.constraints
{
	/** Global function that returns "horizontalCenter" layout constraint. (similar to Flex horizontalCenter constraint).
	 *  @param value Layout value
	 *  @return Layout constraint. */	
	public function $hCenter(value:Number):ILayoutUnits
	{
		return new ConstraintHCenter(value, $hCenter);
	}
}

import com.firefly.core.layouts.constraints.LayoutConstraint;
import com.firefly.core.layouts.helpers.LayoutContext;
import com.firefly.core.layouts.helpers.LayoutElement;

class ConstraintHCenter extends LayoutConstraint
{
	public function ConstraintHCenter(value:Number, globalFunc:Function)
	{
		super(value, SECOND_CONSTRAINS, globalFunc);	
	}
	
	override public function layout(context:LayoutContext, element:LayoutElement):void
	{
		element.x = context.layoutToRealByX(value, units) + (context.width - element.width)/2;
	}
}