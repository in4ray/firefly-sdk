package views
{
	import com.in4ray.gaming.components.Button;
	import com.in4ray.gaming.components.Quad;
	import com.in4ray.gaming.components.Sprite;
	import com.in4ray.gaming.events.ViewStateEvent;
	import com.in4ray.gaming.layouts.$hCenter;
	import com.in4ray.gaming.layouts.$height;
	import com.in4ray.gaming.layouts.$vCenter;
	import com.in4ray.gaming.layouts.$width;
	
	import consts.ViewStates;
	
	import model.GameModel;
	
	import sounds.SoundBundle;
	
	import starling.events.Event;
	
	import testures.CommonTextures;
	import testures.MenuTextures;
	
	/**
	 * Pause popup view.
	 */	
	public class PausePopUpView extends Sprite
	{
		private var textureBundle:CommonTextures;
		private var gameModel:GameModel;
		/**
		 * Constractor. 
		 */		
		public function PausePopUpView()
		{
			super();
			
			// Get reference on game Textures
			textureBundle = new CommonTextures();
			
			gameModel = GameModel.getInstance();
			
			// Black quad background with alpha
			var quad:Quad = new Quad(0x000000);
			quad.alpha = 0.7;
			addElement(quad, $width(100).pct, $height(100).pct);
			
			// Continue
			var continueBtn:Button = new Button(textureBundle.continueUpButton, "", textureBundle.continueDownButton, SoundBundle.click);
			continueBtn.addEventListener(Event.TRIGGERED, continueHandler);
			addElement(continueBtn, $hCenter(-100).rcpx, $vCenter(200).rcpx);
			
			// Restart
			var restartBtn:Button = new Button(textureBundle.restartUpButton, "", textureBundle.restartDownButton, SoundBundle.click);
			restartBtn.addEventListener(Event.TRIGGERED, restartHandler);
			addElement(restartBtn, $hCenter(0).rcpx, $vCenter(200).rcpx);
			
			// Menu
			var menuBtn:Button = new Button(textureBundle.menuUpButton, "", textureBundle.menuDownButton, SoundBundle.click);
			menuBtn.addEventListener(Event.TRIGGERED, menuHandler);
			addElement(menuBtn, $hCenter(100).rcpx, $vCenter(200).rcpx);
			
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
		}
		
		private function continueHandler(e:Event):void
		{
			dispatchEvent(new ViewStateEvent(ViewStateEvent.CLOSE_POPUP, ViewStates.PAUSE));
		}
		
		private function restartHandler(e:Event):void
		{
			dispatchEvent(new ViewStateEvent(ViewStateEvent.SWITCH_TO_STATE, ViewStates.GAME));
			dispatchEvent(new ViewStateEvent(ViewStateEvent.CLOSE_POPUP, ViewStates.PAUSE));
		}
		
		private function menuHandler(e:Event):void
		{
			dispatchEvent(new ViewStateEvent(ViewStateEvent.SWITCH_TO_STATE, ViewStates.LEVELS));
			dispatchEvent(new ViewStateEvent(ViewStateEvent.CLOSE_POPUP, ViewStates.PAUSE));
		}
		
		private function addedToStageHandler(event:Event):void
		{
			gameModel.pause.value = true;
		}
		
		private function removedFromStageHandler():void
		{
			gameModel.pause.value = false;
		}
	}
}


