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
	
	import flash.display.AVM1Movie;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;

	use namespace firefly_internal;
	
	[ExcludeClass]
	/** The loader for loading SWF asset. */
	public class SWFLoader implements ITextureLoader
	{
		private var _completer:Completer;
		private var _id:String;
		private var _path:String;
		private var _autoScale:Boolean;
		private var _checkPolicyFile:Boolean;
		private var _bitmapLoader:Loader;
		private var _bitmapDataList:Vector.<BitmapData>;
		private var _layoutContext:LayoutContext;
		
		/** Constructor.
		 * 
		 *  @param id Unique identifier of the loader.
		 *  @param path Path to the swf file.
		 *  @param autoScale Specifies whether use autoscale algorithm. Based on design size and stage size texture will be 
		 * 		   proportionally scale to stage size. E.g. design size is 1024x768 and stage size is 800x600 the formula is
		 * 		   <code>var scale:Number = Math.min(1024/800, 768/600);</code></br> 
		 * 		   Calculated scale is 1.28 and all bitmaps scale based on it.
		 *  @param keepStageAspectRatio Specifies whether keep stage aspect ration. This property has effect to cropping of bitmap data. 
		 *  @param vAlign Vertical align type.
		 *  @param hAlign Horizontal align type.
		 *  @param checkPolicyFile Specifies whether the application should attempt to download a URL 
		 * 		   policy file from the loaded object's server before beginning to load the object itself. */		
		public function SWFLoader(id:String, path:String, autoScale:Boolean = true, keepStageAspectRatio:Boolean = false, vAlign:String = "", hAlign:String = "", checkPolicyFile:Boolean = false)
		{
			this._id = id; 
			this._path = path;
			this._autoScale = autoScale;
			this._checkPolicyFile = checkPolicyFile;
			
			if(keepStageAspectRatio)
				_layoutContext = new LayoutContext(vAlign, hAlign);
		}
		
		/** Unique identifier. */
		public function get id():*
		{
			return _id;
		}
		
		/** Loaded list of bitmap datas. */
		public function get bitmapDatas():Vector.<BitmapData>
		{
			return _bitmapDataList;
		}	
		
		/** Load swf data asynchronously. 
		 *  @return Future object for callback.*/
		public function load():Future
		{
			_completer = new Completer();
			
			_bitmapLoader = new Loader();
			_bitmapLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onUrlLoaderComplete);
			_bitmapLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onIoError);
			_bitmapLoader.load(new URLRequest(_path), new LoaderContext(_checkPolicyFile));
			
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
			if(_bitmapDataList)
			{
				for each (var data:BitmapData in _bitmapDataList) 
				{
					data.dispose();
				}
				
				_bitmapDataList.length = 0;
				_bitmapDataList = null;
			}
		}
		
		/** Build texture from the data.
		 * 	@param visitor Texture bundle to call method of texture creation from bitmap data.
		 *  @return Future object for callback.*/
		public function build(visitor:TextureBundle):Future
		{
			if(_bitmapDataList.length > 0)
			{
				if(_bitmapDataList.length > 1)
					visitor.createTextureFromBitmapDataList(_id, _bitmapDataList);
				else
					visitor.createTextureFromBitmapData(_id, _bitmapDataList[0]);
			}
			
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
			_bitmapDataList = new Vector.<BitmapData>();
			var content:DisplayObject = LoaderInfo(event.target).content;
			if(content is AVM1Movie)
			{
				_bitmapDataList.push(TextureUtil.createBitmapData(content, content.width, content.height, _autoScale, _layoutContext));
			}
			else if(content is MovieClip)
			{
				var instance:MovieClip = MovieClip(LoaderInfo(event.target).content).getChildAt(0) as MovieClip;
				
				for (var i:int = 0; i < instance.totalFrames; i++) 
				{
					instance.gotoAndStop(i);
					_bitmapDataList.push(TextureUtil.createBitmapData(instance, instance.width, instance.height, _autoScale, _layoutContext));
				}
			}
			_completer.complete();
		}
	}
}