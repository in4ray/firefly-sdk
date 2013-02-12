// =================================================================================================
//
//	in4ray Gaming SDK
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.in4ray.gaming.components.renderers
{
	import com.in4ray.gaming.binding.BindableArray;
	import com.in4ray.gaming.components.IVisualContainer;
	import com.in4ray.gaming.events.BindingEvent;
	import com.in4ray.gaming.utils.ClassFactory;
	
	/**
	 *  This manager used to create and add item renderers for each data item in dataProvider array. 
	 */	
	public class DataRenderer
	{
		/**
		 * Constructor.
		 *  
		 * @param container Container that holds item renderers. 
		 * @param itemRenderer ClassFactory object that creates item renderers, 
		 * they should implement <code>com.in4ray.games.core.components.renderer.IItemRenderer</code> interface.
		 */		
		public function DataRenderer(container:IVisualContainer, itemRenderer:ClassFactory=null)
		{
			_itemRenderer = itemRenderer;
			_container = container;
		}
		
		private var _container:IVisualContainer;
		
		/**
		 * Container that holds item renderers. 
		 */		
		public function get container():IVisualContainer
		{
			return _container;
		}
		
		private var _dataProvider:BindableArray;
		
		public function get dataProvider():BindableArray
		{
			return _dataProvider;
		}
		
		/**
		 * Bindable array of data items. 
		 */		
		public function set dataProvider(value:BindableArray):void
		{
			if(_dataProvider)
				_dataProvider.unbindListener(dataProviderChanged);
			
			_dataProvider = value;
			
			if(_dataProvider)
				_dataProvider.bindListener(dataProviderChanged);
		}
		
		private var _itemRendererFunction:Function;
		
		/**
		 * Function that will be called to create renderer for each data item.
		 * 
		 * Format:
		 * </br> 
		 * <code>itemRendererFunction(recycle:Vector.&lt;IItemRenderer&gt;, index:int):IItemRenderer</code>
		 */		
		public function get itemRendererFunction():Function
		{
			return _itemRendererFunction;
		}
		
		public function set itemRendererFunction(value:Function):void
		{
			if(_itemRendererFunction != value)
			{
				_itemRendererFunction = value;
				
				render();
			}
		}
		
		private var _itemRenderer:ClassFactory;
		
		/**
		 * ClassFactory object that creates item renderers, 
		 * they should implement <code>com.in4ray.games.core.components.renderer.IItemRenderer</code> interface. 
		 */		
		public function get itemRenderer():ClassFactory
		{
			return _itemRenderer;
		}
		
		public function set itemRenderer(value:ClassFactory):void
		{
			if(_itemRenderer != value)
			{
				_itemRenderer = value;
				
				render();
			}
		}
		
		/**
		 * @private
		 * Data provider change handler. 
		 */		
		protected function dataProviderChanged(event:BindingEvent):void
		{
			render();
		}
		
		private var renderers:Vector.<IItemRenderer> = new Vector.<IItemRenderer>();
		
		/**
		 * Create renderers for each data item. 
		 */		
		protected function render():void
		{
			if(!_itemRenderer && itemRendererFunction == null)
				return;
			
			var itemRenderer:IItemRenderer;
			
			var recycle:Vector.<IItemRenderer> = renderers.slice();
			renderers.length = 0;
			
			if(itemRendererFunction != null)
				prepareRenderersFromFunction(recycle);
			else
				prepareRenderers(recycle);
			
			for (var i:int = 0; i < renderers.length; i++) 
			{
				itemRenderer = renderers[i];
				
				itemRenderer.prepare(dataProvider.value[i]);
				container.addElement(itemRenderer);
			}
		}
		
		private function prepareRenderers(recycle:Vector.<IItemRenderer>):void
		{
			var itemRenderer:IItemRenderer;
			var numRequested:int = dataProvider ? dataProvider.length : 0;
			var numExisted:int = recycle.length;
			for (var i:int = 0; i < Math.max(numRequested, numExisted); i++) 
			{
				itemRenderer = null;
				
				if(i < numExisted)
				{
					itemRenderer = recycle[i];
					container.removeElement(itemRenderer);
					itemRenderer.release();
				}
				
				if(i < numRequested)
					renderers.push(itemRenderer ? itemRenderer : _itemRenderer.newInstance());
			}
		}
		
		private function prepareRenderersFromFunction(recycle:Vector.<IItemRenderer>):void
		{
			var numRequested:int = dataProvider ? dataProvider.length : 0;
			
			for (var i:int = 0; i < numRequested; i++) 
			{
				var itemRenderer:IItemRenderer = itemRendererFunction(recycle, i);
				
				var index:int = recycle.indexOf(itemRenderer);
				if(index != -1)
				{
					recycle.splice(index, 1);
					itemRenderer.release();
				}
				
				renderers.push(itemRenderer);
			}
			
			for each (itemRenderer in recycle) 
			{
				itemRenderer.release();
			}
			
			recycle.length = 0;
			
		}
	}
}