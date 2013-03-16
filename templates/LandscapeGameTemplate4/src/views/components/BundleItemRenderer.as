package views.components
{
	import com.in4ray.gaming.components.Image;
	import com.in4ray.gaming.components.Sprite;
	import com.in4ray.gaming.components.TextField;
	import com.in4ray.gaming.components.renderers.IItemRenderer;
	import com.in4ray.gaming.events.ViewStateEvent;
	import com.in4ray.gaming.layouts.$hCenter;
	import com.in4ray.gaming.layouts.$hRatio;
	import com.in4ray.gaming.layouts.$height;
	import com.in4ray.gaming.layouts.$vCenter;
	import com.in4ray.gaming.layouts.$width;
	import com.in4ray.gaming.sound.Audio;
	import com.in4ray.gaming.sound.IAudioEffect;
	
	import consts.ViewStates;
	
	import model.Bundle;
	import model.GameModel;
	
	import sounds.SoundBundle;
	
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	import testures.MenuTextures;

	public class BundleItemRenderer extends Sprite implements IItemRenderer
	{
		
		public var enabled:Boolean = true;
		private var levelName:TextField;
		private var levelLock:Image;
		
		private var bundle:Bundle;
		private var gameModel:GameModel;
		private var audioEffect:IAudioEffect;
		private var textures:MenuTextures;
		private var background:Image;
		
		public function BundleItemRenderer()
		{
			super();
			
			touchableWhereTransparent = true;
			
			gameModel = GameModel.getInstance();
			
			audioEffect = Audio.getSound(SoundBundle.click);
			
			textures = new MenuTextures();
			
			background = new Image(textures.levelBackground); 
			addElement(background, $width(400).rcpx, $height(400).rcpx);
			
			// Level lock
			levelLock = new Image(textures.levelLock); 
			addElement(levelLock, $vCenter(-30).rcpx, $hCenter(0));
			
			// Level name
			levelName = new TextField("", "Verdana", 80, 0x333333);
			levelName.autoScale = true;
			levelName.touchable = false;
			levelName.hAlign = HAlign.CENTER;
			levelName.vAlign = VAlign.CENTER;
			addElement(levelName, $vCenter(140), $hCenter(0).rcpx, $width(200).rcpx, $height(42).rcpx);
			
			addEventListener(TouchEvent.TOUCH, levelHandler);
			
			flatten();
		}
		
		public function prepare(data:Object):void
		{
			bundle = data as Bundle;
			
			update();
		}
		
		public function release():void
		{
		}
		
		
		override public function setActualPosition(x:Number, y:Number):void
		{
			super.setActualPosition(x, y);
			
			visible = (x > -parent.width && x < parent.width);
		}
		
		private function update():void
		{
			unflatten();
			
			levelName.text = !bundle.locked.value ? bundle.name : "";
			levelLock.visible = bundle.locked.value;
			
			flatten();
		}
		
		private function levelHandler(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(this, TouchPhase.ENDED);
			if (touch && !bundle.locked.value && enabled)
			{
				gameModel.currentBundle.value = bundle;
				audioEffect.play();
				dispatchEvent(new ViewStateEvent(ViewStateEvent.SWITCH_TO_STATE, ViewStates.LEVELS));
			}
		}
	}
}