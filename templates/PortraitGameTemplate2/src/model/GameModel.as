package model
{
	import com.firefly.core.Firefly;
	import com.in4ray.gaming.binding.BindableArray;
	import com.in4ray.gaming.binding.BindableBoolean;
	import com.in4ray.gaming.core.SingletonLocator;
	import com.in4ray.gaming.model.Model;
	
	public class GameModel extends Model
	{
		/**
		 * Constractor. 
		 */		
		public function GameModel()
		{
			super("PortraitGameTemplate2");
			
			// create levels
			for (var i:int = 0; i < 5; i++) 
			{
				levels.add(new Level("Level " + i));
			}
			
			// unlock first level
			levels.value[0].locked.value = false;
		}
		
		/**
		 * Static function to get singleton model instance. 
		 */		
		public static function getInstance():GameModel
		{
			return SingletonLocator.getInstance(GameModel);			
		}
		
		private var _muteSounds:Boolean = false;
		
		/**
		 * Gat mute sounds value.
		 * default: false
		 */		
		public function get muteSounds():Boolean
		{
			return _muteSounds;
		}
		
		/**
		 * Set mute sounds value. 
		 */		
		public function set muteSounds(value:Boolean):void
		{
			_muteSounds = value;
			
			Firefly.current.audioMixer.fadeMusic(_muteSounds ? 0 : 1, 0.5);
			Firefly.current.audioMixer.sfxVolume = _muteSounds ? 0 : 1;
		}
		
		/**
		 * Pause - storable property. Equals 'true' during game otherwise equals 'false'.
		 */		
		public var pause:BindableBoolean = new BindableBoolean();
		
		/**
		 * List of levels. 
		 */		
		public var levels:BindableArray = new BindableArray();
		
		/**
		 * Current selected level. 
		 */		
		public var currentLevel:BindableLevel = new BindableLevel();
		
		/**
		 * @inheritDoc
		 */	
		override public function load(data:Object):void
		{
			muteSounds = data.muteSounds;
		}
		
		/**
		 * @inheritDoc
		 */	
		override public function save(data:Object):void
		{
			data.muteSounds = muteSounds;
		}
		
		/**
		 * @inheritDoc
		 */	
		override public function sleep(data:Object):void
		{
			save(data);
		}
		
		/**
		 * @inheritDoc
		 */	
		override public function wakeUp(data:Object):void
		{
			load(data);
		}
	}
}