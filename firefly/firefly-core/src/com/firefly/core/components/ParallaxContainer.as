package com.firefly.core.components
{
	import com.firefly.core.utils.Log;
	
	public class ParallaxContainer extends ScrollerContainerBase
	{
		public function ParallaxContainer()
		{
			super();
		}
		
		public function addViewport(id:String, moveMultiplier:int=1):Viewport
		{
			var viewport:Viewport = new Viewport(id, moveMultiplier);
			viewports.push(viewport);
			layout.addElement(viewport);
			return viewport;
		}
		
		public function addViewportAt(id:String, index:int, moveMultiplier:int=1):Viewport
		{
			var viewport:Viewport = new Viewport(id, moveMultiplier);
			viewports.push(viewport);
			layout.addElementAt(viewport, index);
			return viewport;
		}
		
		public function removeViewport(viewport:Viewport):void
		{
			layout.removeElement(viewport);
			viewports.splice(viewports.indexOf(viewport), 1);
		}
		
		public function removeViewportAt(index:int):void
		{
			var viewport:Viewport = layout.getElementAt(index) as Viewport;
			if (viewport)
			{
				removeViewport(viewport);
			}
			else
			{
				CONFIG::debug {
					Log.error("Viewport with {0} index is not found.", index);
				};
			}
		}
		
		public function removeViewportById(id:String):void
		{
			var viewport:Viewport = getViewportById(id);
			if (viewport)
				removeViewport(viewport);
		}
		
		public function getViewportById(id:String):Viewport
		{
			for each (var viewport:Viewport in viewports)
			{
				if (viewport.id == id)
					return viewport;
			}
			
			CONFIG::debug {
				Log.error("Viewport {0} is not found.", id);
			};
			
			return null
		}
		
		public function addElement(viewport:Viewport, child:Object, ...layouts):void
		{
			viewport.layout.addElement.apply(null, [child].concat(layouts));
		}
		
		public function addElementAt(viewport:Viewport, child:Object, index:int, ...layouts):void
		{
			viewport.layout.addElementAt.apply(null, [child, index].concat(layouts));
		}
		
		public function addElementByViewportIdAt(id:String, child:Object, index:int, ...layouts):void
		{
			var viewport:Viewport = getViewportById(id);
			if (viewport)
				viewport.layout.addElementAt.apply(null, [child, index].concat(layouts));
		}
	}
}