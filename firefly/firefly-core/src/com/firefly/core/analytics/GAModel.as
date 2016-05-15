// =================================================================================================
//
//	Firefly Framework
//	Copyright 2016 in4ray. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package com.firefly.core.analytics
{
	import com.firefly.core.model.Model;

	/** The extended Google Analytics model with additional retention information. 
	 *  This information will be saved to the shared object.
	 * 
	 *  @see com.firefly.core.analytics.GATracker */	
	public class GAModel extends Model
	{
		/** [Save] Retention property (track with Google Analytics). */	
		public var startDate:String = "";
		
		/** Constructor. 
		 *  @param name Model name. This name will be used to save it to the file system. */		
		public function GAModel(name:String)
		{
			super(name)
		}
		
		/** @inheritDoc */		
		override protected function read(data:Object):void
		{
			if(data.hasOwnProperty("startDate"))
				startDate = data.startDate; 
		}
		
		/** @inheritDoc */		
		override protected function init():void
		{
			startDate = getStartDate();
			save();
		}
		
		/** @inheritDoc */		
		override protected function write(data:Object):void
		{
			data.startDate = startDate;
		}
		
		/** StartDate - retention property (track with Google Analytics). */		
		private function getStartDate():String
		{
			var d:Date = new Date()
			var yy:String = d.getUTCFullYear().toString();
			var mm:String = (d.getUTCMonth()+1).toString();
			if (mm.length == 1)
				mm = "0" + mm;
			var dd:String = d.getUTCDate().toString();
			if (dd.length == 1)
				dd = "0" + dd;
			
			return yy+mm+dd; 
		}
	}
}