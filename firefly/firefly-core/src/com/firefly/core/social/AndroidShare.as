// =================================================================================================
//
//	Firefly Framework
//	Copyright 2016 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.social
{
	import com.firefly.core.components.helpers.LocalizationField;
	import com.firefly.core.utils.SingletonLocator;
	import com.illuzor.sharingextension.SharingExtension;
	
	import flash.display.BitmapData;
	import flash.display.PNGEncoderOptions;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	
	/** The AndroidShare class created for sharing text or image with associated applications which can share some content.
	 *  The sharing also supports localization. */	
	public class AndroidShare
	{
		/** @private */		
		private var _share:AndroidShare;
		
		/** Constructor. */		
		public function AndroidShare()
		{
			SingletonLocator.register(this, AndroidShare);
		}
		
		/** Instance of AndroidShare class. */		
		public static function get instance():AndroidShare { return SingletonLocator.getInstance(AndroidShare); }
		
		/** The function invokes native share dialog with associated applications to share text.
		 *  @param title The title of share dialog.
		 *  @param message The message string to share. */		
		public function shareSimpleText(title:String, message:String):void
		{
			SharingExtension.shareText(title, message)
		}
		
		/** The fucntion invokes native share dialog with associated applications with localization suppoting to share text.
		 *  @param locTitle The localization field of title.
		 *  @param locMessage The localization field of message string to share. */		
		public function shareText(locTitle:LocalizationField, locMessage:LocalizationField):void
		{
			SharingExtension.shareText(locTitle.getLocalization(), locMessage.getLocalization())
		}
		
		/** The fucntion invokes native share dialog with associated applications with localization suppoting to share image.
		 *  @param bitmapData Image to share.
		 *  @param title The title of share dialog.
		 *  @param message The message string to share.
		 *  @param compressor The encoder to compress the image. By default uses <code>PNGEncoderOptions</code> options. 
		 *  				  You can use also <code>JPEGEncoderOptions</code> encoder options.
		 *  param imageName The image temp file name which will be shared. */		
		public function shareSimpleImage(bitmapData:BitmapData, title:String, message:String="", compressor:Object=null, 
										 imageName:String="share_score.png"):void
		{
			if (!compressor)
				compressor = new PNGEncoderOptions()
			
			var bitmapBytes:ByteArray = bitmapData.encode(new Rectangle(0, 0, bitmapData.width, bitmapData.height), compressor);
			var file:File = File.documentsDirectory.resolvePath(imageName);
			var stream:FileStream = new FileStream();
			stream.open(file, FileMode.WRITE);
			stream.writeBytes(bitmapBytes);
			stream.close();
			
			SharingExtension.shareImage(file, title, message)
		}
		
		/** The fucntion invokes native share dialog with associated applications with localization suppoting to share image.
		 *  @param bitmapData Image to share.
		 *  @param title he localization field of title.
		 *  @param message The localization field of message string to share.
		 *  @param compressor The encoder to compress the image. By default uses <code>PNGEncoderOptions</code> options. 
		 *  				  You can use also <code>JPEGEncoderOptions</code> encoder options.
		 *  param imageName The image temp file name which will be shared. */		
		public function shareImage(bitmapData:BitmapData, locTitle:LocalizationField, locMessage:LocalizationField=null, 
								   compressor:Object=null, imageName:String="share_score.png"):void
		{
			if (!compressor)
				compressor = new PNGEncoderOptions()
					
			var bitmapBytes:ByteArray = bitmapData.encode(new Rectangle(0, 0, bitmapData.width, bitmapData.height), compressor);
			var file:File = File.documentsDirectory.resolvePath(imageName);
			var stream:FileStream = new FileStream();
			stream.open(file, FileMode.WRITE);
			stream.writeBytes(bitmapBytes);
			stream.close();
			
			SharingExtension.shareImage(file, locTitle.getLocalization(), locMessage ? locMessage.getLocalization() : "")
		}
	}
}