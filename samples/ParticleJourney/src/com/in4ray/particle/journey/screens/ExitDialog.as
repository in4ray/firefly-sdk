package com.in4ray.particle.journey.screens
{
	import com.firefly.core.components.Dialog;
	
	import starling.display.Quad;
	
	public class ExitDialog extends Dialog
	{
		public function ExitDialog()
		{
			super();
			
			layout.addElement(new Quad(100,200));
		}
	}
}