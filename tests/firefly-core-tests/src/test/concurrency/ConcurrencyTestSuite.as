package test.concurrency
{
	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class ConcurrencyTestSuite
	{
		public var task:TaskTest;
		public var thread:GreenThreadTest;
	}
}