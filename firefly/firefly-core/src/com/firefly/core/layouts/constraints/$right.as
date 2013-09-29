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
	/** Global function that returns "right" layout constraint. (similar to Flex right constraint).
	 *  @param value Layout value
	 *  @return Layout constraint. */	
	public function $right(value:Number):ILayoutUnits
	{
		return new ConstraintRight(value, $right);
	}
}

import com.firefly.core.firefly_internal;
import com.firefly.core.layouts.constraints.LayoutConstraint;
import com.firefly.core.layouts.helpers.LayoutContext;
import com.firefly.core.layouts.helpers.LayoutElement;

class ConstraintRight extends LayoutConstraint
{
	public function ConstraintRight(value:Number, globalFunc:Function)
	{
		super(value, FIRST_CONSTRAINS, globalFunc);	
	}
	
	override public function layout(context:LayoutContext, element:LayoutElement):void
	{
		if(!element.firefly_internal::_xChanged)
			element.x = context.width - context.layoutToRealByX(value, units) - element.width;
		else
			element.width = context.width - context.layoutToRealByX(value, units) - element.x;
	}
}
