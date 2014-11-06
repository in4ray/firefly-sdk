package com.firefly.core.components
{
	import com.firefly.core.firefly_internal;
	import com.firefly.core.display.IViewport;
	import com.firefly.core.utils.Log;
	
	import starling.events.Event;
	import starling.textures.Texture;
	
	use namespace firefly_internal;
	
	public class ParallaxContainer extends ScrollerContainerBase
	{
		public function ParallaxContainer(hThumbTexture:Texture=null, vThumbTexture:Texture=null)
		{
			super(hThumbTexture, vThumbTexture);
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		override public function dispose():void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			super.dispose();
		}
		
		public function addViewport(viewport:IViewport, ...layouts):void
		{
			viewports.push(viewport);
			layout.addElement.apply(null, [viewport].concat(layouts));
			
			recalculateFractions();
			layoutScrollBars();
		}
		
		public function addViewportAt(viewport:IViewport, index:int, ...layouts):void
		{
			viewports.push(viewport);
			layout.addElementAt.apply(null, [viewport, index].concat(layouts));
			
			recalculateFractions();
			layoutScrollBars();
		}
		
		public function removeViewport(viewport:IViewport, dispose:Boolean=false):void
		{
			layout.removeElement(viewport, dispose);
			viewports.splice(viewports.indexOf(viewport), 1);
			recalculateFractions();
		}
		
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
		
		public function getViewportByIndex(index:int):IViewport
		{
			return layout.getElementAt(index) as IViewport;
		}
		
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
		
		private function onAddedToStage():void
		{
			recalculateFractions();
		}
	}
}