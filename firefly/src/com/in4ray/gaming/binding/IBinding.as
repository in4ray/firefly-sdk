// =================================================================================================
//
//	in4ray Gaming SDK
//	Copyright 2013 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.in4ray.gaming.binding
{
	/**
	 * Interface for bindable properties.  
	 */	
	public interface IBinding
	{
		 /**
		  * Used to create chain of properties e.g. 
		  * <code>context.next("user").bindProperty("name")</code>
		  * 
		  * </br>
		  * NOTE: Doesn't work correctly yet. 
		  * 
		  *  
		  * @param property Name of property to be added into binding chain.
		  * @return Bindable object
		  */		
		 function next(property:String):IBinding;
		 
		 /**
		  * Bind listener to property. 
		  * 
		  * @param listener Function that will be called each time binding fires up.
		  * Should have BindingEvent as parameter.
		  */		 
		 function bindListener(listener:Function):void
			 
		 /**
		  * Wire two properties.
		  *  
		  * @param host Object that contains property
		  * @param property Name of property.
		  * @return Binding listener
		  */			 
		 function bindProperty(host:Object, property:String):Function
			 
		 /**
		  * Remove listener from binding.
		  *  
		  * @param listener Function that will be called each time binding fires up.
		  * Should have BindingEvent as parameter.
		  */			 
		 function unbindListener(listener:Function):void
	}
}