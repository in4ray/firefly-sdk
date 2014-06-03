package test.model.helpers
{
	import com.firefly.core.model.Model;
	
	public class GameModel extends Model
	{
		public var prop:String;
		
		public function GameModel(name:String)
		{
			super(name);
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