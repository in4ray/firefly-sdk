package com.firefly.core.display
{
	public interface IVScrollerContainer
	{
		function get y():Number;
		function get height():Number;
		function get viewports():Vector.<IViewport>;
	}
}