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

	/** Global function that returns layout constraint that sets position by X-Axis for target.
	 *  @param value Layout value on design coordinate system.
	 *  @return Layout constraint. */
	public function $x(value:Number):ILayoutUnits
	{
		return new ConstraintX(value, $x);
	}
}

import com.firefly.core.layouts.constraints.LayoutConstraint;
import com.firefly.core.layouts.helpers.LayoutContext;
import com.firefly.core.layouts.helpers.LayoutElement;

class ConstraintX extends LayoutConstraint
{
	public function ConstraintX(value:Number, globalFunc:Function):void
	{
		super(value, POSITION, globalFunc);
	}
	
	override public function layout(context:LayoutContext, element:LayoutElement):void
	{
		element.x = context.layoutToRealByX(value, units, true);
	}
}