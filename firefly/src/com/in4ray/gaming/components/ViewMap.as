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
	import com.in4ray.gaming.consts.LayoutUnits;
	import com.in4ray.gaming.layouts.context.MapLayoutContext;
	
	import flash.geom.Rectangle;
	
	import starling.animation.IAnimatable;
	import starling.utils.deg2rad;
	
	/**
	 * View map component that can move screen along big map. Currently is not completely implemented.
	 */	
	public class ViewMap extends ViewMapBase implements IAnimatable
	{
		/**
		 * Constructor. 
		 */		
		public function ViewMap()
		{
			super();
		}
		
		
		private var angle:Number = 0;
		private var speed:Number = 0;
		
		/**
		 * Proceed with moving.
		 * 
		 * @param time Time from last moving.
		 */		
		public function advanceTime(time:Number):void
		{
			_viewPortX += speed*time*Math.cos(deg2rad(angle));
			_viewPortY -= speed*time*Math.sin(deg2rad(angle));
			
			validateScreen();
		}
		
		/**
		 * Set up moving.
		 *  
		 * @param speed Speed of moving.
		 * @param angle Angle direction.
		 * 
		 */		
		public function move(speed:Number, angle:Number):void
		{
			this.speed = speed;
			this.angle = angle;
		}
		
		/**
		 * Zoom of map. Not implemented yet 
		 * @param value Zoom value.
		 */		
		public function zoom(value:Number):void
		{
		}
		
		/**
		 * Set current view port position
		 *  
		 * @param x Position by X-axis.
		 * @param y Position by Y-axis.
		 */		
		public function setViewPortPosition(x:Number, y:Number):void
		{
			_viewPortX = x;
			_viewPortY = y;
			
			validateScreen();
		}
		
		/**
		 * Map grid width 
		 */		
		public var gridWidth:Number;
		
		/**
		 * Map grid height 
		 */
		public var gridHeight:Number;
		
		private var lastViewRect:Rectangle;
		
		/**
		 * @private 
		 */		
		protected function validateScreen():void
		{
			var rect:Rectangle = local2Grid(new Rectangle(viewPortX, viewPortY, width, height));
			if(lastViewRect)
			{
				if(!rect.equals(lastViewRect))
				{
					var toRelease:Vector.<Rectangle> = subtractRect(lastViewRect, rect);
					for each (var releaseRect:Rectangle in toRelease) 
					{
						//trace("remove real: " + releaseRect);
						releaseScreen(releaseRect);
					}
					
					var toUpdate:Vector.<Rectangle> = subtractRect(rect, lastViewRect);
					for each (var updateRect:Rectangle in toUpdate) 
					{
						//trace("add real: " + updateRect);
						updateScreen(updateRect);
					}
				}
			}
			else
			{
				//trace("add initial: " + rect);
				updateScreen(rect);
			}
			
			lastViewRect = rect;
			
			layoutChildren();
		}
		
		private function subtractRect(minuend:Rectangle, subtrahend:Rectangle):Vector.<Rectangle>
		{
			var res:Vector.<Rectangle> = new Vector.<Rectangle>();
			
			if(minuend.intersects(subtrahend))
			{
				if(subtrahend.x < minuend.right && subtrahend.x > minuend.x)
				{
					res.push(new Rectangle(minuend.x, minuend.y, subtrahend.x - minuend.x, minuend.height));
				}
				
				if(subtrahend.right < minuend.right && subtrahend.right > minuend.x)
				{
					res.push(new Rectangle(subtrahend.right, minuend.y, minuend.right - subtrahend.right, minuend.height));
				}
				
				var xx:Number = Math.max(minuend.x, subtrahend.x);
				var ww:Number = Math.min(minuend.right, subtrahend.right) - xx;
				if(subtrahend.y < minuend.bottom && subtrahend.y > minuend.y)
				{
					res.push(new Rectangle(xx, minuend.y, ww, subtrahend.y-minuend.y));
				}
				
				if(subtrahend.bottom < minuend.bottom && subtrahend.bottom > minuend.y)
				{
					res.push(new Rectangle(xx, subtrahend.bottom, ww, minuend.bottom-subtrahend.bottom));
				}
			}
			else
			{
				res.push(minuend.clone());
			}
			
			return res;
		}
		
		/**
		 * Update screen, add new objects.
		 * 
		 * @param rect Rectangle that previously not visible but now is going to be visible on screen.
		 */		
		public function updateScreen(rect:Rectangle):void
		{
			// to be overriden
		}
		
		/**
		 * Update screen, remove not needed objects.
		 * 
		 * @param rect Rectangle that previously visible but now is going to be not visible on screen.
		 */	
		public function releaseScreen(rect:Rectangle):void
		{
			// to be overriden
		}
		
		/**
		 * Convert rectangle from local to context coordinate system. 
		 * @param rect Rectangle to be converted.
		 * @param units Measure units.
		 * @return Converted rectangle.
		 * 
		 */		
		public function local2Context(rect:Rectangle, units:String):Rectangle
		{
			var xx:Number = (layoutContext as MapLayoutContext).local2ContextX(rect.x - viewPortX, units);
			var yy:Number = (layoutContext as MapLayoutContext).local2ContextY(rect.y - viewPortY, units);
			var ww:Number = (layoutContext as MapLayoutContext).local2ContextWidth(rect.width, units);
			var hh:Number = (layoutContext as MapLayoutContext).local2ContextHeight(rect.height, units);
			
			return new Rectangle(xx, yy, ww, hh);
		}
		
		/**
		 * @private 
		 */		
		protected function local2Grid(rect:Rectangle):Rectangle
		{
			rect = local2Context(rect, LayoutUnits.ACPX);
			var xx:Number = Math.floor(rect.x/gridWidth);
			var yy:Number = Math.floor(rect.y/gridHeight);
			var ww:Number = Math.ceil(rect.right/gridWidth) - xx;
			var hh:Number = Math.ceil(rect.bottom/gridHeight) - yy;
			
			rect.setTo(xx,yy,ww,hh);
			return rect;
		}
	}
}