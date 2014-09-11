package
{
	import com.in4ray.audio.AudioInterface;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.SampleDataEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundMixer;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	import flash.utils.setTimeout;
	
	import mx.core.ByteArrayAsset;
	
	public class AudioTest extends Sprite
	{
		private var audio:AudioInterface;
		
		[Embed(source="sounds/sound1.ogg", mimeType="application/octet-stream")]
		private static var DefaultSoundClass:Class;
		
		[Embed(source="sounds/timer.m4a", mimeType="application/octet-stream")]
		private static var TimerWavSoundClass:Class;
		
		private var defaultSoundID:int;
		
		private static const GAME_SOUND_ID:int = 1;
		private static const TIMER_SOUND_ID:int = 2;
		
		public function AudioTest()
		{
			super();
			
			// support autoOrients
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			var defaultSoundBtn:CustomSimpleButton = new CustomSimpleButton();
			defaultSoundBtn.width = 100;
			defaultSoundBtn.height = 50
			defaultSoundBtn.x = (stage.stageWidth - defaultSoundBtn.width)/2;
			defaultSoundBtn.y = (stage.stageHeight - defaultSoundBtn.height)/2;
			defaultSoundBtn.addEventListener(MouseEvent.CLICK, defaultSoundClickHandler);
			addChild(defaultSoundBtn);
			
			var timerSoundBtn:CustomSimpleButton = new CustomSimpleButton();
			timerSoundBtn.width = 100;
			timerSoundBtn.height = 50
			timerSoundBtn.x = (stage.stageWidth - timerSoundBtn.width)/2;
			timerSoundBtn.y = (stage.stageHeight - timerSoundBtn.height)/1.5;
			timerSoundBtn.addEventListener(MouseEvent.CLICK, timerSoundClickHandler);
			addChild(timerSoundBtn);
			
			loadSoundsAndMusic();
		}
		
		private var musicVolume:Number = 1.0;
		
		private function defaultSoundClickHandler(event:MouseEvent):void
		{
			//audio.playSound(defaultSoundID, 1.0, 1, 0, 1.0);
			//audio.setSoundVolume(defaultSoundID, 0.1);
				
			audio.setMusicVolume(GAME_SOUND_ID, musicVolume);
			musicVolume = musicVolume > 0.1 ? (musicVolume - 0.1) : 1.0;
			trace("isMusicPlaying = " + audio.isMusicPlaying(GAME_SOUND_ID));
		}
		
		private function timerSoundClickHandler(event:MouseEvent):void
		{
			audio.playMusic(GAME_SOUND_ID, 1.0, true);
			//audio.playMusic(TIMER_SOUND_ID, 1.0, true);
			//audio.playSound(defaultSoundID, 1.0, 1, 0, 1.0);
		}
		
		private function loadSoundsAndMusic():void
		{
			audio = new AudioInterface();
			
			// Load sound
			var bytes:ByteArrayAsset = new DefaultSoundClass();
			var defaultSoundPath:String = getSoundPath(bytes, "defaultSound.ogg");
			defaultSoundID = audio.loadSound(defaultSoundPath);
			
			// Load music
			var s2:Sound = new GameSoundClass();
			var b2:ByteArray = new ByteArray();
			s2.extract(b2,s2.length*44.1);
			b2.position = 0;
			var gameSoundPath:String = getSoundPath(WavEncoder.encode(b2), "gameSound.mp3");
			audio.loadMusic(GAME_SOUND_ID, gameSoundPath);
			
			
			var bytes2:ByteArrayAsset = new TimerWavSoundClass();
			var timerSoundPath:String = getSoundPath(bytes2, "timerSound.m4a");
			audio.loadMusic(TIMER_SOUND_ID, timerSoundPath);
		}
		
		private function getSoundPath(bytes:ByteArray, soundFileName:String):String
		{
			var fileStream:FileStream = new FileStream();
			var file:File;
			try
			{
				file = File.createTempDirectory().resolvePath(soundFileName);
				fileStream.open(file, FileMode.WRITE);
				fileStream.writeBytes(bytes);
			}
			catch(err:Error)
			{
				trace(err.getStackTrace());
			}
			finally 
			{
				fileStream.close();
			}
			
			return file.nativePath;
		}
		
	}
}



import flash.display.DisplayObject;
import flash.display.Shape;
import flash.display.SimpleButton;

class CustomSimpleButton extends SimpleButton {
	private var upColor:uint   = 0xFFCC00;
	private var overColor:uint = 0xCCFF00;
	private var downColor:uint = 0x00CCFF;
	private var size:uint      = 80;
	
	public function CustomSimpleButton() {
		downState      = new ButtonDisplayState(downColor, size);
		overState      = new ButtonDisplayState(overColor, size);
		upState        = new ButtonDisplayState(upColor, size);
		hitTestState   = new ButtonDisplayState(upColor, size * 2);
		hitTestState.x = -(size / 4);
		hitTestState.y = hitTestState.x;
		useHandCursor  = true;
	}
}

class ButtonDisplayState extends Shape {
	private var bgColor:uint;
	private var size:uint;
	
	public function ButtonDisplayState(bgColor:uint, size:uint) {
		this.bgColor = bgColor;
		this.size    = size;
		draw();
	}
	
	private function draw():void {
		graphics.beginFill(bgColor);
		graphics.drawRect(0, 0, size, size);
		graphics.endFill();
	}
}