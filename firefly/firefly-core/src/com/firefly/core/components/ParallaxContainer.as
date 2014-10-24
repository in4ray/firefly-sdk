package com.firefly.core.components
{
	import com.firefly.core.firefly_internal;
	import com.firefly.core.display.IViewport;
	import com.firefly.core.layouts.constraints.ILayoutUnits;
	import com.firefly.core.utils.Log;
	
	import starling.events.Event;
	
	use namespace firefly_internal;
	
	public class ParallaxContainer extends ScrollerContainerBase
	{
		public function ParallaxContainer()
		{
			super();
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function addViewport(viewport:IViewport, ...layouts):void
		{
			viewports.push(viewport);
			layout.addElement.apply(null, [viewport].concat(layouts));
			updateVieportFractions();
		}
		
		public function addViewportAt(viewport:IViewport, index:int, viewportWidth:ILayoutUnits=null, viewportHeight:ILayoutUnits=null):void
		{
			viewports.push(viewport);
			layout.addElementAt.apply(null, prepareParams(viewportWidth, viewportHeight, [viewport, index]));
			updateVieportFractions();
		}
		
		public function removeViewport(viewport:IViewport, dispose:Boolean=false):void
		{
			layout.removeElement(viewport, dispose);
			viewports.splice(viewports.indexOf(viewport), 1);
			updateVieportFractions();
		}
		
		public function removeViewportAt(index:int, dispose:Boolean=false):void
		{
			var viewport:IViewport = layout.getElementAt(index) as IViewport;
			if (viewport)
			{
				removeViewport(viewport, dispose);
				updateVieportFractions();
			}
			else
			{
				CONFIG::debug {
					Log.error("Viewport with {0} index is not found.", index);
				};
			}
		}
		
		public function removeViewportById(id:String, dispose:Boolean=false):void
		{
			var viewport:IViewport = getViewportById(id);
			if (viewport)
			{
				removeViewport(viewport, dispose);
				updateVieportFractions();				
			}
		}
		
		public function getViewportById(id:String):IViewport
		{
			for each (var viewport:IViewport in viewports)
			{
				if (viewport.id == id)
					return viewport;
			}
			
			CONFIG::debug {
				Log.error("Viewport {0} is not found.", id);
			};
			
			return null
		}
		
		public function getViewportByIndex(index:int):IViewport
		{
			return layout.getElementAt(index) as IViewport;
		}
		
		public function addElement(viewportId:String, child:Object, ...layouts):void
		{
			var viewport:IViewport = getViewportById(viewportId);
			if (viewport)
			{
				viewport.layout.addElement.apply(null, [child].concat(layouts));
				updateVieportFractions();
			}
		}
		
		public function addElementAt(viewportId:String, child:Object, index:int, ...layouts):void
		{
			var viewport:IViewport = getViewportById(viewportId);
			if (viewport)
			{
				viewport.layout.addElementAt.apply(null, [child, index].concat(layouts));
				updateVieportFractions();
			}
		}
		
		public function removeElement(viewportId:String, child:Object, dispose:Boolean=false):void
		{
			var viewport:IViewport = getViewportById(viewportId);
			if (viewport)
			{
				viewport.layout.removeElement(child, dispose);
				updateVieportFractions();
			}
		}
		
		public function removeElementAt(viewportId:String, index:int, dispose:Boolean=false):void
		{
			var viewport:IViewport = getViewportById(viewportId);
			if (viewport)
			{
				viewport.layout.removeElementAt(index, dispose);
				updateVieportFractions();
			}
		}
		
		private function updateVieportFractions():void
		{
			var maxWidth:int = int.MIN_VALUE;
			var maxHeight:int = int.MIN_VALUE;
			
			// search vieport with max width to set "1" fraction
			viewports.forEach(function (viewport:IViewport, index:int, args:Vector.<IViewport>):void
			{
				maxWidth = Math.max(maxWidth, viewport.width);
				maxHeight = Math.max(maxHeight, viewport.height);
			});
			
			viewports.forEach(function (viewport:IViewport, index:int, args:Vector.<IViewport>):void
			{
				viewport.hFraction = viewport.width/maxWidth;
				viewport.vFraction = viewport.height/maxHeight;
			});
		}
		
		private function onAddedToStage():void
		{
			updateVieportFractions();
		}
	}
}