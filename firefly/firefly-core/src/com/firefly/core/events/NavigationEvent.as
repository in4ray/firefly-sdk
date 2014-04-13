package com.firefly.core.events
{
	import starling.events.Event;
	
	public class NavigationEvent extends Event
	{
		public static const TO_MENU:String = "toMenu";
		public static const TO_SETTINGS:String = "toSettings";
		public static const TO_CREDITS:String = "toCredits";
		public static const TO_ROOMS:String = "toRooms";
		public static const TO_LEVELS:String = "toLevels";
		public static const TO_GAME:String = "toGame";
		public static const TO_SCORE:String = "toScore";
		public static const TO_PAUSE:String = "toPause";
		public static const TO_EXIT:String = "toExit";
		public static const TO_RATE:String = "toRate";
		public static const TO_REWARD:String = "toReward";
		public static const BACK:String = "back";
		public static const ACTIVATE:String = "activate";
		public static const DEACTIVATE:String = "deactivate";
		public static const INITIALIZE:String = "initialize";
		public static const CLOSE_DIALOG:String = "closeDialog";
		
		public function NavigationEvent(type:String, data:Object=null)
		{
			super(type, true, data);
		}
	}
}