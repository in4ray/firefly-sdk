package test.model.helpers
{
	import com.firefly.core.binding.Binding;
	import com.firefly.core.model.Model;
	
	public class GameModel extends Model
	{
		private var _prop:String;
		
		public var prop2:String;
		
		public function GameModel(name:String)
		{
			super(name);
		}
		
		public function get onProp():Binding { return bindingProvider.getBinding("onProp"); }
		
		public function get prop():String { return _prop; }
		public function set prop(value:String):void 
		{ 
			_prop = value; 
			onProp.update(_prop);
		}

		override protected function init():void
		{
			prop = "value";
		}
		
		override protected function read(data:Object):void
		{
			prop = data.prop;
		}
		
		override protected function write(data:Object):void
		{
			data.prop = prop;
		}
	}
}