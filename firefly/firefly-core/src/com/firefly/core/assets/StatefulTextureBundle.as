// =================================================================================================
//
//	Firefly Framework
//	Copyright 2016 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.assets
{
	import com.firefly.core.firefly_internal;
	import com.firefly.core.utils.Log;
	import com.firefly.core.utils.SingletonLocator;
	
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	
	import avmplus.getQualifiedClassName;
	
	import starling.textures.Texture;
	
	use namespace firefly_internal;
	
	/** Stateful texture bundle class for loading, creating and storing different textures in the same 
	 *  game state base on specific asset state.
	 * 
	 *  @see com.firefly.core.assets.StatefulBundle 
	 * 
	 *  @example The following code shows how to register different asset states with texture 
	 *			 bundles and use it:
	 *  <listing version="3.0">
	 *************************************************************************************
public class GameTextureBundle extends StatefulTextureBundle
{
	override protected function regBundles():void
	{
		regState("gameWorld_1", new GameWorld1TextureBundle());
		regState("gameWorld_1", new GameWorld2TextureBundle());
			
		switchToState("gameWorld_1");
	}
	
	// in this case game background will be different for each asset state
	public function get gameBkg():Texture { return getTexture("gameBackground");
}
	 *************************************************************************************
	 *  </listing> */
	public class StatefulTextureBundle extends StatefulBundle
	{
		/** @private */
		firefly_internal var _textures:Dictionary;
		/** @private */
		firefly_internal var _textureLists:Dictionary;
		/** @private */
		firefly_internal var _dbFactories:Dictionary;
		/** @private */
		firefly_internal var _textureAtlases:Dictionary;
		
		/** Constructor. */		
		public function StatefulTextureBundle()
		{
			_name = getQualifiedClassName(this);
			_singleton = SingletonLocator.getInstance(getDefinitionByName(_name) as Class, this);
			
			if(_singleton == this)
			{
				_textures = new Dictionary();
				_dbFactories = new Dictionary();
				_textureLists = new Dictionary();
				_textureAtlases = new Dictionary();
			}
			
			super();
		}
		
		/** @inheritDoc */
		override protected function regState(state:String, bundle:IAssetBundle):void
		{
			CONFIG::debug {
				if (!(bundle is TextureBundle))
				{
					Log.error("You can register only TextureBudle..", bundle);
				}
			};
			
			if(_singleton != this)
				return (_singleton as StatefulTextureBundle).regState(state, bundle);
			
			super.regState(state, bundle);
			
			(bundle as TextureBundle)._textures = _textures;
			(bundle as TextureBundle)._textureLists = _textureLists;
			(bundle as TextureBundle)._dbFactories = _dbFactories;
			(bundle as TextureBundle)._textureAtlases = _textureAtlases;
		}
		
		/** Find and return texture by id in current asset state.
		 *  @param id Texture id.
		 *  @return Texture instance in current state. */	
		public function getTexture(id:String):Texture
		{
			if(_singleton != this)
				return (_singleton as StatefulTextureBundle).getTexture(id);
			
			return _bundles[currentState].getTexture(id);
		}
	}
}