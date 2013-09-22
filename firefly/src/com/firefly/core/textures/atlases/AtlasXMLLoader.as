// =================================================================================================
//
//	Firefly Framework
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.textures.atlases
{
	import com.firefly.core.firefly_internal;
	import com.firefly.core.async.Completer;
	import com.firefly.core.async.Future;
	import com.firefly.core.textures.TextureBundle;
	import com.firefly.core.textures.loaders.ITextureLoader;
	import com.firefly.core.utils.Log;
	import com.firefly.core.utils.XMLUtil;
	
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.geom.Point;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	use namespace firefly_internal;
	
	[ExcludeClass]
	/** The loader for loading atlas xml asset. */
	public class AtlasXMLLoader implements ITextureLoader
	{
		private var _completer:Completer;
		private var _id:String
		private var _path:String;
		private var _autoScale:Boolean;
		private var _xmlLoader:URLLoader;
		private var _xml:XML;
		
		/** Constructor.
		 * 
		 *  @param id Unique identifier of the loader.
		 *  @param path Path to the xml file.
		 *  @param autoScale Specifies whether use autoscale algorithm. Based on design size and stage size xml will be 
		 * 		   proportionally adjusted to stage size. E.g. design size is 1024x768 and stage size is 800x600 the formula is
		 * 		   <code>var scale:Number = Math.min(1024/800, 768/600);</code></br> 
		 * 		   Calculated scale is 1.28 and textures described in xml scale based on it. */		
		public function AtlasXMLLoader(id:String, path:String, autoScale:Boolean = true)
		{
			this._id = id;
			this._path = path;
			this._autoScale = autoScale;
		}
		
		/** Unique identifier. */
		public function get id():* { return _id; }
		
		/** Loaded xml. */
		public function get xml():XML { return _xml; }
		
		/** Load xml asynchronously. 
		 *  @return Future object for callback.*/
		public function load(canvas:BitmapData = null, position:Point = null):Future
		{
			_completer = new Completer();
			
			_xmlLoader = new URLLoader();
			_xmlLoader.addEventListener(Event.COMPLETE, onUrlLoaderComplete);
			_xmlLoader.addEventListener(IOErrorEvent.IO_ERROR, onIoError);
			_xmlLoader.load(new URLRequest(_path));
			
			return _completer.future;
		}
		
		/** Unload loaded data. */	
		public function unload():void
		{
			if (_xmlLoader)
			{
				_xmlLoader.removeEventListener(Event.COMPLETE, onUrlLoaderComplete);
				_xmlLoader.removeEventListener(IOErrorEvent.IO_ERROR, onIoError);	
				_xmlLoader = null;
			}
			
			_xml = null;
		}
		
		/** Build xml from the loaded data.
		 * 	@param visitor Texture bundle.
		 *  @return Future object for callback.*/
		public function build(visitor:TextureBundle):Future
		{
			return null;
		}
		
		/** @private */
		private function onIoError(event:IOErrorEvent):void
		{
			Log.error("Loading xml IO error: {0}", event.text);
			_completer.complete();
		}
		
		/** @private */
		private function onUrlLoaderComplete(event:Event):void
		{
			_xml = new XML(_xmlLoader.data);
			
			if (_autoScale)
				XMLUtil.adjustAtlasXML(_xml);
			
			_completer.complete();
		}
	}
}