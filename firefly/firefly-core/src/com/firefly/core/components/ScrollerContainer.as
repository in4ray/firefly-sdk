package com.firefly.core.components
{
	public class ScrollerContainer extends ScrollerContainerBase
	{
		private var _viewport:Viewport;
		
		public function ScrollerContainer()
		{
			super();
			
			_viewport = new Viewport("viewport1");
			viewports.push(_viewport);
			layout.addElement(_viewport);
		}
		
		public function addElement(child:Object, ...layouts):void
		{
			_viewport.layout.addElement.apply(null, [child].concat(layouts));
		}
		
		public function addElementAt(child:Object, index:int, ...layouts):void
		{
			_viewport.layout.addElementAt.apply(null, [child, index].concat(layouts));
		}
		
		public function removeElement(child:Object):void
		{
			_viewport.layout.removeElement(child);
		}
		
		public function removeElementAt(index:int):void
		{
			_viewport.layout.removeElementAt(index);
		}
	}
}