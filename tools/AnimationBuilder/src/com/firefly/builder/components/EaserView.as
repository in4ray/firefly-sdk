// =================================================================================================
//
//	Firefly Framework
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.builder.components
{
	import com.firefly.core.effects.easing.IEaser;
	
	import spark.components.Group;
	import spark.components.supportClasses.SkinnableComponent;
	
	public class EaserView extends SkinnableComponent
	{
		private const VIEW_WIDTH:int = 200;
		
		private var _easer:IEaser;
		
		[SkinPart(required="true")]
		public var easerGroup:Group;
		
		public function EaserView()
		{
			super();
		}

		public function get easer():IEaser { return _easer; }
		public function set easer(value:IEaser):void
		{
			_easer = value;
			updateView();
		}
		
		private function updateView():void
		{
			easerGroup.graphics.clear();
			easerGroup.graphics.lineStyle(2, 0x3D3D3D);
			easerGroup.graphics.moveTo(0, VIEW_WIDTH);
			for (var x:int = 0; x <= VIEW_WIDTH; x++)
			{
				easerGroup.graphics.lineTo(x, VIEW_WIDTH - VIEW_WIDTH * easer.ease(x / VIEW_WIDTH));
			}
		}
	}
}