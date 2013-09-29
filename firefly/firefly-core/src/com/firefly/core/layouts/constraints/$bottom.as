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
	/** Global function that returns "bottom" layout constraint. (similar to Flex bottom constraint).
	 *  @param value Layout value
	 *  @return Layout constraint. */	
	public function $bottom(value:Number):ILayoutUnits
	{
		return new ConstraintBottom(value, $bottom);
	}
}

import com.firefly.core.firefly_internal;
import com.firefly.core.layouts.constraints.LayoutConstraint;
import com.firefly.core.layouts.helpers.LayoutContext;
import com.firefly.core.layouts.helpers.LayoutElement;

class ConstraintBottom extends LayoutConstraint
{
	public function ConstraintBottom(value:Number, globalFunc:Function)
	{
		super(value, FIRST_CONSTRAINS, globalFunc);	
	}
	
	override public function layout(context:LayoutContext, element:LayoutElement):void
	{
		if(!element.firefly_internal::_yChanged)
			element.y = context.height - context.layoutToRealByY(value, units) - element.height;
		else
			element.height = context.height - context.layoutToRealByY(value, units) - element.y;
	}
}