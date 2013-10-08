package com.in4ray.gaming.components
{
	import com.firefly.core.async.Completer;
	import com.firefly.core.async.Future;
	import com.in4ray.gaming.layouts.$height;
	import com.in4ray.gaming.layouts.$width;
	
	import starling.animation.IAnimatable;
	
	public class Timer extends Sprite implements IAnimatable
	{
		private var _completer:Completer;
		
		private var _time:Number;
		private var _currentTime:Number;
		
		private var _label:TextField;
		
		private var _countdown:Boolean;
		
		private var _format:String = "mm:ss.SSS";
		
		private var _precision:Number;
		
		private var _hasHours:Boolean;
		private var _hasMinutes:Boolean;
		private var _hasSeconds:Boolean;
		private var _hasMilliSeconds:Boolean;
		
		public function Timer(format:String = "mm:ss.SSS")
		{
			super();
			
			_format = format;
			
			_precision = Math.min(1000, Math.pow(10, _format.split("S").length-1));
			
			_hasHours = _format.indexOf("h") != -1;
			_hasMinutes = _format.indexOf("m") != -1;
			_hasSeconds = _format.indexOf("s") != -1;
			_hasMilliSeconds = _format.indexOf("S") != -1;
			
			_label = new TextField("");
			addElement(_label, $width(100).pct, $height(100).pct);
		}
		
		public function label(fontName:String="Verdana", fontSize:Number=12, color:uint=0, bold:Boolean=false, autoScale=false):TextField
		{
			_label.fontName = fontName;
			_label.fontSize = fontSize;
			_label.color = color;
			_label.bold = bold;
			_label.autoScale = autoScale;
			
			return _label;
		}
		
		public function start(time:Number, countdown:Boolean=false):Future
		{
			_time = time;
			_countdown = countdown;
			_completer = new Completer();
			
			_currentTime = _countdown ? _time : 0;
			
			return _completer.future;
		}
		
		public function advanceTime(time:Number):void
		{
			if(_countdown)
				_currentTime = Math.max(0, _currentTime - time);
			else
				_currentTime = Math.min(_time, _currentTime + time);
			
			var hours:int = _hasHours ? Math.floor(_currentTime/3600) : 0;
			var minutes:int = _hasMinutes ? Math.floor(_currentTime/60 - hours*3600) : 0;
			var seconds:int = _hasSeconds ? Math.floor(_currentTime - hours*3600 - minutes*60) : 0;
			var milliseconds:int = _hasMilliSeconds ? (_currentTime - seconds - hours*3600 - minutes*60)*_precision : 0;
			
			_label.text = formatString(hours, minutes, seconds, milliseconds);
			
			if((_countdown && _currentTime <= 0) || (!_countdown && _currentTime >= _time))
				_completer.complete();
		}
		
		protected function formatString(hours:int, minutes:int, seconds:int, milliseconds:int):String
		{
			var text:String = _format;
			
			if(_hasHours)
			{
				text = formatValue(text, "hh", hours);
				text = formatValue(text, "h", hours);
			}
			
			if(_hasMinutes)
			{
				text = formatValue(text, "mm", minutes);
				text = formatValue(text, "m", minutes);
			}
			
			if(_hasSeconds)
			{
				text = formatValue(text, "ss", seconds);
				text = formatValue(text, "s", seconds);
			}
			
			if(_hasMilliSeconds)
			{
				text = formatValue(text, "SSS", milliseconds);
				text = formatValue(text, "SS", milliseconds);
				text = formatValue(text, "S", milliseconds);
			}
			
			return text;
		}
		
		
		private function formatValue(text:String, pattern:String, value:int):String
		{
			if(text.indexOf(pattern) > -1)
			{
				text = text.replace(pattern, "000".substr(0, Math.max(0, pattern.length - value.toString().length)) + value);
			}
			
			return text;
		}
	}
}