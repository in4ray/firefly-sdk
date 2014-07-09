package test.bundles.helpers
{
	import com.firefly.core.firefly_internal;
	import com.firefly.core.async.Future;
	import com.firefly.core.assets.TextureBundle;
	
	import flash.display.BitmapData;
	import flash.utils.ByteArray;
	
	import org.flexunit.Assert;

    use namespace firefly_internal;
	
	public class FakeTextureBundle extends TextureBundle
	{
		public function FakeTextureBundle(generateMipMaps:Boolean=false)
		{
			super(generateMipMaps);
		}
		
		override firefly_internal function createTextureFromBitmapData(id:*, bitmapData:BitmapData):void
		{
			Assert.assertNotNull(bitmapData);	
		}
		
		override firefly_internal function createTextureFromByteArray(id:*, data:ByteArray):void
		{
			Assert.assertNotNull(data);	
		}
		
		override firefly_internal function createTextureFromBitmapDataList(id:*, bitmapDataList:Vector.<BitmapData>):void
		{
			Assert.assertTrue(bitmapDataList.length > 0);	
		}
		
		override firefly_internal function createTextureForDragonBones(id:*, data:ByteArray, autoScale:Boolean = true):Future
		{
			Assert.assertNotNull(data);	
			return null;
		}
		
		override firefly_internal function createTextureAtlasFromBitmapData(id:*, bitmapData:BitmapData, xml:XML):void
		{
			Assert.assertNotNull(bitmapData);	
			Assert.assertNotNull(xml);	
		}
		
		override firefly_internal function createTextureAtlasFromByteArray(id:*, data:ByteArray, xml:XML):void
		{
			Assert.assertNotNull(data);	
			Assert.assertNotNull(xml);	
		}
	}
}