// =================================================================================================
//
//	in4ray Gaming SDK
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.in4ray.gaming.components
{
	import com.in4ray.gaming.consts.Direction;
	import com.in4ray.gaming.effects.Animate;
	import com.in4ray.gaming.events.NavigationMapEvent;
	import com.in4ray.gaming.core.GameGlobals;
	
	import flash.geom.Point;
	
	import starling.animation.Transitions;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	/**
	 * Visual container used as carousel of screens, user can swipe them by gestures. 
	 */	
	public class NavigationMap extends ViewMapBase
	{
		/**
		 * Constructor. 
		 * 
		 * @param direction Layout direction vertical or horizontal
		 * 
		 * @see com.in4ray.games.core.consts.Direction
		 */		
		public function NavigationMap(direction:String = Direction.HORIZONTAL)
		{
			super();
			this.direction = direction;
			
			touchableWhereTransparent = true;
			
			addEventListener(TouchEvent.TOUCH, onTouchHandler);
			
			animation = new Animate(this, duration);
			animation.transition = transition;
		}
		
		private var _screenWidth:Number;
		
		/**
		 * Screen width 
		 */		
		public function get screenWidth():Number
		{
			return !isNaN(_screenWidth) ? _screenWidth : width;
		}
		
		public function set screenWidth(value:Number):void
		{
			_screenWidth = value;
		}
		
		private var _screenHeight:Number;
		
		/**
		 * Screen height 
		 */		
		public function get screenHeight():Number
		{
			return !isNaN(_screenHeight) ? _screenHeight : height;
		}
		
		public function set screenHeight(value:Number):void
		{
			_screenHeight = value;
		}
		
		
		private var animation:Animate;
		
		private var direction:String;
		
		/**
		 * Shows how much finger movement will affect screen movement.
		 * 
		 * @default 0.7   
		 */		
		public var userMovementRatio:Number = 0.7;
		
		/**
		 * Minimum finger movement to start moving screen.
		 *  
		 * @default 10  
		 */		
		public var sensitivity:Number = 10;
		
		private var startPosition:Point;
		private var startTouch:Touch;
		private var startTouchTime:Number;
		private var lastMovement:Point;
		
		private function onTouchHandler(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(this);
			if(touch)
			{
				switch(touch.phase)
				{
					case TouchPhase.BEGAN:
					{
						animation.stop();
						startPosition = new Point(viewPortX, viewPortY);
						startTouch = touch.clone();
						startTouchTime = new Date().time;
						break;
					}
					case TouchPhase.MOVED:
					{
						lastMovement = touch.getMovement(this);
						if(Math.abs(startTouch.globalX - touch.globalX) > sensitivity || Math.abs(startTouch.globalY - touch.globalY) > sensitivity)
						{
							dispatchEvent(new NavigationMapEvent(NavigationMapEvent.SCREEN_MOVING, currentScreen)); 
							if(direction == Direction.HORIZONTAL)
								viewPortX -= lastMovement.x*userMovementRatio;
							else
								viewPortY += lastMovement.y*userMovementRatio;
						}
						break;
					}
					case TouchPhase.ENDED:
					{
						var acceleration:Number;
						
						if(direction == Direction.HORIZONTAL)
						{
							acceleration = Math.floor((Math.abs(touch.globalX - startTouch.globalX) / GameGlobals.stageSize.x)  * 400 / (new Date().time - startTouchTime));
							acceleration = touch.globalX - startTouch.globalX > 0 ? acceleration : -acceleration;
							
							if((viewPortX%screenWidth > screenWidth/3 && viewPortX > startPosition.x) || (viewPortX%screenWidth > 2*screenWidth/3 && viewPortX < startPosition.x))
								moveToScreen(Math.max(0, Math.ceil((viewPortX)/screenWidth)) - acceleration);
							else
								moveToScreen(Math.max(0, Math.floor((viewPortX)/screenWidth)) - acceleration);
						}
						else
						{
							acceleration = Math.floor((Math.abs(touch.globalY - startTouch.globalY) / GameGlobals.stageSize.y)  * 400 / (new Date().time - startTouchTime));
							acceleration = touch.globalY - startTouch.globalY > 0 ? acceleration : -acceleration;
							
							if((viewPortY%screenHeight > screenHeight/3 && viewPortY > startPosition.y) || (viewPortY%screenHeight < screenHeight/3 && viewPortY < startPosition.y))
								moveToScreen(Math.ceil(viewPortY/screenHeight) - acceleration);
							else
								moveToScreen(Math.floor(viewPortY/screenHeight) - acceleration);
						}
						break;
					}
					default:
					{
						break;
					}
				}
			}
		}
		
		private var _currentScreen:int = 0;
		
		/**
		 * Current screen index. 
		 */		
		public function get currentScreen():int
		{
			return _currentScreen;
		}
		
		
		private var _numScreens:uint = 0;
		
		/**
		 * Total number of screens. 
		 */		
		public function set numScreens(value:uint):void
		{
			_numScreens = value;
		}
		
		public function get numScreens():uint
		{
			if(_numScreens > 0)
				return _numScreens;
			else
				return direction == Direction.HORIZONTAL ? Math.ceil(mapWidth/screenWidth) : Math.ceil(mapHeight/screenHeight);
		}
		
		/**
		 * Transition that will be used for moving from screen to screen. 
		 */		
		public var transition:String = Transitions.EASE_OUT;
		
		/**
		 * Duration of moving from screen to screen.  
		 */		
		public var duration:Number = 800;
		
		/**
		 * Move to screen with transition.
		 *  
		 * @param index Index of screen.
		 */		
		public function moveToScreen(index:int):void
		{
			index = Math.max(0, Math.min(numScreens-1, index));
			
			if(direction == Direction.HORIZONTAL)
			{
				animation.toValue = index*screenWidth;
				animation.property = "viewPortX";
				animation.duration = duration;
				
				if(Math.abs(index - currentScreen) == 0)
					animation.duration = 2*duration*Math.abs(index*screenWidth - viewPortX)/screenWidth;
			}
			else
			{
				animation.toValue = index*screenHeight;
				animation.property = "viewPortY";
				
				if(Math.abs(index - currentScreen) == 0)
					animation.duration = Math.max(duration, 2*duration*Math.abs(index*screenHeight - viewPortY)/screenHeight);
			}
			
			dispatchEvent(new NavigationMapEvent(NavigationMapEvent.SCREEN_CHANGING, currentScreen, index)); 
			animation.transition = transition;
			animation.completeCallback = animationComplete;
			animation.completeArgs = [currentScreen, index];
			animation.play();
			
			_currentScreen = index;
		}
		
		/**
		 * Move to screen without transition.
		 *  
		 * @param index Index of screen.
		 */
		public function showScreen(index:uint):void
		{
			animation.stop();
			
			if(direction == Direction.HORIZONTAL)
			{
				viewPortX = index*screenWidth;
			}
			else
			{
				viewPortY = index*screenHeight;
			}
			
			dispatchEvent(new NavigationMapEvent(NavigationMapEvent.SCREEN_CHANGE, currentScreen, index));
			_currentScreen = index;
		}
		
		/**
		 * @private 
		 */		
		protected function animationComplete(fromScreen:uint, toScreen:uint):void
		{
			dispatchEvent(new NavigationMapEvent(NavigationMapEvent.SCREEN_CHANGE, fromScreen, toScreen));
		}
	}
}
