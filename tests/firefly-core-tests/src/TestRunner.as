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
	import com.firefly.core.Firefly;
	import com.firefly.core.firefly_internal;
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
	import test.bundles.AdditionalBundlesTestSuit;
	import test.bundles.AudioBundlesTestSuit;
	import test.bundles.TextureBundlesTestSuit;
	import test.concurrency.ConcurrencyTestSuite;
	import test.effects.EffectsTestSuit;
	import test.layouts.constraints.ConstraintsTestSuit;
	import test.loaders.LoadersTestSuit;
	import test.model.ModelTestSuit;
	
	public class TestRunner extends GameApp
	{
		private var _starling:Starling;
		
		public function TestRunner()
		{
			super(null);
			
			setGlobalLayoutContext(768, 1024);
			
			setTimeout(runTests, 1000);
		}
		
		override protected function init():void
		{
			// do not switch to any view states
		}
		
		private function runTests():void
		{
			Firefly.current.firefly_internal::updateSize(384, 512);
			
			_starling  = new Starling(Sprite, stage, new Rectangle(0,0, stage.stageWidth,stage.stageHeight));
			_starling.start();
			
			var core : FlexUnitCore = new FlexUnitCore();
			core.addListener( new TraceListener() ); 
			core.run(AsyncTestSuite, 
				 	 AssetTestSuite, 
					 ConcurrencyTestSuite,
					 LoadersTestSuit, 
					 TextureBundlesTestSuit, 
					 AudioBundlesTestSuit,
					 ConstraintsTestSuit,
					 EffectsTestSuit,
					 AdditionalBundlesTestSuit,
					 ModelTestSuit);
			
			core.addEventListener("testsComplete", testCompleteHandler);
		}
		
		private function testCompleteHandler(event:Event):void
		{
			NativeApplication.nativeApplication.exit();
		}
	}
}