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
	import com.firefly.core.layouts.constraints.ILayoutUnits;

	/** Global function that returns "left" layout constraint. (similar to Flex bottom constraint).
	 *  @param value Layout value
	 *  @return Layout constraint. */	
	public function $left(value:Number):ILayoutUnits
	{
		return new ConstraintLeft(value, $left);
	}
}

import com.firefly.core.layouts.constraints.LayoutConstraint;
import com.firefly.core.layouts.helpers.LayoutContext;
import com.firefly.core.layouts.helpers.LayoutElement;

class ConstraintLeft extends LayoutConstraint
{
	public function ConstraintLeft(value:Number, globalFunc:Function):void
	{
		super(value, POSITION, globalFunc);
	}
	
	override public function layout(context:LayoutContext, element:LayoutElement):void
	{
		element.x = context.layoutToRealByX(value, units);
	}
}

