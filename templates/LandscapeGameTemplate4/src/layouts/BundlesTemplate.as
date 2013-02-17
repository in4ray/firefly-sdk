package layouts
{
	import com.in4ray.gaming.components.Sprite;
	import com.in4ray.gaming.core.GameGlobals;
	import com.in4ray.gaming.layouts.$vCenter;
	import com.in4ray.gaming.layouts.$width;
	import com.in4ray.gaming.layouts.$x;
	import com.in4ray.gaming.layouts.templates.Template;

	public class BundlesTemplate extends Template
	{
		public function BundlesTemplate(container:Sprite)
		{
			super(container);
			
			var contextFactor:Number = container.layoutContext.getValueWidth($width(1000).rcpx)/1000;
			padding = (GameGlobals.stageSize.x/contextFactor - 410)/2;
		}
		
		
		private var padding:Number;
		
		override protected function getElementLayouts(index:uint):Array
		{
			index--;
			return [$x(padding + 440*index).rcpx, $vCenter(-50).rcpx];
		}
	}
}