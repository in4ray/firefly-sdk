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
	import com.in4ray.gaming.core.GameGlobals;
	
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.SoftKeyboardEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.StageText;
	import flash.text.StageTextInitOptions;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextLineMetrics;
	import flash.text.engine.FontPosture;
	import flash.text.engine.FontWeight;
	import flash.ui.Keyboard;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.textures.Texture;
	
	[Event(name="change",                 type="flash.events.Event")]
	[Event(name="focusIn",                type="flash.events.FocusEvent")]
	[Event(name="focusOut",               type="flash.events.FocusEvent")]
	[Event(name="keyDown",                type="flash.events.KeyboardEvent")]
	[Event(name="keyUp",                  type="flash.events.KeyboardEvent")]
	[Event(name="softKeyboardActivate",   type="flash.events.SoftKeyboardEvent")]
	[Event(name="softKeyboardActivating", type="flash.events.SoftKeyboardEvent")]
	[Event(name="softKeyboardDeactivate", type="flash.events.SoftKeyboardEvent")]
	
	/**
	 * Stage text input component.
	 * Was originally got from http://blogs.adobe.com/cantrell/archives/2011/09/native-text-input-with-stagetext.html
	 * and changed a little bit.
	 */	
	public class NativeText extends Sprite
	{
		private var st:StageText;
		private var numberOfLines:uint;
		private var _width:uint, _height:uint;
		private var snapshot:starling.display.Image;
		private var _backgroundColor:uint = 0x000000;
		private var _fillBackground:Boolean = true;
		private var _padding:Number = 2;
		private var lineMetric:TextLineMetrics;
		
		/**
		 * Constructor.
		 *  
		 * @param numberOfLines Number of input lines.
		 */		
		public function NativeText(numberOfLines:uint = 1)
		{
			super();
			
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
			this.addEventListener(starling.events.Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			
			this.numberOfLines = numberOfLines;
			var stio:StageTextInitOptions = new StageTextInitOptions((this.numberOfLines > 1));
			this.st = new StageText(stio);
			this.st.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
		}
		
		
		private function keyDownHandler(event:KeyboardEvent):void
		{
			if(event.keyCode == Keyboard.BACK)
			{
				GameGlobals.gameApplication.stage.dispatchEvent(event);
				event.preventDefault();
			}
		}
		
		public override function addEventListener(type:String, listener:Function):void
		{
			if (this.isEventTypeStageTextSpecific(type))
			{
				this.st.addEventListener(type, listener);
			}
			else
			{
				super.addEventListener(type, listener);
			}
		}
		
		public override function removeEventListener(type:String, listener:Function):void
		{
			if (this.isEventTypeStageTextSpecific(type))
			{
				this.st.removeEventListener(type, listener);
			}
			else
			{
				super.removeEventListener(type, listener);
			}
		}
		
		private function isEventTypeStageTextSpecific(type:String):Boolean
		{
			return (type == flash.events.Event.CHANGE ||
				type == FocusEvent.FOCUS_IN ||
				type == FocusEvent.FOCUS_OUT ||
				type == KeyboardEvent.KEY_DOWN ||
				type == KeyboardEvent.KEY_UP ||
				type == SoftKeyboardEvent.SOFT_KEYBOARD_ACTIVATE ||
				type == SoftKeyboardEvent.SOFT_KEYBOARD_ACTIVATING ||
				type == SoftKeyboardEvent.SOFT_KEYBOARD_DEACTIVATE);
		}
		
		private function onAddedToStage(e:starling.events.Event):void
		{
			if(!freezed)
			{
				this.st.stage = Starling.current.nativeStage;
				this.renderText();
			}
		}
		
		private function onRemoveFromStage(e:starling.events.Event):void
		{
			this.st.stage = null;
		}
		
		override public function dispose():void
		{
			this.st.dispose();
			super.dispose();
		}
		
		public function set backgroundColor(backgroundColor:uint):void
		{
			this._backgroundColor = backgroundColor;
			this.renderText();
		}
		
		/**
		 * Color of text background. 
		 */	
		public function get backgroundColor():uint
		{
			return this._backgroundColor;
		}
		
		public function set fillBackground(value:Boolean):void
		{
			this._fillBackground = value;
			this.renderText();
		}
		
		/**
		 * Flag that indicates whether background should be filled by solid color. 
		 */	
		public function get fillBackground():Boolean
		{
			return this._fillBackground;
		}
		
		public function set padding(value:Number):void
		{
			this._padding = value;
			this.renderText();
		}
		
		/**
		 * Text padding from each side. 
		 */	
		public function get padding():Number
		{
			return this._padding;
		}
		
		//// StageText properties and functions ///
		
		public function set autoCapitalize(autoCapitalize:String):void
		{
			this.st.autoCapitalize = autoCapitalize;
		}
		
		public function set autoCorrect(autoCorrect:Boolean):void
		{
			this.st.autoCorrect = autoCorrect;
		}
		
		public function set color(color:uint):void
		{
			this.st.color = color;
		}
		
		public function set displayAsPassword(displayAsPassword:Boolean):void
		{
			this.st.displayAsPassword = displayAsPassword;
		}
		
		public function set editable(editable:Boolean):void
		{
			this.st.editable = editable;
		}
		
		public function set fontFamily(fontFamily:String):void
		{
			this.st.fontFamily = fontFamily;
		}
		
		public function set fontPosture(fontPosture:String):void
		{
			this.st.fontPosture = fontPosture;
		}
		
		public function set fontSize(fontSize:uint):void
		{
			this.st.fontSize = fontSize;
			this.renderText();
		}
		
		public function set fontWeight(fontWeight:String):void
		{
			this.st.fontWeight = fontWeight;
		}
		
		public function set locale(locale:String):void
		{
			this.st.locale = locale;
		}
		
		public function set maxChars(maxChars:int):void
		{
			this.st.maxChars = maxChars;
		}
		
		public function set restrict(restrict:String):void
		{
			this.st.restrict = restrict;
		}
		
		public function set returnKeyLabel(returnKeyLabel:String):void
		{
			this.st.returnKeyLabel = returnKeyLabel;
		}
		
		/**
		 * @copy flash.text.StageText#selectionActiveIndex
		 */	
		public function get selectionActiveIndex():int
		{
			return this.st.selectionActiveIndex;
		}
		
		/**
		 * @copy flash.text.StageText#selectionAnchorIndex
		 */	
		public function get selectionAnchorIndex():int
		{
			return this.st.selectionAnchorIndex;
		}
		
		public function set softKeyboardType(softKeyboardType:String):void
		{
			this.st.softKeyboardType = softKeyboardType;
		}
		
		public function set text(text:String):void
		{
			this.st.text = text;
		}
		
		/**
		 * @copy flash.text.StageText#text
		 */
		public function get text():String
		{
			return this.st.text;
		}
		
		public function set textAlign(textAlign:String):void
		{
			this.st.textAlign = textAlign;
		}
		
		public override function set visible(visible:Boolean):void
		{
			super.visible = visible;
			this.st.visible = visible;
		}
		
		/**
		 * @copy flash.text.StageText#multiline
		 */
		public function get multiline():Boolean
		{
			return this.st.multiline;
		}
		
		/**
		 * @copy flash.text.StageText#assignFocus()
		 */
		public function assignFocus():void
		{
			this.st.assignFocus();
		}
		
		/**
		 * @copy flash.text.StageText#selectRange()
		 */
		public function selectRange(anchorIndex:int, activeIndex:int):void
		{
			this.st.selectRange(anchorIndex, activeIndex);
		}
		
		private var freezed:Boolean;
		
		/**
		 * Creates bitmap copy of image and remove native stage text. Used for animations.
		 */		
		public function freeze():void
		{
			freezed = true;
			
			if(!this.st.stage)
			{
				this.st.stage = Starling.current.nativeStage;
				this.renderText();
			}
			
			var viewPortRectangle:Rectangle = this.getViewPortRectangle();
			var bmd:BitmapData = new BitmapData(this.st.viewPort.width, this.st.viewPort.height);
			this.st.drawViewPortToBitmapData(bmd);
			this.snapshot = new starling.display.Image(Texture.fromBitmapData(bmd));
			var point:Point = globalToLocal(new Point(viewPortRectangle.x, viewPortRectangle.y));
			this.snapshot.x = point.x;
			this.snapshot.y = point.y;
			this.addChild(this.snapshot);
			this.st.visible = false;
		}

		/**
		 * Remove bitmap copy of image and add native stage text. Used for animations.
		 */
		public function unfreeze():void
		{
			if (this.snapshot != null && this.contains(this.snapshot))
			{
				this.removeChild(this.snapshot);
				this.snapshot = null;
				
				renderText();
				if(parent)
					this.st.stage = Starling.current.nativeStage;
				
				this.st.visible = true;
			}
			
			freezed = false;
		}
		
		//// Functions that must be overridden to make this work ///
		
		public override function get width():Number
		{
			return this._width;
		}
		
		public override function get height():Number
		{
			return this._height;
		}
		
		/**
		 * @inheritDoc 
		 */		
		public override function setActualPosition(x:Number, y:Number):void
		{
			super.setActualPosition(x, y);
			this.renderText();
		}
		
		/**
		 * @inheritDoc 
		 */	
		public override function setActualSize(w:Number, h:Number):void
		{
			this._width = w;
			super.setActualSize(w, h);
			this.renderText();
		}
		
		private function renderText():void
		{
			if (this.stage == null || !this.stage.contains(this)) return;
			this.lineMetric = null;
			this.calculateHeight();
			this.st.viewPort = this.getViewPortRectangle();
			this.drawBackground(this);
		}
		
		private function getViewPortRectangle():Rectangle
		{
			var totalFontHeight:Number = this.getTotalFontHeight();
			var rect:Rectangle =  new Rectangle(localToGlobal(new Point(_padding, 0)).x, localToGlobal(new Point(0, _padding)).y,
				Math.round(localToGlobal(new Point(width - _padding, 0)).x - localToGlobal(new Point(_padding, 0)).x),
				Math.round((totalFontHeight + (totalFontHeight - this.st.fontSize)) * this.numberOfLines));

			rect.x = Math.max(rect.x, 0);
			rect.y = Math.max(rect.y, 0);
			rect.width = Math.max(rect.width, 1);
			rect.height = Math.max(rect.height, 1);
			
			return rect;
		}
		
		private var background:starling.display.Quad;
		
		private function drawBackground(s:Sprite):void
		{
			if (!_fillBackground) return;
			
			if(background)
				removeChild(background);
			background = new starling.display.Quad(_width, _height, _backgroundColor);
			addChild(background);
		}
		
		private function calculateHeight():void
		{
			var totalFontHeight:Number = this.getTotalFontHeight();
			this._height = (totalFontHeight * this.numberOfLines) + 2*_padding;
		}
		
		private function getTotalFontHeight():Number
		{
			if (this.lineMetric != null) return (this.lineMetric.ascent + this.lineMetric.descent);
			var textField:flash.text.TextField = new flash.text.TextField();
			var textFormat:TextFormat = new TextFormat(this.st.fontFamily, this.st.fontSize, null, (this.st.fontWeight == FontWeight.BOLD), (this.st.fontPosture == FontPosture.ITALIC));
			textField.defaultTextFormat = textFormat;
			textField.text = "QQQ";
			this.lineMetric = textField.getLineMetrics(0);
			return (this.lineMetric.ascent + this.lineMetric.descent);
		}
	}
}