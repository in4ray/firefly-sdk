package model
{
	import com.in4ray.gaming.binding.BindableBoolean;
	import com.in4ray.gaming.binding.BindableUint;

	public class Level
	{
		public function Level(name:String)
		{
			this.name = name;
		}
		
		public var name:String;
		
		public var locked:BindableBoolean = new BindableBoolean(true);
		
		public var completed:BindableBoolean = new BindableBoolean();
		
		public var bestScore:BindableUint = new BindableUint();
	}
}