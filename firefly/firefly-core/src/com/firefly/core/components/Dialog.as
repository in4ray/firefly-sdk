package com.firefly.core.components
{
	import com.firefly.core.display.IDialog;
	import com.firefly.core.effects.Scale;
	
	public class Dialog extends View implements IDialog
	{
		public function Dialog()
		{
			super();
		}
		
		override public function show():void
		{
			new Scale(this, .2, 1, 0.1).play();
		}

		public function onBack():void { }
	}
}