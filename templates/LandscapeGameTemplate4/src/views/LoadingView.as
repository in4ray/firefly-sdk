package views
{
	import com.in4ray.gaming.components.Quad;
	import com.in4ray.gaming.components.Sprite;
	import com.in4ray.gaming.components.TextField;
	import com.in4ray.gaming.layouts.$bottom;
	import com.in4ray.gaming.layouts.$height;
	import com.in4ray.gaming.layouts.$right;
	import com.in4ray.gaming.layouts.$width;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import starling.events.Event;
	import starling.utils.HAlign;
	
	/**
	 * Loading view. Black screen with 'Loading...' message.
	 * Shows when application backs from hibernate mode.
	 */	
	public class LoadingView extends Sprite
	{
		/**
		 * Constractor. 
		 */		
		public function LoadingView()
		{
			super();
			
			var quad:Quad = new Quad(0);
			addElement(quad, $width(100).pct, $height(100).pct);
			
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
			
			timer = new Timer(500, int.MAX_VALUE);
			timer.addEventListener(TimerEvent.TIMER, animationHandler);
		}
		
		private function updateLoadingText(text:String):void
		{
			// Add Loading message
			if(!loadingMessage)
			{
				loadingMessage = new TextField(text,"Verdana", 80, 0xffffFF);
				loadingMessage.autoScale = true;
				loadingMessage.hAlign = HAlign.LEFT;
				addElement(loadingMessage, $right(8).pct, $bottom(10).pct, $width(360).rcpx, $height(60).rcpx);
			}
			else
				loadingMessage.text = text;
			
		}
		
		private var dots:String = ".";
		private var timer:Timer;
		private var loadingMessage:TextField;
		protected function animationHandler(event:TimerEvent):void
		{
			dots = "...".slice(0, (dots.length > 2 ? 0 :dots.length + 1));
			
			updateLoadingText("Loading" + dots);
		}
		
		protected function addedToStageHandler(event:Event):void
		{
			updateLoadingText("Loading" + dots)
			timer.start();
		}
		
		protected function removedFromStageHandler(event:Event):void
		{
			timer.stop();
		}
	}
}
