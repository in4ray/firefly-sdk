package model
{
	import com.in4ray.gaming.binding.BindableArray;
	import com.in4ray.gaming.binding.BindableBoolean;
	import com.in4ray.gaming.core.SingletonLocator;
	import com.in4ray.gaming.model.Model;
	import com.in4ray.gaming.sound.Audio;
	
	import starling.animation.Tween;
	import starling.core.Starling;
	
	public class GameModel extends Model
	{
		/**
		 * Constractor. 
		 */		
		public function GameModel()
		{
			super("LandscapeGameTemplate4");
			
			for (var j:int = 0; j < 5; j++) 
			{
				var bunlde:Bundle = new Bundle("Bundle " + j);
				// create levels
				for (var i:int = 1; i <= 60; i++) 
				{
					bunlde.levels.add(new Level(i.toString()));
				}
				
				bundles.add(bunlde);
			}

			// unlock first bundle
			bundles.value[0].locked.value = false;
			// unlock first level
			bundles.value[0].levels.value[0].locked.value = false;
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
			
			Audio.soundVolume.value = _muteSounds ? 0 : 1;
			
			var twen:Tween = new Tween(Audio.musicVolume, 1);
			twen.animate("value", _muteSounds ? 0 : 1);
			Starling.juggler.add(twen);
		}
		
		/**
		 * Pause - storable property. Equals 'true' during game otherwise equals 'false'.
		 */		
		public var pause:BindableBoolean = new BindableBoolean();
		
		/**
		 * List of bundles. 
		 */		
		public var bundles:BindableArray = new BindableArray();
		
		/**
		 * Current selected level. 
		 */		
		public var currentBundle:BindableBundle = new BindableBundle();
		
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