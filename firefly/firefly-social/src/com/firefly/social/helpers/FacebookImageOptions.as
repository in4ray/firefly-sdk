// =================================================================================================
//
//	Firefly Framework
//	Copyright 2016 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.social.helpers
{
	/** Facebook image options to parametrize image size in case loading the image. */	
	public class FacebookImageOptions extends Object
	{
		/** User id. */		
		public var userId:String;
		/** Image width to load. */		
		public var width:Number;
		/** Image height to load. */		
		public var height:Number;
		/** Image type to load. Acceptable values <code>small, normal, album, large, square</code>. */		
		public var type:String;
		
		/** Constructor.
		 *  @param userId User id.
		 *  @param width Image width to load.
		 *  @param height Image height to load.
		 *  @param type Image type to load. Acceptable values <code>small, normal, album, large, square</code>. */		
		public function FacebookImageOptions(userId:String, width:Number=NaN, height:Number=NaN, type:String="")
		{
			super();
			
			this.userId = userId;
			this.width = width;
			this.height = height;
			this.type = type;
		}
	}
}