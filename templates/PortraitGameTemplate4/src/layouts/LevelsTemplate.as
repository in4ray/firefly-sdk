package layouts
{
	import com.in4ray.gaming.components.Sprite;
	import com.in4ray.gaming.core.GameGlobals;
	import com.in4ray.gaming.layouts.$width;
	import com.in4ray.gaming.layouts.$x;
	import com.in4ray.gaming.layouts.$y;
	import com.in4ray.gaming.layouts.templates.Template;
	
	public class LevelsTemplate extends Template
	{
		public function LevelsTemplate(container:Sprite)
		{
			super(container);
			
			contextFactor = container.layoutContext.getValueWidth($width(1000).rcpx)/1000;
			paddingLeft = (GameGlobals.stageSize.x/contextFactor - (SIZE + GAP)*COLS)/2;
			paddingTop = (GameGlobals.stageSize.y/contextFactor - (SIZE + GAP)*ROWS)/2 - 30;
		}
		
		private var paddingLeft:Number;
		private var paddingTop:Number;
		
		private const COLS:uint = 3;
		private const ROWS:uint = 5;
		private const GAP:uint = 20;
		private const SIZE:uint = 120;

		private var contextFactor:Number;
		
		override protected function getElementLayouts(index:uint):Array
		{
			index--;
			
			var paddingX:Number = paddingLeft + Math.floor(index/(COLS*ROWS))*(GameGlobals.stageSize.x/contextFactor);
			var posX:Number = paddingX + index%COLS*(SIZE + GAP);
			var posY:Number = paddingTop + Math.floor(index/COLS)%ROWS*(SIZE + GAP);
			
			return [$x(posX).rcpx, $y(posY).rcpx];
		}
	}
}