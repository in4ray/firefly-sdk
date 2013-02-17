package views
{
	import com.in4ray.gaming.components.Button;
	import com.in4ray.gaming.components.Image;
	import com.in4ray.gaming.components.Sprite;
	import com.in4ray.gaming.events.ViewStateEvent;
	import com.in4ray.gaming.layouts.$bottom;
	import com.in4ray.gaming.layouts.$hCenter;
	import com.in4ray.gaming.layouts.$left;
	import com.in4ray.gaming.layouts.$y;
	
	import consts.ViewStates;
	
	import sounds.SoundBundle;
	
	import starling.events.Event;
	
	import testures.MenuTextures;
	
	/**
	 * Credits view. Shows general information about application. 
	 */	
	public class CreditsView extends Sprite
	{
		private var textureBundle:MenuTextures;
		
		/**
		 * Constractor. 
		 */		
		public function CreditsView()
		{
			super();
			
			// Get reference on game Textures
			textureBundle = new MenuTextures();
			
			// Background
			addElement(new Image(textureBundle.menuBackground));
			
			// Game Name
			addElement(new Image(textureBundle.gameName), $hCenter(0), $y(60).rcpx);
			
			// Back
			var backBtn:Button = new Button(textureBundle.backUpButton, "", textureBundle.backDownButton, SoundBundle.click);
			backBtn.addEventListener(Event.TRIGGERED, backHandler);
			addElement(backBtn, $left(20).rcpx, $bottom(20).rcpx);
		}
		
		private function backHandler(e:Event):void
		{
			dispatchEvent(new ViewStateEvent(ViewStateEvent.SWITCH_TO_STATE, ViewStates.MENU));
		}
	}
}