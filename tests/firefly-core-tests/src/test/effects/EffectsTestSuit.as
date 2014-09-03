package test.effects
{
	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class EffectsTestSuit
	{
		public var animatePropTest:AnimatePropertyTest;
		public var fadeTest:FadeTest;
		public var rotateTest:RotateTest;
		public var scaleTest:ScaleTest;
		public var sequenceTest:SequenceTest;
		public var parallelTest:ParallelTest;
		public var layoutAnimationTest:LayoutAnimationTest;
		public var moveAnimationTest:MoveAnimationTest;
	}
}