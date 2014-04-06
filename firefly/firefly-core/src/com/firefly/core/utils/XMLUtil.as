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

	use namespace firefly_internal;
	
	/** Utility class that helps to scale geomentry data in XML for texture atlases and Dragon Bones. */	
	public class XMLUtil
	{
		/** Adjust texture atlas XML base on texture scale.
		 *  @param xml Specifies texture atlas XML need to adjust.
		 *  @return Returns adjusted XML object. */
		public static function adjustAtlasXML(xml:XML):XML
		{
			var scale:Number = Firefly.current.textureScale;
			for each (var subTexture:XML in xml.SubTexture)
			{
				adjustValue(subTexture, "@x", scale);
				adjustValue(subTexture, "@y", scale);
				adjustValue(subTexture, "@width", scale);
				adjustValue(subTexture, "@height", scale);
				adjustValue(subTexture, "@frameX", scale);
				adjustValue(subTexture, "@frameY", scale);
				adjustValue(subTexture, "@frameHeight", scale);
				adjustValue(subTexture, "@frameWidth", scale);
			}
			
			return xml;
		}
		
		/** Adjust Font XML base on texture scale.
		 *  @param xml Specifies font XML need to adjust.
		 *  @return Returns adjusted XML object. */
		public static function adjustFontXML(xml:XML):XML
		{
			var scale:Number = Firefly.current.textureScale;
			for each (var subTexture:XML in xml.chars.char)
			{
				adjustValue(subTexture, "@x", scale);
				adjustValue(subTexture, "@y", scale);
				adjustValue(subTexture, "@width", scale);
				adjustValue(subTexture, "@height", scale);
				adjustValue(subTexture, "@xoffset", scale);
				adjustValue(subTexture, "@yoffset", scale);
				adjustValue(subTexture, "@xadvance", scale);
			}
			
			adjustValue(xml.common[0], "@lineHeight", scale);
			adjustValue(xml.common[0], "@base", scale);
			
			return xml;
		}
		
		/** Adjust Dragon Bones XML base on texture scale.
		 *  @param xml Specifies Dragon Bones XML need to adjust.
		 *  @return Returns adjusted XML object.  */
		public static function adjustDragonBonesXML(xml:XML):XML
		{
			var scale:Number = Firefly.current.textureScale;
			for each (var node:XML in xml.descendants()) 
			{
				adjustValue(node, "@x", scale);
				adjustValue(node, "@y", scale);
				adjustValue(node, "@pX", scale);
				adjustValue(node, "@pY", scale);
			}
			
			return xml;
		}
		
		/** @private 
		 *  Adjust one attribute in node.
		 *  @param node Node in XML with atribute need to adjust.
		 *  @param attribute Atribute need to adjust.
		 *  @param scale Texture scale factor. */
		private static function adjustValue(node:XML, attribute:String, scale:Number):void
		{
			if(node.hasOwnProperty(attribute))
				node[attribute] = parseFloat(node[attribute]) * scale;
		}
	}
}