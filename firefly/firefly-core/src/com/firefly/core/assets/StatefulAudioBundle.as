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
	import com.firefly.core.audio.IAudio;
	import com.firefly.core.utils.Log;
	
	use namespace firefly_internal;

	/** Stateful audio bundle class for loading, creating and storing different audios in the same 
	 *  game state base on specific asset state.
	 * 
	 *  @see com.firefly.core.assets.StatefulBundle 
	 * 
	 *  @example The following code shows how to register different asset states with 
	 * 			 audio bundles and use it:
	 *  <listing version="3.0">
	 *************************************************************************************
public class GameAudioBundle extends StatefulAudioBundle
{
	override protected function regBundles():void
	{
		regState("gameWorld_1", new GameWorld1AudioBundle());
		regState("gameWorld_1", new GameWorld2AudioBundle());
			
		switchToState("gameWorld_1");
	}
	
	// in this case game music will be different for each asset state
	public function get gameMusic():Texture { return getAudio("gameMusic");
}
	 *************************************************************************************
	 *  </listing> */	
	public class StatefulAudioBundle extends StatefulBundle
	{
		
		/** Constructor. */		
		public function StatefulAudioBundle()
		{
			super();
		}
		
		/** @inheritDoc */
		override protected function regState(state:String, bundle:IAssetBundle):void
		{
			CONFIG::debug {
				if (!(bundle is AudioBundle))
				{
					Log.error("You can register only Audio Bundle.", bundle);
				}
			};
			
			if(_singleton != this)
				return (_singleton as StatefulAudioBundle).regState(state, bundle);
			
			super.regState(state, bundle);
		}
		
		/** Find and return audio by id in current asset state.
		 *  @param id Audio id.
		 *  @return Audio instance in current state. */		
		public function getAudio(id:String):IAudio
		{
			if(_singleton != this)
				return (_singleton as StatefulAudioBundle).getAudio(id);
			
			return _bundles[currentState].getAudio(id);
		}
	}
}