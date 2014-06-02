package test.bundles
{
	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class AdditionalBundlesTestSuit
	{
		public var fontBundle:FontBundleTest;
		public var particleBundle:ParticleBundleTest;
		public var localizationBundle:LocalizationBundleTest;
	}
}