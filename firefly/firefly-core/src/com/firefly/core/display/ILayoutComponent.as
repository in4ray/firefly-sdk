package com.firefly.core.display
{
	import com.firefly.core.layouts.Layout;

	public interface ILayoutComponent
	{
		function get layout():Layout;
		function updateLayout():void;
	}
}