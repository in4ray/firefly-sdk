package com.firefly.core.errors
{
	public class ForbiddenFunctionError extends Error
	{
		public function ForbiddenFunctionError(message:String="Forbidden function.", id:*=0)
		{
			super(message, id);
		}
	}
}