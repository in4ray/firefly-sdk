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
	import com.in4ray.gaming.components.IVisualElement;
	import com.in4ray.gaming.consts.LayoutUnits;
	import com.in4ray.gaming.core.GameGlobals;
	import com.in4ray.gaming.layouts.ILayout;
	import com.in4ray.gaming.utils.AlignUtil;
	
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	/**
	 * Basic layout context 
	 */	
	public class BasicLayoutContext implements ILayoutContext
	{
		/**
		 * Constructor.
		 *  
		 * @param host Layout container.
		 * @param hAlign Horizontal texture align.
		 * @param vAlign Vertical texture align.
		 */		
		public function BasicLayoutContext(host:IVisualElement, hAlign:String = "center", vAlign:String = "center")
		{
			_host = host;
			this.vAlign = vAlign;
			this.hAlign = hAlign;
		}

		/**
		 * Layout container. 
		 */		
		protected var _host:IVisualElement;

		/**
		 * @private
		 */
		private var _hAlign:String = HAlign.CENTER;

		/**
		 * Horizontal align of background texture.
		 * @default "center"
		 * @see starling.utils.HAlign
		 */
		public function get hAlign():String
		{
			return _hAlign;
		}

		/**
		 * @private
		 */
		public function set hAlign(value:String):void
		{
			_hAlign = value;
		}

		/**
		 * @private
		 */
		private var _vAlign:String = VAlign.CENTER;

		/**
		 * Vertical align of background texture.
		 * @default "center"
		 * @see starling.utils.VAlign
		 */
		public function get vAlign():String
		{
			return _vAlign;
		}

		/**
		 * @private
		 */
		public function set vAlign(value:String):void
		{
			_vAlign = value;
		}

		
		/**
		 * @inheritDoc 
		 */		
		public function get host():IVisualElement
		{
			return _host;
		}

		/**
		 * @inheritDoc 
		 */	
		public function getValueX(layout:ILayout):Number
		{
			return getValueXInternal(layout);
		}
		
		/**
		 * @private 
		 */	
		protected function getValueXInternal(layout:ILayout):Number
		{
			var value:Number = layout.value;
			switch(layout.getUnits())
			{
				case LayoutUnits.PCT:
				{
					value *= host.width/100;
					break;
				}
				case LayoutUnits.INCH:
				{
					value *= GameGlobals.dpi;
					break;
				}
				case LayoutUnits.ACPX:
				{
					value = designScaleFactor*value - getTextureShiftX(GameGlobals.designSize.x*designScaleFactor);
					break;
				}
				case LayoutUnits.RCPX:
				{
					value = designScaleFactor*value;
					break;
				}
				default:
				{
					break;
				}
			}
			
			return value;
		}
		
		/**
		 * @inheritDoc 
		 */	
		public function getValueY(layout:ILayout):Number
		{
			return getValueYInternal(layout);
		}
		
		/**
		 * @private 
		 */	
		protected function getValueYInternal(layout:ILayout):Number
		{
			var value:Number = layout.value;
			switch(layout.getUnits())
			{
				case LayoutUnits.PCT:
				{
					value *= host.height/100;
					break;
				}
				case LayoutUnits.INCH:
				{
					value *= GameGlobals.dpi;
					break;
				}
				case LayoutUnits.ACPX:
				{
					value = designScaleFactor*value - getTextureShiftY(GameGlobals.designSize.y*designScaleFactor);
					break;
				}
				case LayoutUnits.RCPX:
				{
					value = designScaleFactor*value;
					break;
				}
				default:
				{
					break;
				}
			}
			
			return  value;
		}
		
		/**
		 * @inheritDoc 
		 */	
		public function getValueHeight(layout:ILayout):Number
		{
			if(layout.getUnits() == LayoutUnits.ACPX || layout.getUnits() == LayoutUnits.RCPX)
				return  Math.floor(designScaleFactor*layout.value);
			
			return Math.floor(getValueYInternal(layout));
		}
		
		/**
		 * @inheritDoc 
		 */	
		public function getValueWidth(layout:ILayout):Number
		{
			if(layout.getUnits() == LayoutUnits.ACPX || layout.getUnits() == LayoutUnits.RCPX)
				return  Math.floor(designScaleFactor*layout.value);
			
			return Math.floor(getValueXInternal(layout));
		}
		
		/**
		 * @inheritDoc 
		 */	
		public function get width():Number
		{
			return _host.width;
		}
		
		/**
		 * @inheritDoc 
		 */	
		public function get height():Number
		{
			return _host.height;
		}
		
		/**
		 * @private
		 */	
		protected function getTextureShiftX(w:Number):Number
		{
			return AlignUtil.alignHorizontal(w, GameGlobals.stageSize.x, hAlign);
		}
		
		/**
		 * @private
		 */
		protected function getTextureShiftY(h:Number):Number
		{
			return AlignUtil.alignVertical(h, GameGlobals.stageSize.y, vAlign);
		}
		
		/**
		 * @private
		 */
		protected function get designScaleFactor():Number
		{
			return Math.max(GameGlobals.stageSize.x/GameGlobals.designSize.x, GameGlobals.stageSize.y/GameGlobals.designSize.y);
		}
		
		public function toLayoutValueY(value:Number, layoutUnits:String):Number
		{
			switch(layoutUnits)
			{
				case LayoutUnits.PCT:
				{
					value /= host.height/100;
					break;
				}
				case LayoutUnits.INCH:
				{
					value /= GameGlobals.dpi;
					break;
				}
				case LayoutUnits.ACPX:
				{
					value = (value + getTextureShiftY(GameGlobals.designSize.y*designScaleFactor))/designScaleFactor;
					break;
				}
				case LayoutUnits.RCPX:
				{
					value /= designScaleFactor;
					break;
				}
				default:
				{
					break;
				}
			}
			
			return value;
		}
		
		public function toLayoutValueX(value:Number, layoutUnits:String):Number
		{
			switch(layoutUnits)
			{
				case LayoutUnits.PCT:
				{
					value /= host.width/100;
					break;
				}
				case LayoutUnits.INCH:
				{
					value /= GameGlobals.dpi;
					break;
				}
				case LayoutUnits.ACPX:
				{
					value = (value + getTextureShiftX(GameGlobals.designSize.x*designScaleFactor))/designScaleFactor;
					break;
				}
				case LayoutUnits.RCPX:
				{
					value /= designScaleFactor;
					break;
				}
				default:
				{
					break;
				}
			}
			
			return value;
		}
	}
}