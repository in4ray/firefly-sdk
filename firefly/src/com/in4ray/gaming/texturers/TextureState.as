// =================================================================================================
//
//	in4ray Gaming SDK
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.in4ray.gaming.texturers
{
	import com.in4ray.gaming.async.callAsync;
	
	import avmplus.getQualifiedClassName;

	/**
	 * State of texture bundles. 
	 * 
	 * @example The following example shows how to create and load texture state:
	 *
	 * <listing version="3.0">
import com.in4ray.games.core.components.Sprite;
import com.in4ray.games.core.texturers.TextureState;

public class MainView extends Sprite
{
	private var textureState:TextureState;
	
	public function MainView()
	{
		textureState = new TextureState(new MenuTextureBundle(), new GameTextureBundle());
		textureState.loadAsync(onLoadingTexturesComplete);
	}
	
	private function onLoadingTexturesComplete():void
	{
		// show view
	}
} 
 
 
import com.in4ray.games.core.texturers.TextureBundle;
import starling.textures.Texture;
import textures.MyFXG;

public class GameTextureBundle extends TextureBundle
{
	public function GameTextureBundle()
	{
		super();
	}
	
	override protected function registerTextures():void
	{
		registerTexture(MyFXG);
	}
	
	public function get myFXG():Texture
	{
		return getTexture(MyFXG);
	}
}
	 * </listing> 
	 */	
	public class TextureState
	{
		/**
		 * Constaructor.
		 *  
		 * @param bundles One or several texture bundles.
		 */		
		public function TextureState(...bundles)
		{
			this.bundles = bundles;
		}
		
		public function set bundles(bundles:Array):void
		{
			for each (var bundle:TextureBundle in bundles) 
			{
				addBundle(bundle);
			}
			
		}
		
		private var _bundles:Vector.<TextureBundle> = new Vector.<TextureBundle>();

		/**
		 * Returns all texture bundles.
		 *  
		 * @return Vector of texture bundles. 
		 */		
		public function getBundles():Vector.<TextureBundle>
		{
			return _bundles.slice();
		}

		
		/**
		 * Add Texture bundle. 
		 * @param bundle Texture bundle.
		 */		
		public function addBundle(bundle:TextureBundle):void
		{
			_bundles.push(bundle);
		}
		
		/**
		 * Load all bundles synchronously. 
		 */		
		public function load():void
		{
			CONFIG::debugging {trace("[in4ray] loading texture state [" + getQualifiedClassName(this) + "]")};
			for each (var bundle:TextureBundle in _bundles) 
			{
				bundle.load();	
			}
		}
		
		/**
		 * Load all bundles asynchronously. Use it if you want to show animated loading indicator.
		 * @param callback Function that will be called on complete of loading.
		 * @param params Parameters for callback function.
		 */		
		public function loadAsync(callback:Function=null, ...params):void
		{
			CONFIG::debugging {trace("[in4ray] loading texture state async [" + getQualifiedClassName(this) + "]")};
			for each (var bundle:TextureBundle in _bundles) 
			{
				bundle.loadAsync();	
			}
			
			callAsync.apply(null, [callback].concat(params));
		}
		
		/**
		 * Release all bundles. 
		 */		
		public function release():void
		{
			CONFIG::debugging {trace("[in4ray] releasing texture state [" + getQualifiedClassName(this) + "]")};
			for each (var bundle:TextureBundle in _bundles) 
			{
				bundle.release();	
			}
		}
		
		/**
		 * Release bundles that are in this state but not in next state. 
		 * @param nextState Next texture state.
		 */		
		public function releaseDifference(nextState:TextureState):void
		{
			CONFIG::debugging {trace("[in4ray] releasing texture state [" + getQualifiedClassName(this) + "]")};
			for each (var bundle:TextureBundle in _bundles) 
			{
				if(!nextState || !findBundle(nextState, bundle.bundleName))
					bundle.release();	
			}
		}
		
		private function findBundle(state:TextureState, bundleName:String):TextureBundle
		{
			for each (var bundle:TextureBundle in state.getBundles()) 
			{
				if(bundle.bundleName == bundleName)
					return bundle;
			}
			
			return null;
		}
	}
}