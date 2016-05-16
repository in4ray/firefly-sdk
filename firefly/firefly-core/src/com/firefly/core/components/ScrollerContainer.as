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
	
	import starling.textures.Texture;
	
	use namespace firefly_internal;

	/** The ScrollerContainer is a concrete implementation of the scroller container which has only one 
	 *  viewport for displaying inside itself. */
	public class ScrollerContainer extends ScrollerContainerBase
	{
		/** @private */		
		private var _viewport:IViewport;
		
		/** Constructor.
		 *  @param hThumbTexture Texture for horizontal thumb on the horizontal scrollbar. 
		 *  @param vThumbTexture Texture for vertical thumb on the vertical scrollbar. */		
		public function ScrollerContainer(hThumbTexture:Texture=null, vThumbTexture:Texture=null)
		{
			super(hThumbTexture, vThumbTexture);
		}
		
		/** Viewport component. */		
		public function get viewport():IViewport { return _viewport; }
		
		/** Assign viewport to the scroller container.
		 *  @param viewport Instance of the viewport.
		 *  @param layouts Layouts which will be used to place the viewport inside of the scroller. */		
		public function setViewport(viewport:IViewport, ...layouts):void
		{
			if (_viewport)
			{
				viewports.splice(viewports.indexOf(_viewport), 1);
				layout.removeElement(_viewport);
			}
			
			_viewport = viewport;
			
			viewports.push(viewport);
			layout.addElement.apply(null, [_viewport].concat(layouts));
			
			layoutScrollBars();
		}

		/** Add display object into the viewport component.
		 *  @param child Display object.
		 *  @param layouts Layouts which will be used to place the element inside of the viewport. */		
		public function addElement(child:Object, ...layouts):void
		{
			_viewport.layout.addElement.apply(null, [child].concat(layouts));
		}
		
		/** Add display object into the viewport component at specified depth.
		 *  @param child Display object.
		 * 	@param index Depth.
		 *  @param layouts Layouts which will be used to place the element inside of the viewport. */
		public function addElementAt(child:Object, index:int, ...layouts):void
		{
			_viewport.layout.addElementAt.apply(null, [child, index].concat(layouts));
		}
		
		/** Remove child component from the viewport component.
		 *  @param child Display object.
		 *  @param dispose Indicates of calling <code>dispose()</code> function after removing element. */
		public function removeElement(child:Object, dispose:Boolean=false):void
		{
			_viewport.layout.removeElement(child, dispose);
		}
		
		/** Remove child component from the viewport component by index.
		 *  @param index Index of display object.
		 *  @param dispose Indicates of calling <code>dispose()</code> function after removing element. */
		public function removeElementAt(index:int, dispose:Boolean=false):void
		{
			_viewport.layout.removeElementAt(index, dispose);
		}
	}
}