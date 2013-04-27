// =================================================================================================
//
//	in4ray Gaming SDK
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.in4ray.gaming.core
{
	import com.in4ray.gaming.gp_internal;
	import com.in4ray.gaming.async.AsyncManager;
	import com.in4ray.gaming.components.flash.GameApplication;
	import com.in4ray.gaming.consts.SystemType;
	import com.in4ray.gaming.events.SystemEvent;
	import com.in4ray.gaming.model.IStoreable;
	
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.net.SharedObject;
	
	import starling.core.Starling;
	import starling.events.EventDispatcher;
	
	/**
	 * General system manager class. 
	 */	
	public class SystemManager extends EventDispatcher
	{
		/**
		 * Constructor. 
		 * 
		 * @param app Game application.
		 */		
		public function SystemManager(app:GameApplication)
		{
			super();
			this.app = app;
			
			if(GameGlobals.systemType != SystemType.WEB && GameGlobals.systemType != SystemType.UNDEFINED)
			{
				NativeApplication.nativeApplication.addEventListener(Event.ACTIVATE, activateHandler);	
				NativeApplication.nativeApplication.addEventListener(Event.DEACTIVATE, deactivateHandler);
			}
			app.stage.stage3Ds[0].addEventListener(Event.CONTEXT3D_CREATE, contextCreateHandler, false, 0, true);
		}
		
		private var app:GameApplication;
		
		/**
		 * @private 
		 */		
		protected function contextCreateHandler(event:Event):void
		{
			dispatchEvent(new SystemEvent(SystemEvent.CONTEXT_CREATE));
		}
		
		/**
		 * @private 
		 */	
		protected function activateHandler(event:Event):void
		{
			if(!app.stage.stage3Ds[0].context3D)
				dispatchEvent(new SystemEvent(SystemEvent.CONTEXT_LOST));
			else
				dispatchEvent(new SystemEvent(SystemEvent.ACTIVATE));
			
			for each (var model:IStoreable in models) 
			{
				var sharedObject:SharedObject = SharedObject.getLocal(model.path, "/");
				if(sharedObject.size > 0)
					model.wakeUp(sharedObject.data);
			}
			
			app.stage.frameRate = GameGlobals.defaultFrameRate;
			
			if(Starling.current)
				Starling.current.start();
		}
		
		/**
		 * @private 
		 */	
		protected function deactivateHandler(event:Event):void
		{
			dispatchEvent(new SystemEvent(SystemEvent.DEACTIVATE));
			
			for each (var model:IStoreable in models) 
			{
				var sharedObject:SharedObject = SharedObject.getLocal(model.path, "/");
				model.sleep(sharedObject.data);
				sharedObject.flush();
			}
			
			if(Starling.current)
				Starling.current.stop();
			
			// get done all asynk work
			var asyncManager:AsyncManager = SingletonLocator.getInstance(AsyncManager);
			asyncManager.flush();
			
			// advance time to make sure all transition is complete
			if(Starling.juggler)
				Starling.juggler.advanceTime(10);
			
			// get done all asynk work again
			asyncManager.flush();
			
			// advance time to make sure all transition is complete again
			if(Starling.juggler)
				Starling.juggler.advanceTime(10);
			
			app.stage.frameRate = 1;
		}
		
		
		/**
		 * Exit from game. 
		 */		
		public function exit():void
		{
			for each (var model:IStoreable in models) 
			{
				saveModel(model);
			}
			
			NativeApplication.nativeApplication.exit();
		}
		
		/**
		 * Save model into shared object. 
		 * @param model Model instance to be saved.
		 */		
		public function saveModel(model:IStoreable):void
		{
			var sharedObject:SharedObject = SharedObject.getLocal(model.path, "/");
			model.save(sharedObject.data);
			sharedObject.flush();
		}
		
		/**
		 * Load model from shared object. 
		 * @param model Model instance to be loaded.
		 */	
		public function loadModel(model:IStoreable):void
		{
			var sharedObject:SharedObject = SharedObject.getLocal(model.path, "/");
			if(sharedObject.size > 0)
				model.load(sharedObject.data);
		}
		
		private var models:Vector.<IStoreable> = new Vector.<IStoreable>();
		/**
		 * @private 
		 */		
		gp_internal function addStoreable(model:IStoreable):void
		{
			models.push(model);
			
			app.stage.addEventListener(Event.ENTER_FRAME, function nextFremeHandler(e:Event):void
			{
				app.stage.removeEventListener(Event.ENTER_FRAME, nextFremeHandler);
				loadModel(model);
			});
		}
	}
}