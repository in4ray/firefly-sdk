// =================================================================================================
//
//	Firefly Framework
//	Copyright 2016 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.components
{
	import com.firefly.core.firefly_internal;
	import com.firefly.core.display.IViewport;
	import com.firefly.core.utils.Log;
	
	import starling.events.Event;
	import starling.textures.Texture;
	
	use namespace firefly_internal;
	
	/** The ParallaxContainer is a concrete implementation of the scroller container which has several 
	 *  viewports for displaying them inside itself. */
	public class ParallaxContainer extends ScrollerContainerBase
	{
		/** Constructor.
		 *  @param hThumbTexture Texture for horizontal thumb on the horizontal scrollbar. 
		 *  @param vThumbTexture Texture for vertical thumb on the vertical scrollbar. */
		public function ParallaxContainer(hThumbTexture:Texture=null, vThumbTexture:Texture=null)
		{
			super(hThumbTexture, vThumbTexture);
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		/** @inheritDoc */		
		override public function dispose():void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			super.dispose();
		}
		
		/** Add viewport to the scroller.
		 *  @param viewport Instance of the viewport.
		 *  @param layouts Layouts which will be used to place the viewport inside of the scroller. */		
		public function addViewport(viewport:IViewport, ...layouts):void
		{
			viewports.push(viewport);
			layout.addElement.apply(null, [viewport].concat(layouts));
			
			recalculateFractions();
			layoutScrollBars();
		}
		
		/** Add new viewport to the scroller at specified depth.
		 *  @param viewport Instance of the viewport.
		 *  @param index Depth.
		 *  @param layouts Layouts which will be used to place the viewport inside of the scroller. */
		public function addViewportAt(viewport:IViewport, index:int, ...layouts):void
		{
			viewports.push(viewport);
			layout.addElementAt.apply(null, [viewport, index].concat(layouts));
			
			recalculateFractions();
			layoutScrollBars();
		}
		
		/** Remove viewport from the scroller.
		 *  @param viewport Instance of the viewport.
		 *  @param dispose Indicates of calling <code>dispose()</code> function after removing viewport. */
		public function removeViewport(viewport:IViewport, dispose:Boolean=false):void
		{
			layout.removeElement(viewport, dispose);
			viewports.splice(viewports.indexOf(viewport), 1);
			recalculateFractions();
		}
		
		/** Remove viewport from the scroller by index.
		 *  @param index Index of viewport.
		 *  @param dispose Indicates of calling <code>dispose()</code> function after removing viewport. */
		public function removeViewportAt(index:int, dispose:Boolean=false):void
		{
			var viewport:IViewport = layout.getElementAt(index) as IViewport;
			if (viewport)
			{
				removeViewport(viewport, dispose);
				recalculateFractions();
			}
			else
			{
				CONFIG::debug {
					Log.error("Viewport with {0} index is not found.", index);
				};
			}
		}
		
		/** Find and return viewport by index.
		 *  @param index Index of viewport.
		 *  @return Found viewport.  */		
		public function getViewportByIndex(index:int):IViewport
		{
			return layout.getElementAt(index) as IViewport;
		}
		
		/** @private
		 *  Invokes after adding/removing viewports. */		
		private function recalculateFractions():void
		{
			var maxWidth:int = 1;
			var maxHeight:int = 1;
			// search vieport with max width to set "1" fraction
			viewports.forEach(function (viewport:IViewport, index:int, args:Vector.<IViewport>):void
			{
				maxWidth = Math.max(maxWidth, viewport.width - width);
				maxHeight = Math.max(maxHeight, viewport.height - height);
			});
			
			viewports.forEach(function (viewport:IViewport, index:int, args:Vector.<IViewport>):void
			{
				viewport.hFraction = (viewport.width - width) / maxWidth;
				viewport.vFraction = (viewport.height - height) / maxHeight;
			});
		}
		
		/** @private */	
		private function onAddedToStage(e:Event):void
		{
			recalculateFractions();
		}
	}
}