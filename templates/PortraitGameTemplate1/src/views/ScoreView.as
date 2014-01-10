package views
{
	import com.in4ray.gaming.components.Button;
	import com.in4ray.gaming.components.Image;
	import com.in4ray.gaming.components.Quad;
	import com.in4ray.gaming.components.Sprite;
	import com.in4ray.gaming.components.TextField;
	import com.in4ray.gaming.events.ViewStateEvent;
	import com.in4ray.gaming.layouts.$hCenter;
	import com.in4ray.gaming.layouts.$height;
	import com.in4ray.gaming.layouts.$vCenter;
	import com.in4ray.gaming.layouts.$width;
	
	import consts.ViewStates;
	
	import sounds.SoundBundle;
	
	import starling.events.Event;
	
	import textures.CommonTextures;
	import textures.MenuTextures;
	
	/**
	 * Game score view. Show user score (number of killed zombies) after each game session. 
	 */	
	public class ScoreView extends Sprite
	{
		private var menuTextureBundle:MenuTextures;
		private var commonTextureBundle:CommonTextures;
		
		private var scoreTxt:TextField;
		
		/**
		 * Constractor. 
		 */		
		public function ScoreView()
		{
			super();
			
			// Get reference on game Textures
			menuTextureBundle = new MenuTextures();
			commonTextureBundle = new CommonTextures();
			
			// Background
			addElement(new Image(menuTextureBundle.menuBackground));
			
			// Black quad background with alpha
			var quad:Quad = new Quad(0x000000);
			quad.alpha = 0.7;
			addElement(quad, $width(100).pct, $height(100).pct);
			
			// Restart
			var restartBtn:Button = new Button(commonTextureBundle.restartUpButton, "", commonTextureBundle.restartDownButton, new SoundBundle().click);
			restartBtn.addEventListener(Event.TRIGGERED, restartHandler);
			addElement(restartBtn, $hCenter(-60).rcpx, $vCenter(200).rcpx);
			
			// Menu
			var menuBtn:Button = new Button(commonTextureBundle.menuUpButton, "", commonTextureBundle.menuDownButton, new SoundBundle().click);
			menuBtn.addEventListener(Event.TRIGGERED, menuHandler);
			addElement(menuBtn, $hCenter(60).rcpx, $vCenter(200).rcpx);
			
		}
		
		private function restartHandler(e:Event):void
		{
			dispatchEvent(new ViewStateEvent(ViewStateEvent.SWITCH_TO_STATE, ViewStates.GAME));
			dispatchEvent(new ViewStateEvent(ViewStateEvent.CLOSE_POPUP, ViewStates.PAUSE));
		}
		
		private function menuHandler(e:Event):void
		{
			dispatchEvent(new ViewStateEvent(ViewStateEvent.SWITCH_TO_STATE, ViewStates.MENU));
			dispatchEvent(new ViewStateEvent(ViewStateEvent.CLOSE_POPUP, ViewStates.PAUSE));
		}
	}
}
