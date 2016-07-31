// =================================================================================================
//
//	Firefly Framework
//	Copyright 2016 in4ray. All Rights Reserved.
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
		
		/** Adjust font xml base on texture scale.
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
		
		/** Adjust particle xml base on texture scale.
		 *  @param xml Specifies particle xml need to adjust.
		 *  @return Returns adjusted xml object. */
		public static function adjustParticleXML(xml:XML):XML
		{
			var scale:Number = Firefly.current.textureScale/Firefly.current.contentScale;
			
			adjustValue(xml.sourcePosition[0], "@x", scale);
			adjustValue(xml.sourcePosition[0], "@y", scale);
			adjustValue(xml.sourcePositionVariance[0], "@x", scale);
			adjustValue(xml.sourcePositionVariance[0], "@y", scale);
			adjustValue(xml.startParticleSize[0], "@value", scale);
			adjustValue(xml.startParticleSizeVariance[0], "@value", scale);
			adjustValue(xml.finishParticleSize[0], "@value", scale);
			adjustValue(xml.FinishParticleSizeVariance[0], "@value", scale);
			adjustValue(xml.gravity[0], "@x", scale);
			adjustValue(xml.gravity[0], "@y", scale);
			
			adjustValue(xml.speed[0], "@value", scale);
			adjustValue(xml.speedVariance[0], "@value", scale);
			adjustValue(xml.radialAcceleration[0], "@value", scale);
			adjustValue(xml.radialAccelVariance[0], "@value", scale);
			adjustValue(xml.tangentialAcceleration[0], "@value", scale);
			adjustValue(xml.tangentialAccelVariance[0], "@value", scale);
			
			adjustValue(xml.maxRadius[0], "@value", scale);
			adjustValue(xml.maxRadiusVariance[0], "@value", scale);
			adjustValue(xml.minRadius[0], "@value", scale);
			adjustValue(xml.minRadiusVariance[0], "@value", scale);
			
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
		 *  @param scale Texture scale factor.*/
		private static function adjustValue(node:XML, attribute:String, scale:Number):void
		{
			if(node && node.hasOwnProperty(attribute))
				node[attribute] = parseFloat(node[attribute]) * scale;
		}
	}
}