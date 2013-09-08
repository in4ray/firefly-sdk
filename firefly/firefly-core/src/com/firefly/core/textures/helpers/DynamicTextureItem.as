package com.firefly.core.textures.helpers
{
	import com.firefly.core.firefly_internal;
	
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import starling.core.Starling;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	import treefortress.textureutils.MaxRectPacker;

	use namespace firefly_internal; 
	
	[ExcludeClass]
	/** Class that packs bitmaps into atlas. */	
	public class DynamicTextureItem
	{
		private var _packer:MaxRectPacker;
		private var _atlasXML:XML;
		private var _bitmapData:BitmapData;
		private var _generateMipMaps:Boolean;
		private var _atlasSize:Number = 2048;
		private var _padding:Number;
		
		/** Constructor.
		 *  @param padding Padding between textures.
		 *  @param atlasSize Size of atlas texture.
		 *  @param generateMipMaps Indicates if mipMaps will be created for all registered textures. */		
		public function DynamicTextureItem(padding:Number, atlasSize:Number = 2048, generateMipMaps:Boolean = false)
		{
			_atlasSize = atlasSize;
			_generateMipMaps = generateMipMaps;
			_padding = padding;
			_atlasXML = <TextureAtlas/>;
		}
		
		/** Texture atlas*/		
		public var textureAtlas:TextureAtlas;

		/** Try to pack bitmap into atlas if free space enough.
		 *  @param id Identifier of texture.
		 *  @param source Bitmap data to be packed.
		 *  @return true if data successfuly packed. */
		public function packData(id:String, source:BitmapData):Boolean
		{
			if(textureAtlas)
			{
				var subXMLList:XMLList = _atlasXML.SubTexture.(@name==name);
				
				if(subXMLList.length() > 0)
				{
					if(!_bitmapData)
						_bitmapData = new BitmapData(_atlasSize, _atlasSize);
					
					_bitmapData.copyPixels(source, new Rectangle(0,0,source.width,source.height), new Point(subXMLList[0].@x, subXMLList[0].@y));
					
					return true;
				}
			}
			else
			{
				if(!_bitmapData)
				{
					_packer = new MaxRectPacker(_atlasSize, _atlasSize);
					_bitmapData = new BitmapData(_atlasSize, _atlasSize);
				}
				
				var rect:Rectangle = _packer.quickInsert(source.width + _padding*2, source.height + _padding*2);
				if(rect)
				{
					var destPoint:Point =  new Point(rect.x+_padding,rect.y+_padding);
					_bitmapData.copyPixels(source, new Rectangle(0,0,source.width,source.height), destPoint);
					_atlasXML.appendChild(<SubTexture name={id} x={destPoint.x} y={destPoint.y} width={source.width} height={source.height} frameX="0" frameY="0" frameWidth={source.width} frameHeight={source.height}/>);
					 
					return true;
				}
			}
			
			return false;
		}
		
		/** Create atlas and release bitmap data from RAM. */		
		public function prepareAtlas():void
		{
			if (!textureAtlas)
			{
				textureAtlas = new TextureAtlas(Texture.fromBitmapData(_bitmapData, _generateMipMaps), _atlasXML);
			}
			else
			{
				textureAtlas.texture.root.onRestore = function():void
				{
					textureAtlas.texture.root.uploadBitmapData(_bitmapData);
				};
				Starling.current.dispatchEvent(new Event(Event.CONTEXT3D_CREATE));
			}
			
			textureAtlas.texture.root.onRestore = null;	
			
			_bitmapData.dispose();
		}
	}
}