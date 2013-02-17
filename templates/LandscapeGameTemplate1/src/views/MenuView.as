package views
{
	import com.in4ray.gaming.analytics.IAnalytics;
	import com.in4ray.gaming.components.Button;
	import com.in4ray.gaming.components.Image;
	import com.in4ray.gaming.components.Sprite;
	import com.in4ray.gaming.components.TextField;
	import com.in4ray.gaming.components.ToggleButton;
	import com.in4ray.gaming.consts.SystemType;
	import com.in4ray.gaming.core.GameGlobals;
	import com.in4ray.gaming.core.SingletonLocator;
	import com.in4ray.gaming.events.ViewStateEvent;
	import com.in4ray.gaming.layouts.$bottom;
	import com.in4ray.gaming.layouts.$hCenter;
	import com.in4ray.gaming.layouts.$left;
	import com.in4ray.gaming.layouts.$right;
	import com.in4ray.gaming.layouts.$vCenter;
	import com.in4ray.gaming.layouts.$y;
	import com.in4ray.gaming.layouts.context.BasicLayoutContext;
	
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import consts.GameURLs;
	import consts.ViewStates;
	
	import model.GameModel;
	
	import sounds.SoundBundle;
	
	import starling.events.Event;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	import testures.MenuTextures;
	
	/**
	 * Game menu view. 
	 */	
	public class MenuView extends Sprite
	{

		private var play:TextField;

		private var credits:TextField;
		
		private var textureBundle:MenuTextures;
		
		private var gameModel:GameModel;
		
		private var analytics:IAnalytics;
		
		/**
		 * Constractor. 
		 */		
		public function MenuView()
		{
			super();
			
			// Set default menu view layout context aligment as BOTTOM
			layoutContext = new BasicLayoutContext(this, HAlign.CENTER, VAlign.BOTTOM);
			
			gameModel = GameModel.getInstance();
			
			analytics = SingletonLocator.getInstance(IAnalytics);
			
			// Get reference on game Textures
			textureBundle = new MenuTextures();
			
			// Background
			addElement(new Image(textureBundle.menuBackground));
			
			// Game Name
			addElement(new Image(textureBundle.gameName), $hCenter(0), $y(60).rcpx);
			
			// Play
			var playBtn:Button = new Button(textureBundle.playUpButton, "", textureBundle.playDownButton, SoundBundle.click);
			playBtn.addEventListener(Event.TRIGGERED, playHandler);
			addElement(playBtn, $hCenter(0), $vCenter(0));
			
			// Sound
			var soundBtn:ToggleButton = new ToggleButton(textureBundle.soundOnUpButton, textureBundle.soundOffUpButton, "", "", textureBundle.soundOnDownButton, textureBundle.soundOffDownButton, SoundBundle.click);
			soundBtn.addEventListener(Event.TRIGGERED, soundHandler);
			addElement(soundBtn, $right(380).rcpx, $bottom(20).rcpx);
			
			// More
			var moreBtn:Button = new Button(textureBundle.moreUpButton, "", textureBundle.moreDownButton, SoundBundle.click);
			moreBtn.addEventListener(Event.TRIGGERED, moreHandler);
			addElement(moreBtn, $right(290).rcpx, $bottom(20).rcpx);
			
			// Credits
			var creditsBtn:Button = new Button(textureBundle.creditsUpButton, "", textureBundle.creditsDownButton, SoundBundle.click);
			creditsBtn.addEventListener(Event.TRIGGERED, creditsHandler);
			addElement(creditsBtn, $right(200).rcpx, $bottom(20).rcpx);
			
			// Facebook
			var facebookBtn:Button = new Button(textureBundle.facebookUpButton, "", textureBundle.facebookDownButton, SoundBundle.click);
			facebookBtn.addEventListener(Event.TRIGGERED, facebookHandler);
			addElement(facebookBtn, $right(110).rcpx, $bottom(20).rcpx);
			
			// Twitter
			var twitterBtn:Button = new Button(textureBundle.twitterUpButton, "", textureBundle.twitterDownButton, SoundBundle.click);
			twitterBtn.addEventListener(Event.TRIGGERED, twitterHandler);
			addElement(twitterBtn, $right(20).rcpx, $bottom(20).rcpx);
			
			// Exit
			//if(GameGlobals.systemType != SystemType.IOS)
			{
				var exitBtn:Button = new Button(textureBundle.closeUpButton, "", textureBundle.closeDownButton, SoundBundle.click);
				exitBtn.addEventListener(Event.TRIGGERED, exitHandler);
				addElement(exitBtn, $left(20).rcpx, $bottom(20).rcpx);
			}
		}
		
		private function playHandler(e:Event):void
		{
			analytics.log("Menu", "Play");
			dispatchEvent(new ViewStateEvent(ViewStateEvent.SWITCH_TO_STATE, ViewStates.GAME));
		}
		
		private function soundHandler(e:Event):void
		{
			gameModel.muteSounds = (e.currentTarget as ToggleButton).selected;
		}
		
		private function moreHandler(e:Event):void
		{
			analytics.log("Menu", "More");
			navigateToURL(new URLRequest(GameURLs.MORE_URL), "_blank");
		}
		
		private function creditsHandler(e:Event):void
		{
			analytics.log("Menu", "Credits");
			dispatchEvent(new ViewStateEvent(ViewStateEvent.SWITCH_TO_STATE, ViewStates.CREDITS));
		}
		
		private function twitterHandler(e:Event):void
		{
			navigateToURL(new URLRequest(GameURLs.TWITTER_URL), "_blank");
		}
		
		private function facebookHandler():void
		{
			navigateToURL(new URLRequest(GameURLs.FACEBOOK_URL), "_blank");
		}
		
		private function exitHandler(e:Event):void
		{
			dispatchEvent(new ViewStateEvent(ViewStateEvent.OPEN_POPUP, ViewStates.EXIT));
		}
	}
}