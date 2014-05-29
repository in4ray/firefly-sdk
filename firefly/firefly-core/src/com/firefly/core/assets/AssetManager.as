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

	/** Manager for managing (load/release) asset states.
	 *  
	 *  @example The following code shows how to create two states and load first one:
	 *  <listing version="3.0">
	 *************************************************************************************
 function main():void
 {
 	var menuState:AssetState = new AssetState("MenuState", new CommonTextureBundle(), new MenuTextureBundle());
 	var gameState:AssetState = new AssetState("GameState", new CommonTextureBundle(), new GameTextureBundle());
	 
 	var manager:AssetManager = new AssetManager(menuState, gameState);  
 	manager.switchToStateName("MenuState").progress(onStateProgress).then(onStateLoaded);
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
	public class AssetManager
	{
		/** @private */
		private var _states:Vector.<AssetState> = new Vector.<AssetState>();
		/** @private */
		private var _currentState:AssetState;
		
		/** Constaructor. 
		 *  @param states One or several asset states. */		
		public function AssetManager(...states)
		{
			this.states = states;
		}
		
		/** Is texture enabled. */		
		public var enabled:Boolean = true;
		
		/** Setter for adding states as array, mainly used by mxml.
		 *  @param states Array of asset states. */		
		public function set states(states:Array):void
		{
			for each (var state:AssetState in states) 
			{
				addState(state);
			}
		}
		
		/** Get all asset states.
		 *  @return Vector of asset states. */		
		public function getStates():Vector.<AssetState>
		{
			return _states.slice();
		}
		
		/** Add asset state. 
		 *  @param state Assset state to be managed. */		
		public function addState(state:AssetState):void
		{
			if(_states.indexOf(state) == -1)
				_states.push(state);
		}
		
		
		/** Load asset state and unload previous one asynchronously. 
		 *  @param state Asset state. 
		 *  @return Future object for callback. */		
		public function switchToState(state:AssetState):Future
		{
			if(_currentState != state)
			{
				if(_currentState)
					_currentState.releaseDifference(state);
				
				_currentState = state;
				
				return loadCurrentState();
			}
			
			return Future.nextFrame();
		}
		
		/** Load asset state by name and unload previous one asynchronously. 
		 *  @param name Asset state name. 
		 *  @return Future object for callback. */		
		public function switchToStateName(name:String):Future
		{
			if(!_currentState || _currentState.name != name)
			{
				for each (var state:AssetState in _states) 
				{
					if(state.name == name)
						return switchToState(state);
				}
				switchToState(null);
			}
			
			return Future.nextFrame();
		}
		
		/** Load asset state by index and unload previous one asynchronously. 
		 *  @param name Asset state name. 
		 *  @return Future object for callback. */	
		public function switchToStateIndex(index:int):Future
		{
			if(_states.indexOf(_currentState) != index)
			{
				if(index >= 0 && index < _states.length)
					return switchToState(_states[index]);
				else
					return switchToState(null);
			}
			
			return Future.nextFrame();
		}
		
		/** Release current asset state. */		
		public function releaseCurrentState():void
		{
			if(_currentState)
				_currentState.release();
		}
		
		/** Load current texture state asynchronously. 
		 *  @return Future object for callback. */	
		public function loadCurrentState():Future
		{
			if(_currentState && enabled)
				return _currentState.load();
			
			return Future.nextFrame();
		}
	}
}