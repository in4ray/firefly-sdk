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
	import com.firefly.core.async.DelayedCompleter;
	import com.firefly.core.async.Future;
	import com.firefly.core.textures.StaticTextureBundle;
	import com.firefly.core.textures.TextureBundle;
	import com.firefly.core.utils.TextureUtil;
	import com.firefly.core.utils.XMLUtil;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	import spark.core.SpriteVisualElement;

	use namespace firefly_internal;
	
	[ExcludeClass]
	/** The loader that loads FXG asset for creation texture atlas based on bitmap data. */
	public class AtlasFXGLoader extends FXGLoader
	{
		private var _atlasXML:XML;
		
		/** @inheritDoc */
		public function AtlasFXGLoader(source:Class, autoScale:Boolean = true, keepStageAspectRatio:Boolean = false, vAlign:String = "", hAlign:String = "")
		{
			super(source, autoScale, keepStageAspectRatio, vAlign, hAlign);
		}
		
		/** @inheritDoc */
		override public function load():Future
		{
			var instance:SpriteVisualElement = new _SourceClass();
			
			var sprite:Sprite = instance as Sprite;
			var sheet:Sprite = sprite.getChildAt(0) as Sprite;
			var layer:Sprite;
			var element:DisplayObject;
			var name:String;
			var count:int = 0;
			
			_atlasXML = <TextureAtlas/>;
			
			for (var i:int = 0; i < sheet.numChildren; i++) 
			{
				layer = sheet.getChildAt(i) as Sprite;
				
				for (var j:int = 0; j < layer.numChildren; j++) 
				{
					element = ((layer.getChildAt(j) as MovieClip).getChildAt(0) as MovieClip).getChildAt(0);
					
					name = "element" + count;
					count++;
					
					_atlasXML.appendChild(<SubTexture name={name} x={element.x} y={element.y} width={element.width} height={element.height} frameX="0" frameY="0" frameWidth={element.width} frameHeight={element.height}/>);
				}
			}
			
			if(_autoScale)
				XMLUtil.adjustAtlasXML(_atlasXML);
			
			_bitmapData = TextureUtil.createBitmapData(instance, instance.viewWidth, instance.viewHeight, _autoScale, _layoutContext);
			
			return new DelayedCompleter(0.001).future;
		}
		
		/** @inheritDoc */
		override public function build(visitor:TextureBundle):Future
		{
			(visitor as StaticTextureBundle).createTextureAtlasFromBitmapData(id, bitmapData, _atlasXML);
			
			return null;
		}
	}
}