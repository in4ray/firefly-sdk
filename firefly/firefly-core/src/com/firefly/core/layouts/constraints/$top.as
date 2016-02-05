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
	import com.firefly.core.layouts.constraints.ILayoutUnits;

	/** Global function that returns "top" layout constraint. (similar to Flex bottom constraint).
	 *  @param value Layout value
	 *  @return Layout constraint. */
	public function $top(value:Number):ILayoutUnits
	{
		return new ConstraintTop(value, $top);
	}
}

import com.firefly.core.layouts.constraints.LayoutConstraint;
import com.firefly.core.layouts.helpers.LayoutContext;
import com.firefly.core.layouts.helpers.LayoutElement;

class ConstraintTop extends LayoutConstraint
{
	public function ConstraintTop(value:Number, globalFunc:Function)
	{
		super(value, POSITION, globalFunc);	
	}
	
	override public function layout(context:LayoutContext, element:LayoutElement):void
	{
		element.y = context.layoutToRealByY(value, units);
	}
}