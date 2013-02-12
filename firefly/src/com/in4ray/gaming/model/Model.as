// =================================================================================================
//
//	in4ray Gaming SDK
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.in4ray.gaming.model
{
	import com.in4ray.gaming.gp_internal;
	import com.in4ray.gaming.core.GameGlobals;
	
	import starling.events.EventDispatcher;

	use namespace gp_internal;
	
	/**
	 * Basic model class. This object will be store/restore in shared object automatically. 
	 * 
	 * @example The following example shows how to use model:
	 *
	 * <listing version="3.0">
import com.in4ray.games.core.components.flash.GameApplication;
	
public class SampleGame extends GameApplication
{
	public function SampleGame()
	{
		super();
		
		var model:GameModel = GameModel.getInstance();
		model.score = 0;
	}
}

  
import com.in4ray.games.core.managers.SingletonLocator;
import com.in4ray.games.core.model.Model;

public class GameModel extends Model
{
	public function GameModel()
	{
		super("gameModel");
	}

	public static function getInstance():GameModel
	{
		return SingletonLocator.getInstance(GameModel);			
	}
	
	public var score:Number;
}
	 * </listing>
	 */	
	public class Model extends EventDispatcher implements IStoreable
	{
		/**
		 * Constructor.
		 *  
		 * @param path Shared object path.
		 */		
		public function Model(path:String)
		{
			_path = path;
			
			GameGlobals.systemManager.addStoreable(this);
		}
		
		private var _path:String;
		
		/**
		 * @inheritDoc
		 */		
		public function get path():String
		{
			return _path;
		}
		
		/**
		 * @inheritDoc
		 */	
		public function load(data:Object):void
		{
			// TODO Auto Generated method stub
		}
		
		/**
		 * @inheritDoc
		 */	
		public function save(data:Object):void
		{
			// TODO Auto Generated method stub
		}
		
		/**
		 * @inheritDoc
		 */	
		public function sleep(data:Object):void
		{
			// TODO Auto Generated method stub
		}
		
		/**
		 * @inheritDoc
		 */	
		public function wakeUp(data:Object):void
		{
			// TODO Auto Generated method stub
		}
	}
}