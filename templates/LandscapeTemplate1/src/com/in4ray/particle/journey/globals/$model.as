package com.in4ray.particle.journey.globals
{
	import com.firefly.core.Firefly;
	import com.in4ray.particle.journey.model.Model;
	
	
	
	public function get $model():Model
	{
		return Firefly.current.model as Model;
	}
}