package test.async
{
	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class AsyncTestSuite
	{
		public var future:FutureTest;
		public var completer:CompleterTest;
		public var nextFrameCompleter:NextFrameCompleterTest;
		public var delayedCompleter:DelayedCompleterTest;
		public var groupCompleter:GroupCompleterTest;
	}
}