package com.firefly.social.helpers
{
	public class FacebookImageOptions extends Object
	{
		public var userId:String;
		public var width:Number;
		public var height:Number;
		public var type:String;
		
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