package test.loaders
{
	import com.firefly.core.assets.loaders.audio.AudioLoader;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	public class AudioLoaderTest extends EventDispatcher
	{
		private var _audioLoader:AudioLoader;
		
		[Before]
		public function prepareAudioLoader() : void 
		{
			_audioLoader = new AudioLoader("audio", "../audio/click.mp3");
		}
		
		[Test(async, timeout="1000")]
		public function loadAudio() : void 
		{
			_audioLoader.load().then(function():void
			{
				Assert.assertNotNull(_audioLoader.data);	
				
				dispatchEvent(new Event(Event.COMPLETE));
			});
			
			// wait for completion
			Async.handleEvent(this, this, Event.COMPLETE, function():void{}, 1000);
		}
		
		[Test(async, timeout="1000")]
		public function releaseLoadedData() : void 
		{
			_audioLoader.load().then(function():void
			{
				_audioLoader.release();
				
				Assert.assertNull(_audioLoader.data);	
				
				dispatchEvent(new Event(Event.COMPLETE));
			});
			
			// wait for completion
			Async.handleEvent(this, this, Event.COMPLETE, function():void{}, 1000);
		}
	}
}