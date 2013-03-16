package views
{
	import com.in4ray.gaming.components.Quad;
	import com.in4ray.gaming.components.Sprite;
	import com.in4ray.gaming.layouts.$height;
	import com.in4ray.gaming.layouts.$width;
	
	/**
	 * Black view. Intermediate black screen between other game viewes. 
	 */	
	public class BlackView extends Sprite
	{
		/**
		 * Constractor. 
		 */		
		public function BlackView()
		{
			super();
			
			var quad:Quad = new Quad(0);
			addElement(quad, $width(100).pct, $height(100).pct);
		}
	}
}