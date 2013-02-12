// =================================================================================================
//
//	in4ray Gaming SDK
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.in4ray.gaming.layouts.context
{
	import com.in4ray.gaming.components.IViewMap;
	import com.in4ray.gaming.consts.LayoutUnits;
	import com.in4ray.gaming.layouts.ILayout;
	import com.in4ray.gaming.core.GameGlobals;
	
	/**
	 * Layout context for view maps. 
	 */	
	public class MapLayoutContext extends BasicLayoutContext
	{
		/**
		 * Constructor.
		 *  
		 * @param host Layout ontainer.
		 */		
		public function MapLayoutContext(host:IViewMap)
		{
			super(host);
		}
		
		/**
		 *  View map container
		 */		
		public function get viewMap():IViewMap
		{
			return host as IViewMap;
		}
		
		/**
		 * @inheritDoc 
		 */		
		override public function getValueX(layout:ILayout):Number
		{
			return Math.floor(super.getValueX(layout) - viewMap.viewPortX);
		}
		
		/**
		 * @inheritDoc 
		 */	
		override public function getValueY(layout:ILayout):Number
		{
			return Math.floor(super.getValueY(layout) - viewMap.viewPortY);
		}
		
		/**
		 * Convert local x coordinate to context value. 
		 * @param value Value of x coordinate.
		 * @param units Layout units.
		 * @return Converted value.
		 */		
		public function local2ContextX(value:Number, units:String):Number
		{
			switch(units)
			{
				case LayoutUnits.PX:
				{
					value += viewMap.viewPortX; 
					break;
				}
				case LayoutUnits.PCT:
				{
					value = (value+viewMap.viewPortX)/width*100; 
					break;
				}	
				case LayoutUnits.INCH:
				{
					value = (value+viewMap.viewPortX)/GameGlobals.dpi; 
					break;
				}	
				case LayoutUnits.ACPX:
				{
					value = (value+viewMap.viewPortX)/designScaleFactor + getTextureShiftX(GameGlobals.designSize.x*designScaleFactor); 
					break;
				}	
				case LayoutUnits.RCPX:
				{
					value = (value+viewMap.viewPortX)/designScaleFactor; 
					break;
				}	
				default:
				{
					break;
				}
			}
			return Math.floor(value);
		}
		
		/**
		 * Convert local y coordinate to context value. 
		 * @param value Value of y coordinate.
		 * @param units Layout units.
		 * @return Converted value.
		 */	
		public function local2ContextY(value:Number, units:String):Number
		{
			switch(units)
			{
				case LayoutUnits.PX:
				{
					value += viewMap.viewPortY; 
					break;
				}
				case LayoutUnits.PCT:
				{
					value = (value+viewMap.viewPortY)/height*100; 
					break;
				}	
				case LayoutUnits.INCH:
				{
					value = (value+viewMap.viewPortY)/GameGlobals.dpi; 
					break;
				}	
				case LayoutUnits.ACPX:
				{
					value = (value+viewMap.viewPortY)/designScaleFactor + getTextureShiftY(GameGlobals.designSize.y*designScaleFactor); 
					break;
				}	
				case LayoutUnits.RCPX:
				{
					value = (value+viewMap.viewPortY)/designScaleFactor; 
					break;
				}	
				default:
				{
					break;
				}
			}
			return Math.floor(value);
		}
		
		/**
		 * Convert local width to context value. 
		 * @param value Value of width.
		 * @param units Layout units.
		 * @return Converted value.
		 */	
		public function local2ContextWidth(value:Number, units:String):Number
		{
			switch(units)
			{
				case LayoutUnits.PCT:
				{
					value = value/width*100; 
					break;
				}	
				case LayoutUnits.INCH:
				{
					value = value/GameGlobals.dpi; 
					break;
				}	
				case LayoutUnits.ACPX:
				case LayoutUnits.RCPX:
				{
					value = value/designScaleFactor; 
					break;
				}	
				default:
				{
					break;
				}
			}
			return Math.floor(value);
		}
		
		/**
		 * Convert local height to context value. 
		 * @param value Value of height.
		 * @param units Layout units.
		 * @return Converted value.
		 */	
		public function local2ContextHeight(value:Number, units:String):Number
		{
			switch(units)
			{
				case LayoutUnits.PCT:
				{
					value = value/height*100; 
					break;
				}	
				case LayoutUnits.INCH:
				{
					value = value/GameGlobals.dpi; 
					break;
				}	
				case LayoutUnits.ACPX:
				case LayoutUnits.RCPX:
				{
					value = value/designScaleFactor; 
					break;
				}	
				default:
				{
					break;
				}
			}
			return Math.floor(value);
		}
	}
}