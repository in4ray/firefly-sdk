// =================================================================================================
//
//	Firefly Framework
//	Copyright 2016 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.social.response
{
	/** The responce class  */	
	public class SocialReponse
	{
		/** Request response type. */		
		public static const REQUEST_RESPONSE:String = "requestResponse";
		/** Request failure type. */	
		public static const REQUEST_FAILURE:String = "requestFailure";
		
		/** @private */		
		private var _type:String;
		/** @private */
		private var _data:*;
		/** @private */
		private var _errorCode:String;
		/** @private */
		private var _errorMessage:String;
		
		/** Constructor.
		 *  @param type Responce type.
		 *  @param data Responce data.
		 *  @param errorCode Error code in case failure.
		 *  @param errorMessage Error message in case failure. */		
		public function SocialReponse(type:String, data:*=null, errorCode:String="", errorMessage:String="")
		{
			_type = type;
			_data = data;
			_errorCode = errorCode;
			_errorMessage = errorMessage
		}

		/** Responce type. */		
		public function get type():String { return _type; }
		
		/** Responce data. */		
		public function get data():* { return _data; }
		
		/** Error code in case failure. */		
		public function get errorCode():String { return _errorCode; }
		
		/** Error message in case failure. */		
		public function get errorMessage():String { return _errorMessage; }
	}
}