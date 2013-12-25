package test.effects
{
	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class EffectsTestSuit
	{
		public var fadeTest:FadeTest;
		public var rotateTest:RotateTest;
		public var scaleTest:ScaleTest;
		public var sequenceTest:SequenceTest;
		public var parallelTest:ParallelTest;
	}
}