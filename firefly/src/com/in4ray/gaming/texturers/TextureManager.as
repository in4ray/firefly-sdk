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
	/**
	 * Manager that manages texture bundles loading/unloading texture states. 
	 * 
	 * @example The following example shows how to use texture manager:
	 *
	 * <listing version="3.0">
import com.in4ray.games.core.components.Sprite;
import com.in4ray.games.core.texturers.TextureManager;
import com.in4ray.games.core.texturers.TextureState;

public class MainView extends Sprite
{
	private var textureManager:TextureManager;
	
	public function MainView()
	{
		var menuState:TextureState = new TextureState(new MenuTextureBundle(), new CommonTextureBundle());
		var gameState:TextureState = new TextureState(new GameTextureBundle(), new CommonTextureBundle());
		
		textureManager = new TextureManager(menuState, gameState);
		
		textureManager.switchToStateIndexAsync(0, onLoadingTexturesComplete);
	}
	
	private function onLoadingTexturesComplete():void
	{
		// show view
	}
}
	 * </listing>
	 */	
	public class TextureManager
	{
		/**
		 * Constaructor. 
		 * @param states one or several texture states.
		 */		
		public function TextureManager(...states)
		{
			this.states = states;
		}
		
		public function set states(states:Array):void
		{
			for each (var state:TextureState in states) 
			{
				addState(state);
			}
		}
		
		private var _states:Vector.<TextureState> = new Vector.<TextureState>();
		
		/**
		 * Get all texture states.
		 *  
		 * @return Vector of texture states. 
		 */		
		public function getStates():Vector.<TextureState>
		{
			return _states.slice();
		}
		
		/**
		 * Add texture state. 
		 * @param state Texture state.
		 */		
		public function addState(state:TextureState):void
		{
			if(_states.indexOf(state) == -1)
				_states.push(state);
		}
		
		private var currentState:TextureState;
		
		/**
		 * Load texture state and unload previous one synchronously. 
		 * @param state Texture state.
		 */		
		public function switchToState(state:TextureState):void
		{
			if(currentState != state)
			{
				if(currentState)
					currentState.releaseDifference(state);
				
				currentState = state;
				
				loadCurrentState();
			}
		}
		
		/**
		 * Load texture state by index and unload previous one synchronously. 
		 * @param index Index of texture state.
		 */		
		public function switchToStateIndex(index:int):void
		{
			if(_states.indexOf(currentState) != index)
			{
				if(index >= 0 && index < _states.length)
					switchToState(_states[index]);
				else
					switchToState(null);
			}
		}
		
		/**
		 * Release current texture state synchronously. 
		 */		
		public function releaseCurrentState():void
		{
			if(currentState)
				currentState.release();
		}
		
		/**
		 * Load current texture state. 
		 */		
		public function loadCurrentState():void
		{
			if(currentState && active)
				currentState.load();
		}
		
		/**
		 * Load current texture state asynchronously.
		 * Use it if you want to show animated loading indicator. 
		 * @param callback Function that will be called on complete of loading.
		 * @param params Parameters for callback function.
		 * 
		 */		
		public function loadCurrentStateAsync(callback:Function=null, ...params):void
		{
			if(currentState && active)
				currentState.loadAsync.apply(null, [callback].concat(params));
			else
				callback.apply(null, params);
		}
		
		/**
		 * Load texture state and unload previous one asynchronously.
		 * Use it if you want to show animated loading indicator.
		 * @param state texture state
		 * @param callback Function that will be called on complete of loading.
		 * @param params Parameters for callback function.
		 */		
		public function switchToStateAsync(state:TextureState, callback:Function=null, ...params):void
		{
			if(currentState != state)
			{
				if(currentState)
					currentState.releaseDifference(state);
				
				currentState = state;
				
				loadCurrentStateAsync.apply(null, [callback].concat(params));
			}
			else
			{
				callback.apply(null, params);
			}
		}
		
		/**
		 * Load texture state by index and unload previous one asynchronously. 
		 * Use it if you want to show animated loading indicator.
		 * @param index Index of texture state.
		 * @param callback Function that will be called on complete of loading.
		 * @param params Parameters for callback function.
		 */		
		public function switchToStateIndexAsync(index:int, callback:Function=null, ...params):void
		{
			if(_states.indexOf(currentState) != index)
			{
				if(index >= 0 && index < _states.length)
					switchToStateAsync.apply(null, [_states[index], callback].concat(params));
				else
					switchToState(null);
			}
		}
		
		/**
		 * Is texture active. 
		 */		
		public var active:Boolean = true;
	}
}