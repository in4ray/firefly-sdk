package com.firefly.core.components
{
	import com.firefly.core.display.IVScrollBar;
	
	import starling.display.Image;
	import starling.textures.Texture;
	
	public class DefaultVScrollBar extends Component implements IVScrollBar
	{
		private var _thumb:Image;
		
		public function DefaultVScrollBar(thumbTexture:Texture)
		{
			super();
			
			_thumb = new Image(thumbTexture);
			layout.addElement(_thumb);
		}
		
		public function get thumb():Image { return _thumb; }
		public function get thumbHeight():Number { return _thumb.height; }
		
		public function set thumbY(value:Number):void { _thumb.y = value; }
	}
}