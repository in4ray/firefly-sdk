package com.in4ray.particle.journey
{
	import com.firefly.core.model.Model;
	
	public class GameModel extends Model
	{
		private var _name:String;
		
		public function GameModel(name:String)
		{
			super(name);
		}
		
		override protected function init():void
		{
			_name = "ParticleJourney";
			
			trace("First init.");
		}
		
		override protected function write(data:Object):void
		{
			data.appName = _name;
			trace("Data saved");
		}
		
		override protected function read(data:Object):void
		{
			_name = data.appName;
			trace(_name);
			trace("Data loaded");
		}
	}
}