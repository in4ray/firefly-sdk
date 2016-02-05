// =================================================================================================
//
//	Firefly Framework
//	Copyright 2016 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.display
{
	/** The ILocalizedComponent interface should be implemented by classes that could be 
	 *  localized. */
	public interface ILocalizedComponent
	{
		/** Invokes to localize text in the component.
		 *  @param text Localized string. */
		function localize(text:String):void;
	}
}