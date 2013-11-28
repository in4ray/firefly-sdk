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
	import com.firefly.core.audio.IAudio;
	import com.in4ray.gaming.core.GameGlobals;
	import com.in4ray.gaming.events.BindingEvent;
	import com.in4ray.gaming.layouts.ILayout;
	import com.in4ray.gaming.layouts.ILayoutManager;
	import com.in4ray.gaming.layouts.LayoutManager;
	import com.in4ray.gaming.layouts.context.ILayoutContext;
	import com.in4ray.gaming.locale.LocaleManager;
	
	import starling.display.Button;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	
	/**
	 * Starling button component with additional capabilities. 
	 */	
	public class Button extends starling.display.Button implements IVisualElement
	{
		/**
		 * Creates simple button with the same texture for up and down states and click sound effect.
		 *  
		 * @param upState Texture for up and down states.
		 * @param clickSound Click sound effect.
		 * @return Button object.
		 */		
		public static function simple(upState:Texture, clickSound:IAudio = null):com.in4ray.gaming.components.Button
		{
			return new com.in4ray.gaming.components.Button(upState, "", null, clickSound);
		}
		
		/**
		 * Constructor.
		 *  
		 * @param upState Texture for up state.
		 * @param text Text for label.
		 * @param downState Texture for down state.
		 * @param clickSound Click sound effect.
		 */		
		public function Button(upState:Texture, text:String="", downState:Texture=null, clickSound:IAudio = null)
		{
			lm = LocaleManager.getInstance();
			lm.bind(localeChangeHandler);
			
			super(upState, text, downState);
			
			_clickSound = clickSound;
			
			var bg:starling.display.Image = (getChildAt(0) as DisplayObjectContainer).getChildAt(0) as starling.display.Image; 
			bg.width *= GameGlobals.contentScaleFactor;  
			bg.height *= GameGlobals.contentScaleFactor;  
			
			layoutManager = new LayoutManager(this);
			
			addEventListener(TouchEvent.TOUCH, touchHandler);
		}
		
		private var _clickSound:IAudio;
		
		
		/**
		 * @private 
		 */		
		private var lm:LocaleManager;
		
		/**
		 * @private 
		 */	
		private var _text:String;
		
		/**
		 * @iheritDoc 
		 */	
		override public function get text():String
		{
			return _text;
		}
		
		/**
		 * Return localized text. 
		 */		
		public function get textLocalized():String
		{
			return super.text;
		}
		
		/**
		 * @iheritDoc 
		 */	
		override public function set text(value:String):void
		{
			_text = value;
			
			super.text = lm.localize(_text);
		}
		
		/**
		 * @private 
		 */		
		private function localeChangeHandler(e:BindingEvent):void
		{
			if(_text)
				super.text = lm.localize(_text);
		}
		
		/**
		 * @private 
		 */		
		protected function touchHandler(e:TouchEvent):void
		{
			if(e.getTouch(this, TouchPhase.BEGAN) && _clickSound)
				_clickSound.play();
		}
		
		
		/**
		 * Layout manager object. 
		 */		
		protected var layoutManager:LayoutManager;
		
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
		}
		
		/**
		 * @inheritDoc 
		 */	
		public function setActualPivots(px:Number, py:Number):void
		{
			if(!isNaN(px))
				super.pivotX = px;
			if(!isNaN(py))
				super.pivotY = py;
		}
	}
}

