// =================================================================================================
//
//	in4ray Gaming SDK
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.in4ray.gaming.components
{
	import com.in4ray.gaming.components.Button;
	
	import flash.utils.ByteArray;
	
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	
	/**
	 * Toggle button switched to opposit state 
	 */	
	[Event(name="change", type="starling.events.Event")]
	
	/**
	 * Toggle button component.
	 */	
	public class ToggleButton extends Button
	{
		public var upStateNormal:Texture;
		public var upStateSelected:Texture;
		public var downStateNormal:Texture;
		public var downStateSelected:Texture;
		public var textNormal:String;
		public var textSelected:String;
		
		/**
		 * Creates simple button with up and down normal texture, up and down selected normal texture and click sound effect.
		 * @param upStateNormal Up and down normal texture
		 * @param upStateSelected Up and down selected normal texture
		 * @param clickSound Click sound effect
		 * @return button object
		 */		
		public static function simple(upStateNormal:Texture, upStateSelected:Texture = null, clickSound:ByteArray = null):ToggleButton
		{
			return new ToggleButton(upStateNormal, upStateSelected, "", "", null, null, clickSound);
		}
		
		/**
		 * Constructor. 
		 *  
		 * @param upStateNormal Up normal texture.
		 * @param upStateSelected Up selected texture.
		 * @param textNormal Text for label.
		 * @param textSelected Text for selected state label.
		 * @param downStateNormal Down normal texture.
		 * @param downStateSelected Down selected texture.
		 * @param clickSound Click sound effect.
		 */		
		public function ToggleButton(upStateNormal:Texture, upStateSelected:Texture = null, textNormal:String="", textSelected:String="", downStateNormal:Texture=null, downStateSelected:Texture=null, clickSound:ByteArray = null)
		{
			super(upStateNormal, textNormal, downStateNormal, clickSound);
			
			this.upStateNormal = upStateNormal;
			this.upStateSelected = upStateSelected ? upStateSelected : upStateNormal;
			this.downStateNormal = downStateNormal ? downStateNormal : upStateNormal;
			this.downStateSelected = downStateSelected ? downStateSelected : upStateSelected;
			this.textNormal = textNormal;
			this.textSelected = textSelected;
		}
		
		private var _selected:Boolean;

		/**
		 * Is selected state. 
		 */		
		public function get selected():Boolean
		{
			return _selected;
		}

		public function set selected(value:Boolean):void
		{
			if(_selected != value)
			{
				_selected = value;
			
				upState = selected ? upStateSelected : upStateNormal;
				downState = selected ? downStateSelected : downStateNormal;
				text = selected ? textSelected : textNormal;
			}
		}
		
		/**
		 * @private 
		 */		
		override protected function touchHandler(e:TouchEvent):void
		{
			super.touchHandler(e);
			if (e.getTouch(this, TouchPhase.BEGAN))
				selected = !selected;
		}
	}
}