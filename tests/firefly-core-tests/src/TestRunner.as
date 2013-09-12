// =================================================================================================
//
//	Firefly Framework
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package
{
	import com.firefly.core.components.GameApp;
	
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.utils.setTimeout;
	
	import org.flexunit.internals.TraceListener;
	import org.flexunit.runner.FlexUnitCore;
	
	import starling.core.Starling;
	import starling.display.Sprite;
	
	import test.asset.AssetTestSuite;
	import test.async.AsyncTestSuite;
	import test.audio.AudioBundlesTestSuit;
	import test.concurrency.ConcurrencyTestSuite;
	import test.textures.TextureBundlesTestSuit;
	import test.textures.loaders.LoadersTestSuit;
	
	public class TestRunner extends GameApp
	{
		private var _starling:Starling;
		
		public function TestRunner()
		{
			super();

			setGlobalLayoutContext(768, 1024);
			
			setTimeout(runTests, 1000);
		}
		
		private function runTests():void
		{
			_starling  = new Starling(Sprite, stage, new Rectangle(0,0, stage.stageWidth,stage.stageHeight));
			_starling.start();
			
			var core : FlexUnitCore = new FlexUnitCore();
			core.addListener( new TraceListener() ); 
			core.run(AsyncTestSuite, 
				 	 AssetTestSuite, 
					 ConcurrencyTestSuite,
					 LoadersTestSuit, 
					 TextureBundlesTestSuit, 
					 AudioBundlesTestSuit);
			
			core.addEventListener("testsComplete", testCompleteHandler);
		}
		
		private function testCompleteHandler(event:Event):void
		{
			NativeApplication.nativeApplication.exit();
		}
	}
}