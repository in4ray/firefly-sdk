package com.firefly.social.response
{
	public class GameCenterResponse
	{
		public static const REQUEST_RESPONSE:String = "requestResponse";
		public static const REQUEST_FAILED:String = "requestFailed";
		
		private var _data:*;
		private var _type:String;
		private var _errorCode:String;
		private var _errorMessage:String;
		
		public function GameCenterResponse(type:String, data:*=null, errorCode:String="", errorMessage:String="")
		{
			_type = type;
			_data = data;
			_errorCode = errorCode;
			_errorMessage = errorMessage;
		}

		public function get type():String { return _type; }
		public function get data():* { return _data; }
		public function get errorCode():String { return _errorCode; }
		public function get errorMessage():String { return _errorMessage; }
	}
}