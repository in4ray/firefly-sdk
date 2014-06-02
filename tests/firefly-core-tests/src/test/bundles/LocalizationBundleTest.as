package test.bundles
{
	import com.firefly.core.firefly_internal;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import test.bundles.helpers.GameLocalizationBundle;
	
	use namespace firefly_internal;
	
	public class LocalizationBundleTest extends EventDispatcher
	{
		private var _localizationBundle:GameLocalizationBundle;
		
		[Before]
		public function prepareParticleBundle() : void 
		{
			_localizationBundle = new GameLocalizationBundle();
		}
		
		[Test(async, timeout="1000")]
		public function loadAndCheckLocaleField() : void 
		{
			_localizationBundle.load().then(function():void
			{
				_localizationBundle.locale = "en";
				Assert.assertNotNull(_localizationBundle.getLocaleField("exit"));	
				
				dispatchEvent(new Event(Event.COMPLETE));
			});
			
			// wait for completion
			Async.handleEvent(this, this, Event.COMPLETE, function():void{}, 1000);
		}
		
		[Test(async, timeout="1000")]
		public function loadAndCheckLocaleEnglish() : void 
		{
			_localizationBundle.load().then(function():void
			{
				_localizationBundle.locale = "en";
				Assert.assertTrue(_localizationBundle.getLocaleField("exit").str == "Exit");	
				
				dispatchEvent(new Event(Event.COMPLETE));
			});
			
			// wait for completion
			Async.handleEvent(this, this, Event.COMPLETE, function():void{}, 1000);
		}
		
		[Test(async, timeout="1000")]
		public function loadAndCheckLocaleUkrainian() : void 
		{
			_localizationBundle.load().then(function():void
			{
				_localizationBundle.locale = "en";
				_localizationBundle.locale = "ua";
				Assert.assertTrue(_localizationBundle.getLocaleField("exit").str == "Вихід");	
				
				dispatchEvent(new Event(Event.COMPLETE));
			});
			
			// wait for completion
			Async.handleEvent(this, this, Event.COMPLETE, function():void{}, 1000);
		}
	}
}