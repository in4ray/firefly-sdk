package test.loaders
{
	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class LoadersTestSuit
	{
		public var bitmapLoader:BitmapLoaderTest;
		public var fxfLoader:FXGLoaderTest;
		public var atfLoader:ATFLoaderTest;
		public var xmlLoader:AtlasXMLLoaderTest;
		public var swfLoader:SWFLoaderTest;
		public var dbLoader:DragonBonesLoaderTest;
		public var atlasBitmapLoader:AtlasBitmapLoaderTest;
		public var atlasATFLoader:AtlasATFLoaderTest;
		public var atlasFXGLoader:AtlasFXGLoaderTest;
		public var fontXMLLoader:FontXMLLoaderTest;
		public var localeXMLLoader:LocaleXMLLoaderTest;
		public var audioLoaderTest:AudioLoaderTest;
		public var embededAudioLoaderTest:EmbededAudioLoaderTest;
	}
}