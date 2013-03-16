package model
{
	import com.in4ray.gaming.binding.BindableArray;
	import com.in4ray.gaming.binding.BindableBoolean;
	import com.in4ray.gaming.binding.BindableUint;

	public class Bundle
	{
		public function Bundle(name:String)
		{
			this.name = name;
		}
		
		public var name:String;
		
		/**
		 * List of levels. 
		 */		
		public var levels:BindableArray = new BindableArray();
		
		public var locked:BindableBoolean = new BindableBoolean(true);
		
		public var completed:BindableBoolean = new BindableBoolean();
		
		public var bestScore:BindableUint = new BindableUint();
	}
}