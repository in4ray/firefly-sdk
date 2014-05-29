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
	import com.firefly.core.assets.FontBundle;
	import com.firefly.core.assets.IAssetBundle;
	import com.firefly.core.async.Future;
	import com.firefly.core.utils.XMLUtil;
	
	import flash.events.Event;
	
	use namespace firefly_internal;
	
	[ExcludeClass]
	/** The loader for loading font xml asset. */
	public class FontXMLLoader extends XMLLoader
	{
		/** Constructor.
		 *  @param id Unique identifier of the loader.
		 *  @param path Path to the xml file.
		 *  @param autoScale Specifies whether use autoscale algorithm. Based on design size and stage size xml will be 
		 * 		   proportionally adjusted to stage size. E.g. design size is 1024x768 and stage size is 800x600 the formula is
		 * 		   <code>var scale:Number = Math.min(1024/800, 768/600);</code></br> 
		 * 		   Calculated scale is 1.28 and textures described in xml scale based on it. */	
		public function FontXMLLoader(id:String, path:String, autoScale:Boolean = true)
		{
			super(id, path, autoScale);
		}
		
		/** @inheritDoc */
		override public function build(visitor:IAssetBundle):Future
		{
			(visitor as FontBundle).addFontXML(_id, _xml);
			
			return null;
		}
		
		/** @private */
		override protected function onXMLLoadingComplete(event:Event):void
		{
			super.onXMLLoadingComplete(event);
			
			if (_autoScale)
				XMLUtil.adjustFontXML(_xml);
			
			_completer.complete();
		}
	}
}