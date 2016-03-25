// =================================================================================================
//
//	Firefly Framework
//	Copyright 2016 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.model
{
import com.firefly.core.binding.BindingProvider;

import flash.net.SharedObject;

	/** Basic model class for storing application data. This object will be store/restore in shared object automatically.
 	 *  
	 *  @example The following code shows how configure own game model and correctly use it:
	 *  <listing version="3.0">
	 *************************************************************************************
public class GameModel extends Model
{
	public var gameVersion:String;
	public var prop1:int;
	public var prop2:String;
	public var prop3:Number;
		
	public function GameModel(name:String)
	{
		super(name);
	}
	
	override protected function init():void
	{
		prop1 = 24; 
		prop2 = "SampleString";
		prop3 = 34.6;
		gameVersion = "MyGame";
	}
	
	override public function load(data:Object):void
	{
		prop1 = data.prop1; 
		prop2 = data.prop2;
		prop3 = data.prop3;
		gameVersion = data.gameVersion;
	}
	 
	override public function save(data:Object):void
	{
		data.prop1 = prop1; 
		data.prop2 = prop2;
		data.prop3 = prop3;
		data.gameVersion = gameVersion;
	}
}
	 *************************************************************************************
	 *  </listing>
	 * 
 	 *  @example The following code shows how correctly create game model:
	 *  <listing version="3.0">
	 *************************************************************************************
public class MyGameApp extends GameApp
{
	public function MyGameApp()
	{
		super();
		
		setGlobalLayoutContext(768, 1024, VAlign.TOP);
			
		regNavigator(MainScreen);
		regModel(new GameModel("MyGame")); // register game model for automatically storing/restoring
	}
}
	 *************************************************************************************
	 *  </listing>
	 *
	 *  @example The following code shows how save/load one property:
	 *  <listing version="3.0">
	 *************************************************************************************
public class MyGameApp extends GameApp
{
	public function MyGameApp()
	{
		super();
		
		setGlobalLayoutContext(768, 1024, VAlign.TOP);
			
		regNavigator(MainScreen);
		regModel(new GameModel("MyGame")); // register game model for automatically storing/restoring
	}
	 
	override protected function init():void
	{ 
	 	super.init();
		
	 	Firefly.current.model.saveProperty("propName", "propValue");
		var myProp:String = Firefly.current.model.loadProperty("propName");
		trace(myProp);
	}
}
	 *************************************************************************************
	 *  </listing> */	
	public class Model
	{
		/** @private */		
		private var _name:String;
		/** @private */		
		private var _loaded:Boolean;
        /** @private */
        private var _bindingProvider:BindingProvider;
		
		/** Constructor. 
		 * 	@param name Name of the model. This name will be used for creating appropriate shared object. */	
		public function Model(name:String)
		{
			_name = name;
            _bindingProvider = new BindingProvider();
		}
		
		/** Name of the model and shared object. */
		public function get name():String { return _name; }
        /** Binding provider allows to bind properties from the model. */
        public function get bindingProvider():BindingProvider { return _bindingProvider; }
		
		/** Load saved data from the shared object. This method automatically invokes when application starts up. */
		public function load():void
		{
			var sharedObject:SharedObject = SharedObject.getLocal(_name, "/");
			if(sharedObject.size > 0)
				read(sharedObject.data);
			else
				init();
			
			_loaded = true;
		}
		
		/** Save data into shared object. This method automatically when application exits or goes to cibernate. */
		public function save():void
		{
			if(_loaded)
			{
				var sharedObject:SharedObject = SharedObject.getLocal(_name, "/");
				write(sharedObject.data);
				sharedObject.flush();
			}
		}
		
		/** Load property from the shared object.
		 *  @param name Name of the property. */
		public function loadProp(name:String):*
		{
			var sharedObject:SharedObject = SharedObject.getLocal(_name, "/");
			if(sharedObject.size > 0)
				return sharedObject.data[name];
			else
				return null;
		}
		
		/** Save property into the shared object.
		 *  @param name Name of the property.
		 *  @param val Property value. */
		public function saveProp(name:String, value:*):void
		{
			var sharedObject:SharedObject = SharedObject.getLocal(_name, "/");
			sharedObject.data[name] = value;
			sharedObject.flush();
		}
		
		/** Clear all stored data. */
		public function clear():void
		{
			var sharedObject:SharedObject = SharedObject.getLocal(_name, "/");
			sharedObject.clear();
			sharedObject.close();
		}
		
		/** This method calls in case shared object isn't created. Use this method for initialize 
		 *  default values of the application. */
		protected function init():void { }
		
		/** This method calls after game data already loaded from the shared object.
		 *  @param data Data object from need to read properties. */
		protected function read(data:Object):void { }
		
		/** This method calls before game data will be saved into the shared object.
		 *  @param data Data object to save propeties from the model. */
		protected function write(data:Object):void { }
	}
}