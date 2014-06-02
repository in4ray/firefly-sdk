package test.loaders
{
	import com.firefly.core.assets.loaders.audio.EmbededAudioLoader;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	public class EmbededAudioLoaderTest extends EventDispatcher
	{
		private var _audioLoader:EmbededAudioLoader;
		
		[Before]
		public function prepareEmbededAudioLoader() : void 
		{
			_audioLoader = new EmbededAudioLoader(MenuMusicSwcClass);
		}
		
		[Test(async, timeout="1000")]
		public function loadEmbededAudio() : void 
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