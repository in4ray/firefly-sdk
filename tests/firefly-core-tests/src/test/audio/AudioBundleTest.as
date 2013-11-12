package test.audio
{
	import com.firefly.core.firefly_internal;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import test.audio.helpers.GameAudioBundle;
	
	use namespace firefly_internal;
	
	public class AudioBundleTest extends EventDispatcher
	{
		private var _audioBundle:GameAudioBundle;
		
		[Before]
		public function prepareBundle() : void 
		{
			_audioBundle = new GameAudioBundle();
		}
		
		[Test(async, timeout="2000")]
		public function load() : void 
		{
			_audioBundle.load().then(function():void
			{
				Assert.assertNotNull(_audioBundle.click);	
				Assert.assertNotNull(_audioBundle.menuMusic);	
				Assert.assertNotNull(_audioBundle.embededMenuMusic);	
				
				dispatchEvent(new Event(Event.COMPLETE));
			});
			
			// wait for completion
			Async.handleEvent(this, this, Event.COMPLETE, function():void{}, 2000);
		}
	}
}