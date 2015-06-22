package com.in4ray.particle.journey.globals
{
	import com.firefly.core.Firefly;
	import com.firefly.core.layouts.Layout;
	import com.firefly.core.utils.SingletonLocator;

	public function $layout(child:Object, ...layouts):void
	{
		SingletonLocator.getInstance(Layout, null, Firefly.current.main).layoutElement.apply(null, [child].concat(layouts));
	}
}