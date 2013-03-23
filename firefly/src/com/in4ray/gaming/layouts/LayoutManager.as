// =================================================================================================
//
//	in4ray Gaming SDK
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.in4ray.gaming.layouts
{
	import com.in4ray.gaming.components.IVisualElement;
	
	import starling.display.DisplayObject;

	/**
	 * General layout manager. 
	 */	
	public class LayoutManager implements ILayoutManager
	{
		/**
		 * Constructor.
		 *  
		 * @param element Objaet that uses this manager.
		 */		
		public function LayoutManager(element:IVisualElement)
		{
			this.element = element;
			
			target = new LayoutTarget();
		}
		
		private var element:IVisualElement;
		
		private var target:LayoutTarget;
		
		/**
		 * @inheritDoc 
		 */		
		public function layout():void
		{
			var lastRotation:Number = element.rotation;
			element.rotation = 0;
			
			target.reset(element);
			for each (var layout:ILayout in _layouts) 
			{
				layout.layout(element.parentContext, target);
			}
			//trace(target.y)
			target.apply(element);
			
			element.rotation = lastRotation;  
		}
		
		private var _layouts:Vector.<ILayout> = new Vector.<ILayout>();
		
		/**
		 * Add list of layout constraints. 
		 */
		public function addLayouts(layouts:Array):void
		{
			for each (var layout:ILayout in layouts) 
			{
				removeLayout(layout.getGlobalFunc());
				_layouts.push(layout);
			}
			
			_layouts.sort(orderSortFunc);
		}
		
		/**
		 * @private
		 */		
		private function orderSortFunc(l1:ILayout, l2:ILayout):int
		{
			if(l1.getOrder() < l2.getOrder())
				return -1;
			else
				return 1;
		}
		
		/**
		 * Remove layout by global function.
		 *  
		 * @param layoutFunc Global function that creates layout constraint.
		 */		
		public function removeLayout(layoutFunc:Function):void
		{
			for (var i:int = 0; i < _layouts.length; i++) 
			{
				if(_layouts[i].getGlobalFunc() == layoutFunc)
				{
					_layouts.splice(i, 1);
					return;
				}
			}
		}
		
		/**
		 * Gets list of layout constraints. 
		 * 
		 * @return Vector of constraints.
		 * 
		 */		
		public function getLayouts():Vector.<ILayout>
		{
			return _layouts.slice();
		}
		
		/**
		 * Gets layout by global function.
		 * 
		 * @param layoutFunc Global function that creates layout constraint.
		 * @return Layout constraint.
		 */		
		public function getLayout(layoutFunc:Function):ILayout
		{
			for each (var layout:ILayout in _layouts) 
			{
				if(layout.getGlobalFunc() == layoutFunc)
				{
					return layout;
				}
			}
			
			return null;
		}
			
		/**
		 * Set value to layout by global function. 
		 * 
		 * @param layoutFunc Global function that creates layout constraint.
		 * @param value Layout value.
		 * @param units Layout measure units.
		 */		
		public function setLayoutValue(layoutFunc:Function, value:Number, units:String = null):void
		{
			var layout:ILayout = getLayout(layoutFunc);
			if(layout)
			{
				layout.value = value;
			}
			else
			{
				layout = layoutFunc(value);
				if(units)
					layout[units];
				
				addLayouts([layout]);
			}
			
			if(element.parentContext)
				this.layout();
		}
	}
}