// =================================================================================================
//
//	Firefly Framework
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.assets
{
	import com.firefly.core.async.Future;
	import com.firefly.core.async.GroupCompleter;
	import com.firefly.core.utils.Log;
	
	/** State for grouping several asset bundles (textures or sounds).
	 * 
	 *  @example The following code shows how to create and load asset state:
	 *  <listing version="3.0">
	 *************************************************************************************
 function main():void
 {
 	var state:AssetState = new AssetState("GameState", new CommonTextureBundle(), new GameTextureBundle());
 	state.load().progress(onStateProgress).then(onStateLoaded);
 }
 &#xA0;
 function onStateProgress(ratio:Number):void
 {
 	trace("Loading: " + ratio~~100 + "%");
 }
 &#xA0;
 function onStateLoaded():void
 {
 	trace("Asset state loaded");
 }
	 *************************************************************************************
	 *  </listing> */	
	public class AssetState
	{
		private var _bundles:Vector.<IAssetBundle> = new Vector.<IAssetBundle>();
		
		/** Constructor.
		 *  @param name Unique name of state.
		 *  @param bundles One or several asset bundles. */		
		public function AssetState(name:String, ...bundles)
		{
			this.name = name;
			this.bundles = bundles;
		}
		
		/** Unique name of state. */		
		public var name:String;
		
		/** Setter for adding bundles as array, mainly used by mxml.
		 *  @param bundles Array of asset bundles. */		
		public function set bundles(bundles:Array):void
		{
			for each (var bundle:IAssetBundle in bundles) 
			{
				addBundle(bundle);
			}
		}
		
		/** Returns all asset bundles.
		 *  @return Vector of texture bundles. */		
		public function getBundles():Vector.<IAssetBundle>
		{
			return _bundles.slice();
		}
		
		/** Add Asset bundle. 
		 *  @param bundle asset bundle. */		
		public function addBundle(bundle:IAssetBundle):void
		{
			_bundles.push(bundle);
		}
		
		/** Load all bundles asynchronously. 
		 *  @return Future object for callback. */		
		public function load():Future
		{
			CONFIG::debug {
				Log.info("Loading texture state {0}.", name);
			};
			
			if(_bundles.length > 0)
			{
				var group:GroupCompleter = new GroupCompleter();
				for each (var bundle:IAssetBundle in _bundles) 
				{
					group.append(bundle.load());	
				}
				return group.future;
			}
			
			return Future.nextFrame();
		}
		
		/** Release all bundles. */		
		public function release():void
		{
			CONFIG::debug {
				Log.info("Releasing texture state {0}.", name);
			};
			
			for each (var bundle:IAssetBundle in _bundles) 
			{
				bundle.release();	
			}
		}
		
		/** Release bundles that are in this state but not in next state. 
		 *  @param nextState Next asset state. */		
		public function releaseDifference(nextState:AssetState):void
		{
			CONFIG::debug {
				Log.info("Releasing differences from texture state {0}.", name);
			};
			
			for each (var bundle:IAssetBundle in _bundles) 
			{
				if(!nextState || !findBundle(nextState, bundle.name))
					bundle.release();	
			}
		}
		
		/** @private */		
		private function findBundle(state:AssetState, bundleName:String):IAssetBundle
		{
			for each (var bundle:IAssetBundle in state.getBundles()) 
			{
				if(bundle.name == bundleName)
					return bundle;
			}
			
			return null;
		}
	}
}