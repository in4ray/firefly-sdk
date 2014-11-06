package com.firefly.core.components
{
	import com.firefly.core.display.IHScrollBar;
	
	import starling.display.Image;
	import starling.textures.Texture;
	
	public class DefaultHScrollBar extends Component implements IHScrollBar
	{
		private var _thumb:Image;
		
		public function DefaultHScrollBar(thumbTexture:Texture)
		{
			super();
			
			_thumb = new Image(thumbTexture);
			layout.addElement(_thumb);
		}
		
		public function get thumb():Image { return _thumb; }
		public function get thumbWidth():Number { return _thumb.width; }
		
		public function set thumbX(value:Number):void { _thumb.x = value; }
	}
}