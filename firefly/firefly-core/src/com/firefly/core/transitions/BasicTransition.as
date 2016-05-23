// =================================================================================================
//
//	Firefly Framework
//	Copyright 2016 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.transitions
{
	import com.firefly.core.async.Future;
	import com.firefly.core.controllers.NavigatorCtrl;
	import com.firefly.core.controllers.helpers.ViewState;
	import com.firefly.core.display.IView;
	import com.firefly.core.effects.Fade;
	
	/** Simple basic transition which uses for navigation between view states. For transition effect uses fade animation.
	 * 
	 *  @see com.firefly.core.components.ScreenNavigator
	 *  @see com.firefly.core.controllers.ScreenNavigatorCtrl */	
	public class BasicTransition implements ITransition
	{
		/** @private */		
		private var _transitiveView:IView;
		/** @private */
		private var _duration:Number;
		
		/** Constuctor.
		 *  @param transitiveView View component which will be showed during transition.
		 *  @param duration Duration of transition in seconds. */		
		public function BasicTransition(transitiveView:IView, duration:Number = 0.5)
		{
			_duration = duration;
			_transitiveView = transitiveView;
		}
		
		/** @inheritDoc */		
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