package model
{
	import com.in4ray.gaming.binding.Bindable;

	public class BindableLevel extends Bindable
	{
		/**
		 * Constuctor.
		 *  
		 * @param value Initial property value.
		 */
		public function BindableLevel(value:Level = null)
		{
			super(value);
		}
		
		public function set value(value:Level):void
		{
			setValue(value);
		}
		
		/**
		 * Property Level value. 
		 */	
		public function get value():Level
		{
			return getValue() as Level;
		}
	}
}
