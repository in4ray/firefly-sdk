package com.firefly.core.display
{
	public interface IHScrollerContainer
	{
		function get x():Number;
		function get width():Number;
		function get viewports():Vector.<IViewport>;
	}
}