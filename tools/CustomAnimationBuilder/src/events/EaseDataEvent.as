package events
{
	import com.firefly.core.effects.easing.IEaser;
	
	import flash.events.Event;
	
	public class EaseDataEvent extends Event
	{
		public static const EASIER_CHANGE:String = "easierChange";
		
		public var easier:IEaser;
		
		public function EaseDataEvent(type:String, easier:IEaser, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			
			this.easier = easier;
		}
	}
}