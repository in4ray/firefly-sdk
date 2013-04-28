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
	import com.in4ray.gaming.consts.ImageFillMode;
	import com.in4ray.gaming.layouts.ILayout;
	import com.in4ray.gaming.layouts.ILayoutManager;
	import com.in4ray.gaming.layouts.LayoutManager;
	import com.in4ray.gaming.layouts.context.ILayoutContext;
	import com.in4ray.gaming.core.GameGlobals;
	import com.in4ray.gaming.utils.AlignUtil;
	
	import flash.geom.Rectangle;
	
	import starling.display.Image;
	import starling.textures.SubTexture;
	import starling.textures.Texture;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	/**
	 * Starling image component with additional capabilities.
	 */	
	public class Image extends starling.display.Image implements IVisualElement
	{
		/**
		 * Constructor. 
		 * 
		 * @param texture Texture object. 
		 */		
		public function Image(texture:Texture)
		{
			super(texture);
			
			setActualSize( texture.width*GameGlobals.contentScaleFactor, texture.height*GameGlobals.contentScaleFactor);
			
			baseTexture = texture;
			layoutManager = new LayoutManager(this);
		}
		
		private var baseTexture:Texture;
		
		private var _fillMode:String = ImageFillMode.SCALE;

		/**
		 * How to Apply texture on image clip or stretch. 
		 * 
		 * @see com.in4ray.games.core.consts.ImageFillMode 
		 */		
		public function get fillMode():String
		{
			return _fillMode;
		}

		private var _vAlign:String = VAlign.TOP;

		/**
		 * How to align clipped texture by horizontal.
		 * Used when fillMode is clip. 
		 * 
		 * @see starling.utils.VAlign
		 */		
		public function get vAlign():String
		{
			return _vAlign;
		}

		private var _hAlign:String = HAlign.LEFT;

		/**
		 * How to align clipped texture by vertical.
		 * Used when fillMode is clip. 
		 * 
		 * @see starling.utils.HAlign
		 */	
		public function get hAlign():String
		{
			return _hAlign;
		}
		
		/**
		 * Set up fill mode and alligment if mode is scale.
		 *  
		 * @param fillMode How to Apply texture on image clip or stretch. 
		 * @param hAlign How to align clipped texture by horizontal.
		 * @param vAlign How to align clipped texture by vertical.
		 * 
		 * @see com.in4ray.games.core.consts.ImageFillMode
		 * @see starling.utils.HAlign
		 * @see starling.utils.VAlign
		 */		
		public function setFillMode(fillMode:String, hAlign:String = HAlign.LEFT, vAlign:String = VAlign.TOP):void
		{
			_vAlign = vAlign;
			_hAlign = hAlign;
			_fillMode = fillMode;
			
			if(fillMode == ImageFillMode.SCALE)
				texture = baseTexture;
			else
				assignSubtexture();
		}
		
		/**
		 * @private 
		 */		
		protected function assignSubtexture():void
		{
			if(texture != baseTexture)
				texture.dispose();
			
			texture = new SubTexture(baseTexture, 
				new Rectangle(
					AlignUtil.alignHorizontal(0, width-baseTexture.width, hAlign), 
					AlignUtil.alignVertical(0, height-baseTexture.height, vAlign),
					width,
					height)
				);
		}
		
		/**
		 * Layout manager object. 
		 */		
		public var layoutManager:LayoutManager;
		
		/**
		 * @inheritDoc 
		 */		
		public function addLayout(...layouts):ILayoutManager
		{
			layoutManager.addLayouts(layouts);
			return layoutManager;
		}
		
		/**
		 * @inheritDoc 
		 */
		public function removeLayout(layoutFunc:Function):ILayoutManager
		{
			layoutManager.removeLayout(layoutFunc)
			return layoutManager;
		}
		
		/**
		 * @inheritDoc 
		 */
		public function getLayouts():Vector.<ILayout>
		{
			return layoutManager.getLayouts();
		}
		
		/**
		 * @inheritDoc 
		 */
		public function getLayout(layoutFunc:Function):ILayout
		{
			return layoutManager.getLayout(layoutFunc);
		}
		
		/**
		 * @inheritDoc 
		 */
		public function setLayoutValue(layoutFunc:Function, value:Number, units:String = null):void
		{
			layoutManager.setLayoutValue(layoutFunc, value, units);
		}
		
		/**
		 * @inheritDoc 
		 */
		public function layout():void
		{
			layoutManager.layout();
		}
		
		/**
		 * @inheritDoc 
		 */
		public function get parentContext():ILayoutContext
		{
			return parent ? (parent as IVisualContainer).layoutContext : null;
		}
		
		override public function set x(value:Number):void
		{
			throw Error("Forbidden, use layouts");
		}
		
		override public function set y(value:Number):void
		{
			throw Error("Forbidden, use layouts");
		}
		
		override public function set width(value:Number):void
		{
			throw Error("Forbidden, use layouts");
		}
		
		override public function set height(value:Number):void
		{
			throw Error("Forbidden, use layouts");
		}
		
		override public function set pivotX(value:Number):void
		{
			throw Error("Forbidden, use layouts");
		}
		
		override public function set pivotY(value:Number):void
		{
			throw Error("Forbidden, use layouts");
		}
		
		/**
		 * @inheritDoc 
		 */
		public function setActualPosition(x:Number, y:Number):void
		{
			if(!isNaN(x))
				super.x = x;
			if(!isNaN(y))
				super.y = y;
		}
		
		/**
		 * @inheritDoc 
		 */
		public function setActualSize(w:Number, h:Number):void
		{
			if(!isNaN(w))
				super.width = w;
			if(!isNaN(h))
				super.height = h;
			
			if(fillMode == ImageFillMode.CLIP && (!isNaN(w) || !isNaN(h)))
				assignSubtexture();
		}
		
		/**
		 * @inheritDoc 
		 */	
		public function setActualPivots(px:Number, py:Number):void
		{
			if(!isNaN(px))
				super.pivotX = px/GameGlobals.contentScaleFactor;
			if(!isNaN(py))
				super.pivotY = py/GameGlobals.contentScaleFactor;
		}
		
		override public function get pivotX():Number
		{
			return super.pivotX*GameGlobals.contentScaleFactor;
		}
		
		override public function get pivotY():Number
		{
			return super.pivotY*GameGlobals.contentScaleFactor;
		}
	}
}
