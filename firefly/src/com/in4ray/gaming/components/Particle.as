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
	import com.in4ray.gaming.layouts.ILayout;
	import com.in4ray.gaming.layouts.ILayoutManager;
	import com.in4ray.gaming.layouts.LayoutManager;
	import com.in4ray.gaming.layouts.context.ILayoutContext;
	import com.in4ray.gaming.core.GameGlobals;
	
	import starling.extensions.particles.PDParticleSystem;
	import starling.textures.Texture;
	
	/**
	 * Particle system originally got from http://blog.onebyonedesign.com/flash/particle-editor-for-starling-framework/
	 */	
	public class Particle extends PDParticleSystem implements IVisualElement
	{
		/**
		 * Constructor.
		 *  
		 * @param config Particle configuration XML
		 * @param texture Partcile texture
		 */		
		public function Particle(config:XML, texture:Texture)
		{
			super(config, texture);
			
			dpiFactor = GameGlobals.dpi/GameGlobals.designDPI;
			
			super.startSize = super.startSize*dpiFactor; 
			super.endSize = super.endSize* dpiFactor; 
			super.startSizeVariance = super.startSizeVariance*dpiFactor; 
			super.endSizeVariance = super.endSizeVariance*dpiFactor; 
			
			layoutManager = new LayoutManager(this);
		}
		
		/**
		 * @private 
		 */		
		protected var dpiFactor:Number = 1;
		
		override public function get endSize():Number
		{
			return super.endSize / dpiFactor;
		}
		
		override public function set endSize(value:Number):void
		{
			super.endSize = value * dpiFactor;
		}
		
		override public function get endSizeVariance():Number
		{
			return super.endSizeVariance / dpiFactor;
		}
		
		override public function set endSizeVariance(value:Number):void
		{
			super.endSizeVariance = value * dpiFactor;
		}
		
		override public function get startSize():Number
		{
			return super.startSize / dpiFactor;
		}
		
		override public function set startSize(value:Number):void
		{
			super.startSize = value * dpiFactor;
		}
		
		override public function get startSizeVariance():Number
		{
			return super.startSizeVariance / dpiFactor;
		}
		
		override public function set startSizeVariance(value:Number):void
		{
			super.startSizeVariance = value * dpiFactor;
		}
		
		/**
		 * Layout manager object. 
		 */		
		private var layoutManager:LayoutManager;
		
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
		
		/**
		 * @inheritDoc 
		 */	
		public function setActualPosition(x:Number, y:Number):void
		{
			if(!isNaN(x))
				emitterX = x;
			if(!isNaN(y))
				emitterY = y;
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
		}
		
		override public function get x():Number
		{
			return emitterX;
		}
		
		override public function get y():Number
		{
			return emitterY;
		}
	}
}