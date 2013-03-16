package views
{
	import com.in4ray.gaming.components.flash.Sprite;
	
	/**
	 * Lost context view. By default black screen.
	 * Shows when application lost context.  
	 */	
	public class LostContextView extends Sprite
	{
		/**
		 * Constractor. 
		 */		
		public function LostContextView()
		{
			super();
		}
		
		/**
		 * @inheritDoc
		 */	
		override public function setActualSize(w:Number, h:Number):void
		{
			super.setActualSize(w, h);
			
			graphics.clear();
			graphics.beginFill(0);
			graphics.drawRect(0, 0, w, h)
			graphics.endFill();
		}
	}
}