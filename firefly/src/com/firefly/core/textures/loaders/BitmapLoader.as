// =================================================================================================
//
//	Firefly Framework
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.textures.loaders
{
	import com.firefly.core.firefly_internal;
	import com.firefly.core.async.Completer;
	import com.firefly.core.async.Future;
	import com.firefly.core.layouts.LayoutContext;
	import com.firefly.core.textures.TextureBundle;
	import com.firefly.core.utils.Log;
	import com.firefly.core.utils.TextureUtil;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.geom.Point;
	import flash.net.URLRequest;
	import flash.system.ImageDecodingPolicy;
	import flash.system.LoaderContext;

	use namespace firefly_internal;
	
	[ExcludeClass]
	/** The loader for loading bitmap asset (PNG/JPEG). */
	public class BitmapLoader implements ITextureLoader
	{
		private var _completer:Completer;
		private var _id:String;
		private var _path:String;
		private var _autoScale:Boolean;
		private var _checkPolicyFile:Boolean;
		private var _bitmapLoader:Loader;
		private var _bitmapData:BitmapData;
		private var _layoutContext:LayoutContext;
		private var _canvas:BitmapData;
		private var _position:Point;
		
		/** Constructor.
		 * 
		 *  @param id Unique identifier of the loader.
		 *  @param path Path to the bitmap file.
		 *  @param autoScale Specifies whether use autoscale algorithm. Based on design size and stage size texture will be 
		 * 		   proportionally scale to stage size. E.g. design size is 1024x768 and stage size is 800x600 the formula is
		 * 		   <code>var scale:Number = Math.min(1024/800, 768/600);</code></br> 
		 * 		   Calculated scale is 1.28 and all bitmaps scale based on it.
		 *  @param keepStageAspectRatio Specifies whether keep stage aspect ration. This property has effect to cropping of bitmap data. 
		 *  @param vAlign Vertical align type.
		 *  @param hAlign Horizontal align type.
		 *  @param checkPolicyFile Specifies whether the application should attempt to download a URL 
		 * 		   policy file from the loaded object's server before beginning to load the object itself. */		
		public function BitmapLoader(id:String, path:String, autoScale:Boolean = true, keepStageAspectRatio:Boolean = false, 
									 vAlign:String = "", hAlign:String = "", checkPolicyFile:Boolean = false)
		{
			this._id = id; 
			this._path = path;
			this._autoScale = autoScale;
			this._checkPolicyFile = checkPolicyFile;
			
			if(keepStageAspectRatio)
				_layoutContext = new LayoutContext(vAlign, hAlign);
		}
		
		/** Unique identifier. */
		public function get id():* { return _id; }
		
		/** Loaded bitmap data. */
		public function get bitmapData():BitmapData { return _bitmapData; }	
		
		/** Load bitmap data asynchronously. 
		 *  @return Future object for callback.*/
		public function load(canvas:BitmapData = null, position:Point = null):Future
		{
			_position = position;
			_canvas = canvas;
			_completer = new Completer();
			
			var loaderContext:LoaderContext = new LoaderContext(_checkPolicyFile);
			loaderContext.imageDecodingPolicy = ImageDecodingPolicy.ON_LOAD;
			_bitmapLoader = new Loader();
			_bitmapLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onUrlLoaderComplete);
			_bitmapLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onIoError);
			_bitmapLoader.load(new URLRequest(_path), loaderContext);
			
			return _completer.future;
		}
		
		/** Unload loaded data. */	
		public function unload():void
		{
			if (_bitmapLoader)
			{
				_bitmapLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onUrlLoaderComplete);
				_bitmapLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onIoError);
				_bitmapLoader = null;	
			}
			if(_bitmapData)
			{
				_bitmapData.dispose();
				_bitmapData = null;
			}
		}
		
		/** Build texture from the data.
		 * 	@param visitor Texture bundle to call method of texture creation from bitmap data.
		 *  @return Future object for callback.*/
		public function build(visitor:TextureBundle):Future
		{
			visitor.createTextureFromBitmapData(_id, _bitmapData);
			
			return null;
		}
		
		/** @private */		
		private function onIoError(event:IOErrorEvent):void
		{
			Log.error("Loading texture IO error: {0}", event.text);
			_completer.complete();
		}
		
		/** @private */		
		private function onUrlLoaderComplete(event:Event):void
		{
			var instance:BitmapData = Bitmap(LoaderInfo(event.target).content).bitmapData;
			_bitmapData = TextureUtil.createBitmapData(instance, instance.width, instance.height, _autoScale, _layoutContext, _canvas, _position);
			
			_completer.complete();
		}
	}
}