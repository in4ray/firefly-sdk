// =================================================================================================
//
//	Firefly Framework
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.utils
{
	import com.firefly.core.Firefly;
	import com.firefly.core.firefly_internal;
	import com.firefly.core.layouts.helpers.LayoutContext;
	
	import flash.display.BitmapData;
	import flash.display.IBitmapDrawable;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import dragonBones.objects.AnimationData;
	import dragonBones.objects.ArmatureData;
	import dragonBones.objects.BoneData;
	import dragonBones.objects.DisplayData;
	import dragonBones.objects.SkeletonData;
	import dragonBones.objects.SkinData;
	import dragonBones.objects.SlotData;
	import dragonBones.objects.TransformFrame;
	import dragonBones.objects.TransformTimeline;
	
	use namespace firefly_internal;
	
	/** Utility class that helps to create, scale and convert bitmap data. 
	 *  @see com.firefly.core.layouts.LayoutContext */	
	public class TextureUtil
	{
		/** @private */		
		private static var _helpMatirx:Matrix = new Matrix();
		
		/** Create and scale bitmap data from the source data.
		 * 
		 *  @param source Bitmap drawable data. E.g. FXG class or other bitmap data.
		 *  @param w Original width of the source data.
		 *  @param h Original height of the source data.
		 *  @param autoScale Specifies whether use autoscale algorithm. Based on design size and stage size texture will be 
		 * 		   proportionally scale to stage size. E.g. design size is 1024x768 and stage size is 800x600 the formula is
		 * 		   <code>var scale:Number = Math.min(1024/800, 768/600);</code></br> 
		 * 		   Calculated scale is 1.28 and all bitmaps scale based on it.
		 *  @param layoutContext Layout context to calculate the crop area for bitmap data.
		 *  @return Created BitmapData object.  */
		public static function createBitmapData(source:IBitmapDrawable, w:Number, h:Number, autoScale:Boolean = true, layoutContext:LayoutContext=null, canvas:BitmapData = null, position:Point = null):BitmapData
		{ 
			if (autoScale || layoutContext || canvas)
			{
				var scale:Number = autoScale ? Firefly.current.textureScale : 1;
				w = Math.ceil(w*scale);
				h = Math.ceil(h*scale);
				
				if(!position)
					position = new Point();
				
				_helpMatirx.a = 1;
				_helpMatirx.b = 0;
				_helpMatirx.c = 0;
				_helpMatirx.d = 1;
				_helpMatirx.scale(scale, scale);
				_helpMatirx.tx = position.x;
				_helpMatirx.ty = position.y;
				
				if(layoutContext)
				{
					var rect:Rectangle = layoutContext.getTextureRect(w, h, layoutContext.vAlign, layoutContext.hAlign);
					_helpMatirx.tx = rect.x;
					_helpMatirx.ty = rect.y;
					rect.x = rect.y = 0;  
					
					if(!canvas)
						canvas = new BitmapData(rect.width, rect.height, true, 0x00ffffff);
					
					canvas.draw(source, _helpMatirx, null, null, rect, true);
				}
				else
				{
					if(!canvas)
						canvas = new BitmapData(w, h, true, 0x00ffffff);
					
					canvas.draw(source, _helpMatirx, null, null, null, true);
				}
			}
			else
			{
				if(source is BitmapData)
				{
					canvas = source as BitmapData;
				}
				else
				{
					canvas = new BitmapData(w, h, true, 0x00ffffff);
					canvas.draw(source, null, null, null, null, true);
				}
			}
			
			return canvas;
		}
		
		/** Adjust Dragon Bones skeleton data base on texture scale.
		 *  @param data Specifies Dragon Bones skeleton data object need to adjust.
		 *  @return Returns adjusted skeleton data.  */
		public static function adjustSkeletonData(data:SkeletonData):SkeletonData
		{
			var scale:Number = Firefly.current.textureScale / Firefly.current.contentScale;
			for each (var armatureData:ArmatureData in  data.armatureDataList)
			{
				for each (var boneData:BoneData in armatureData.boneDataList)
				{
					boneData.global.x *= scale;
					boneData.global.y *= scale;
					boneData.transform.x *= scale;
					boneData.transform.y *= scale;
				}
				
				for each (var animationData:AnimationData in armatureData.animationDataList)
				{
					for each (var timeline:* in animationData.timelines)
					{
						if (timeline is TransformTimeline)
						{
							timeline.originPivot.x *= scale;
							timeline.originPivot.y *= scale;
							timeline.originTransform.x *= scale;
							timeline.originTransform.y *= scale;
							
							for each (var transformFrame:TransformFrame in timeline.frameList);
							{
								transformFrame.global.x *= scale;
								transformFrame.global.y *= scale;
								transformFrame.pivot.x *= scale;
								transformFrame.pivot.y *= scale;
								transformFrame.transform.x *= scale;
								transformFrame.transform.y *= scale;
							}
						}
					}
				}
				
				for each (var skintData:SkinData in armatureData.skinDataList)
				{
					for each (var slotData:SlotData in skintData.slotDataList)
					{
						for each (var displayData:DisplayData in slotData.displayDataList)
						{
							displayData.pivot.x *= scale;
							displayData.pivot.y *= scale;
							displayData.transform.x *= scale;
							displayData.transform.y *= scale;
						}
					}
				}
			}
			
			return data;
		}
		
		/** Adjust Dragon Bones texture atlas raw data base on texture scale.
		 *  @param data Specifies Dragon Bones texture atlas raw data object need to adjust.
		 *  @return Returns adjusted object.  */
		public static function adjustTextureAtlasRawData(data:Object):Object
		{
			var scale:Number = Firefly.current.textureScale / Firefly.current.contentScale;
			for each (var subTextures:* in data)
			{
				if (subTextures is Array)
				{
					for each (var subTexture:Object in subTextures)
					{
						if (subTexture.hasOwnProperty("x"))
							subTexture.x *= scale;
						if (subTexture.hasOwnProperty("y"))
							subTexture.y *= scale;
						if (subTexture.hasOwnProperty("width"))
							subTexture.width *= scale;
						if (subTexture.hasOwnProperty("height"))
							subTexture.height *= scale;
					}
				}
			}
			
			return data;
		}
	}
}