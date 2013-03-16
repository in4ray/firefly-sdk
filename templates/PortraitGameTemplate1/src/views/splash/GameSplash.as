package views.splash
{
	import com.in4ray.gaming.components.flash.Splash;
	import com.in4ray.gaming.layouts.$bottom;
	import com.in4ray.gaming.layouts.$hCenter;
	import com.in4ray.gaming.layouts.$height;
	import com.in4ray.gaming.layouts.$right;
	import com.in4ray.gaming.layouts.$vCenter;
	import com.in4ray.gaming.layouts.$width;
	
	import textures.GameName;
	import textures.LoadingText;
	
	
	public class GameSplash extends Splash
	{
		
		public function GameSplash(readyToRemove:Boolean = true)
		{
			super(readyToRemove);
			
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			// Game name
			addElement(new GameName(), $vCenter(-40), $hCenter(0));
			
			// App loading message
			addElement(new LoadingText(), $right(40).rcpx, $bottom(30).rcpx, $width(191).rcpx, $height(34).rcpx);
		}
		
		override public function setActualSize(w:Number, h:Number):void
		{
			super.setActualSize(w, h);
			
			graphics.clear();
			graphics.beginFill(0);
			graphics.drawRect(0,0,w,h);
			graphics.endFill();
		}
	}
}