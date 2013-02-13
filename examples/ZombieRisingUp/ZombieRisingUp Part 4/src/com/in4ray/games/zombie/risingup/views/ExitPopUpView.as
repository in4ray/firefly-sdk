// =================================================================================================
//
//	Zombie: Rising Up
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================
package com.in4ray.games.zombie.risingup.views
{
	import com.in4ray.games.zombie.risingup.consts.ViewStates;
	import com.in4ray.games.zombie.risingup.textures.Textures;
	import com.in4ray.gaming.components.Button;
	import com.in4ray.gaming.components.Image;
	import com.in4ray.gaming.components.Sprite;
	import com.in4ray.gaming.components.TextField;
	import com.in4ray.gaming.core.GameGlobals;
	import com.in4ray.gaming.events.ViewStateEvent;
	import com.in4ray.gaming.layouts.$bottom;
	import com.in4ray.gaming.layouts.$hCenter;
	import com.in4ray.gaming.layouts.$height;
	import com.in4ray.gaming.layouts.$left;
	import com.in4ray.gaming.layouts.$right;
	import com.in4ray.gaming.layouts.$vCenter;
	import com.in4ray.gaming.layouts.$width;
	
	import starling.events.Event;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	/**
	 * Exit pop up dialog.
	 */
	public class ExitPopUpView extends Sprite
	{
		private static const EXIT_DIALOG_MESSAGE:String = "Are you sure you want to quit?";
		
		private var textureBundle:Textures;
		
		/**
		 * Constructor.
		 */
		public function ExitPopUpView()
		{
			super();
			
			// Set dialog layout
			addLayout($width(460).rcpx, $height(280).rcpx, $hCenter(0).rcpx, $vCenter(-30).rcpx);
			
			// Get reference on game Textures
			textureBundle = new Textures();
			
			//Exit dialog background
			addElement(new Image(textureBundle.exitDialog), $width(100).pct, $height(100).pct);
			
			// Dialog message
			var confirmText:TextField = new TextField(EXIT_DIALOG_MESSAGE, "Chango", 64, 0x00FF00);
			confirmText.autoScale = true;
			confirmText.touchable = false;
			confirmText.hAlign = HAlign.CENTER;
			confirmText.vAlign = VAlign.CENTER;
			addElement(confirmText, $bottom(40).rcpx, $hCenter(0).rcpx, $width(330).rcpx, $height(140).rcpx);
			
			// Close
			var closeBtn:Button = new Button(textureBundle.confirmUpButton, "", textureBundle.confirmDownButton);
			closeBtn.addEventListener(Event.TRIGGERED, closeHandler);
			addElement(closeBtn,  $left(-20).rcpx, $bottom(-20).rcpx);
			
			// Cancel
			var cancelBtn:Button = new Button(textureBundle.exitUpRedButton, "", textureBundle.exitDownRedButton);
			cancelBtn.addEventListener(Event.TRIGGERED, cancelHandler);
			addElement(cancelBtn, $right(-20).rcpx, $bottom(-20).rcpx);
		}
		
		/**
		 * Close handler. Close application
		 */
		private function closeHandler():void
		{
			dispatchEvent(new ViewStateEvent(ViewStateEvent.CLOSE_POPUP, ViewStates.EXIT));
			GameGlobals.systemManager.exit();
		}
		
		/**
		 * Cancel handler. Closes Exit Dialog and back to menu. 
		 */
		private function cancelHandler():void
		{
			dispatchEvent(new ViewStateEvent(ViewStateEvent.CLOSE_POPUP, ViewStates.EXIT));
		}
	}
}