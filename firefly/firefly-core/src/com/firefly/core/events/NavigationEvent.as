// =================================================================================================
//
//	Firefly Framework
//	Copyright 2016 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

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
		public static const TO_HELP:String = "toHelp";
		public static const TO_SCORE:String = "toScore";
		public static const TO_PAUSE:String = "toPause";
		public static const TO_EXIT:String = "toExit";
		public static const TO_RATE:String = "toRate";
		public static const TO_REWARD:String = "toReward";
		public static const TO_LANGUAGE:String = "toLanguage";
		public static const TO_MISSIONS:String = "toMissions";
		public static const TO_CHALLANGES:String = "toChallanges";
		public static const TO_ACHIEVEMENTS:String = "toAchievements";
		public static const TO_LEADERBOARD:String = "toLeaderboard";
		public static const BACK:String = "back";
		public static const CLOSE_APP:String = "closeApp";
		public static const ACTIVATE:String = "activate";
		public static const DEACTIVATE:String = "deactivate";
		public static const RESTORE_CONTEXT:String = "restoreContext";
		public static const INITIALIZE:String = "initialize";
		public static const CLOSE_DIALOG:String = "closeDialog";
		
		public function NavigationEvent(type:String, data:Object=null)
		{
			super(type, true, data);
		}
	}
}