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
	import com.firefly.core.async.Future;
	import com.firefly.core.layouts.helpers.LayoutContext;
	import com.firefly.core.textures.TextureBundle;
	import com.firefly.core.utils.StringUtil;
	import com.firefly.core.utils.TextureUtil;
	
	import flash.display.BitmapData;
	import flash.geom.Point;
	
	import spark.core.SpriteVisualElement;
	
	import avmplus.getQualifiedClassName;

	use namespace firefly_internal;
	
	[ExcludeClass]
	/** The loader for creating bitmap data from embeded fxg asset. */
	public class FXGLoader implements ITextureLoader
	{
		protected var _SourceClass:Class;
		protected var _autoScale:Boolean;
		protected var _bitmapData:BitmapData;
		protected var _keepStageAspectRatio:Boolean;
		protected var _layoutContext:LayoutContext;
		
		/** Constructor.
		 * 
		 *  @param source Source of fxg data.
		 *  @param autoScale Specifies whether use autoscale algorithm. Based on design size and stage size texture will be 
		 * 		   proportionally scale to stage size. E.g. design size is 1024x768 and stage size is 800x600 the formula is
		 * 		   <code>var scale:Number = Math.min(1024/800, 768/600);</code></br> 
		 * 		   Calculated scale is 1.28 and all bitmaps scale based on it.
		 *  @param keepStageAspectRatio Specifies whether keep stage aspect ration. This property has effect to cropping of bitmap data. 
		 *  @param vAlign Vertical align type.
		 *  @param hAlign Horizontal align type. */		
		public function FXGLoader(source:Class, autoScale:Boolean = true, keepStageAspectRatio:Boolean = false, vAlign:String = "", hAlign:String = "")
		{
			this._keepStageAspectRatio = keepStageAspectRatio;
			this._SourceClass = source;
			this._autoScale = autoScale;
			
			if(_keepStageAspectRatio)
				_layoutContext = new LayoutContext(null, vAlign, hAlign);
			
		}
		
		/** Unique identifier. */
		public function get id():* { return _SourceClass }
		
		/** Loaded bitmap data. */
		public function get bitmapData():BitmapData { return _bitmapData; }
		
		/** Load bitmap data asynchronously. 
		 *  @return Future object for callback.*/
		public function load(canvas:BitmapData = null, position:Point = null):Future
		{
			var instance:SpriteVisualElement = new _SourceClass();
			
			_bitmapData = TextureUtil.createBitmapData(instance, instance.viewWidth, instance.viewHeight, _autoScale, _layoutContext, canvas, position);
			
			return Future.nextFrame();
		}
		
		/** Unload loaded data. */	
		public function unload():void
		{
			if(_bitmapData)
			{
				_bitmapData.dispose();
				_bitmapData = null;
			}	
		}
		
		/** Build texture from the loaded data.
		 * 	@param visitor Texture bundle to call method of texture creation from bitmap data.
		 *  @return Future object for callback.*/
		public function build(visitor:TextureBundle):Future
		{
			visitor.createTextureFromBitmapData(id, _bitmapData);
			
			return null;
		}
	}
}