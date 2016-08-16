package test.effects
{
	import com.firefly.core.effects.builder.AnimationBuilder;

	/** Helper class to hold AnimationBuilder as single instance */	
	public class AnimationBuilderHolder
	{
		/** Single AnimationBuilder instance */		
		public static var animator:AnimationBuilder = new AnimationBuilder();
	}
}