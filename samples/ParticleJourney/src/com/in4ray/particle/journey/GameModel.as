package com.in4ray.particle.journey
{
	import com.firefly.core.model.Model;
	
	public class GameModel extends Model
	{
		private var _name:String;
        private var _count:int;
		
		public function GameModel(name:String)
		{
			super(name);

            count = 1;
		}

        public function get count():int { return _count; }
        public function set count(value:int):void
        {
            _count = value;
			bindingProvider.getBinding("onCount").notify(value);
        }
		
		override protected function init():void
		{
			_name = "ParticleJourney";
		}
		
		override protected function write(data:Object):void
		{
			data.appName = _name;
		}
		
		override protected function read(data:Object):void
		{
			_name = data.appName;
		}
    }
}