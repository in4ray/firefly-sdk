// =================================================================================================
//
//	Firefly Framework
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.assets.loaders
{
	import com.firefly.core.firefly_internal;
	import com.firefly.core.assets.IAssetBundle;
	import com.firefly.core.assets.LocalizationBundle;
	import com.firefly.core.async.Future;
	
	import flash.events.Event;
	
	use namespace firefly_internal;
	
	[ExcludeClass]
	/** The loader for loading locale xml asset. */
	public class LocaleXMLLoader extends XMLLoader
	{
		/** Constructor.
		 *  @param id Unique identifier of the loader.
		 *  @param path Path to the xml file.
		 *  @param autoScale Specifies whether use autoscale algorithm. Based on design size and stage size xml will be 
		 * 		   proportionally adjusted to stage size. E.g. design size is 1024x768 and stage size is 800x600 the formula is
		 * 		   <code>var scale:Number = Math.min(1024/800, 768/600);</code></br> 
		 * 		   Calculated scale is 1.28 and textures described in xml scale based on it. */	
		public function LocaleXMLLoader(id:String, path:String)
		{
			super(id, path);
		}
		
		/** @inheritDoc */
		override public function build(assetBundle:IAssetBundle):Future
		{
			(assetBundle as LocalizationBundle).createLocaleBunch(_id, _xml);
			
			return null;
		}
		
		/** @private */
		override protected function onXMLLoadingComplete(event:Event):void
		{
			super.onXMLLoadingComplete(event);
			
			_completer.complete();
		}
	}
}