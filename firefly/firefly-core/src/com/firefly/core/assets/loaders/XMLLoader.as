// =================================================================================================
//
//	Firefly Framework
//	Copyright 2016 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.assets.loaders
{
	import com.firefly.core.assets.IAssetBundle;
	import com.firefly.core.async.Completer;
	import com.firefly.core.async.Future;
	import com.firefly.core.utils.Log;
	
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.geom.Point;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	[ExcludeClass]
	/** The basic class for loading xml asset. */
	public class XMLLoader
	{
		/** @private */
		protected var _completer:Completer;
		/** @private */
		protected var _id:String
		/** @private */
		protected var _path:String;
		/** @private */
		protected var _autoScale:Boolean;
		/** @private */
		protected var _xmlLoader:URLLoader;
		/** @private */
		protected var _xml:XML;
		
		/** Constructor.
		 * 
		 *  @param id Unique identifier of the loader.
		 *  @param path Path to the xml file.
		 *  @param autoScale Specifies whether use autoscale algorithm. Based on design size and stage size xml will be 
		 * 		   proportionally adjusted to stage size. E.g. design size is 1024x768 and stage size is 800x600 the formula is
		 * 		   <code>var scale:Number = Math.min(1024/800, 768/600);</code></br> 
		 * 		   Calculated scale is 1.28 and textures described in xml scale based on it. */	
		public function XMLLoader(id:String, path:String, autoScale:Boolean = true)
		{
			this._id = id;
			this._path = path;
			this._autoScale = autoScale;
		}
		
		/** Unique identifier. */
		public function get id():* { return _id; }
		
		/** Loaded xml. */
		public function get xml():XML { return _xml; }
		
		public function load(canvas:BitmapData=null, position:Point=null):Future
		{
			_completer = new Completer();
			
			_xmlLoader = new URLLoader();
			_xmlLoader.addEventListener(Event.COMPLETE, onXMLLoadingComplete);
			_xmlLoader.addEventListener(IOErrorEvent.IO_ERROR, onIoError);
			_xmlLoader.load(new URLRequest(_path));
			
			return _completer.future;
		}
		
		/** Unload loaded data. */	
		public function release():void
		{
			if (_xmlLoader)
			{
				_xmlLoader.removeEventListener(Event.COMPLETE, onXMLLoadingComplete);
				_xmlLoader.removeEventListener(IOErrorEvent.IO_ERROR, onIoError);	
				_xmlLoader = null;
			}
			
			_xml = null;
		}
		
		/** Build xml from the loaded data.
		 * 	@param assetBundle Asset bundle.
		 *  @return Future object for callback.*/
		public function build(assetBundle:IAssetBundle):Future { return null; }
		
		/** @private */
		protected function onIoError(event:IOErrorEvent):void
		{
			Log.error("Loading xml IO error: {0}", event.text);
			_completer.complete();
		}
		
		/** @private */
		protected function onXMLLoadingComplete(event:Event):void
		{
			_xml = new XML(_xmlLoader.data);
		}
	}
}