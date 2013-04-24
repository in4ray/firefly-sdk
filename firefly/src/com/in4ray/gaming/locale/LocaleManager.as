package com.in4ray.gaming.locale
{
	import com.in4ray.gaming.binding.BindableObject;
	import com.in4ray.gaming.core.SingletonLocator;
	
	import flash.utils.Dictionary;

	/**
	 * Manager that load/unload bundles. 
	 */
	public class LocaleManager
	{
		/**
		 * Constructor. 
		 */		
		public function LocaleManager()
		{
		}
		
		/**
		 * Instance of manager. 
		 */		
		public static function getInstance():LocaleManager
		{
			return SingletonLocator.getInstance(LocaleManager);
		}
		
		private var bundles:Dictionary = new Dictionary();
		private var currenBundle:BindableObject = new BindableObject();
		
		/**
		 * Register bundle. 
		 * @param bundle LocaleBundle
		 * 
		 */		
		public function register(bundle:LocaleBundle):void
		{
			bundles[bundle.locale] = bundle;
		}
		
		/**
		 * Set current locale. 
		 * @param locale Locale code.
		 */		
		public function setLocale(locale:String):void
		{
			if(currenBundle.value)
				currenBundle.value.unload();
			
			var bundle:LocaleBundle = bundles[locale];
			if(bundle)
			{
				bundle.load();
				currenBundle.value = bundle;
			}
			else
			{
				currenBundle.value = null;
			}
		}
		
		/**
		 * Localize String. 
		 * @param text String to localize
		 * @return Localized String
		 */		
		public function localize(text:String):String
		{
			if(currenBundle.value)
				text = currenBundle.value.localize(text);
			
			return text;
		}
		
		/**
		 * Bind for locale change. 
		 * @param func Event handler.
		 */		
		public function bind(func:Function):void
		{
			currenBundle.bindListener(func);
		}
		
		/**
		 * Unbind for locale change. 
		 * @param func Event handler.
		 */		
		public function unbind(func:Function):void
		{
			currenBundle.unbindListener(func);
		}
	}
}