package model
{
	import com.in4ray.gaming.binding.Bindable;
	
	public class BindableBundle extends Bindable
	{
		/**
		 * Constuctor.
		 *  
		 * @param value Initial property value.
		 */
		public function BindableBundle(value:Level = null)
		{
			super(value);
		}
		
		public function set value(value:Bundle):void
		{
			setValue(value);
		}
		
		/**
		 * Property Level value. 
		 */	
		public function get value():Bundle
		{
			return getValue() as Bundle;
		}
	}
}