package com.firefly.core.transitions
{
	import com.firefly.core.async.Future;
	import com.firefly.core.controllers.NavigatorCtrl;
	import com.firefly.core.controllers.helpers.ViewState;
	import com.firefly.core.display.IView;
	import com.firefly.core.effects.Fade;
	
	public class BasicTransition implements ITransition
	{
		private var _transitiveView:IView;

		private var _duration:Number;
		
		public function BasicTransition(transitiveView:IView, duration:Number = 0.5)
		{
			_duration = duration;
			_transitiveView = transitiveView;
		}
		
		public function transit(navigator:NavigatorCtrl, toState:ViewState, data:Object=null):void
		{
			navigator.addOverlay(_transitiveView);
			var fadeIn:Fade = new Fade(_transitiveView, _duration, 1, 0);
			Future.forEach(fadeIn.play(), Future.delay(_duration+0.1)).then(function():void
			{
				navigator.assetManager.switchToStateName(toState.assetState).then(function():void
				{
					navigator.navigateToState(toState.name, data);
					var fadeOut:Fade = new Fade(_transitiveView, _duration, 0, 1);
					fadeOut.play().then(navigator.removeOverlay, _transitiveView);
				});
			});
		}
	}
}