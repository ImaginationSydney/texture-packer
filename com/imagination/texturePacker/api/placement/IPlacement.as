package com.imagination.texturePacker.api.placement 
{
	import flash.display.IBitmapDrawable;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author P.J.Shand
	 */
	public interface IPlacement 
	{
		function get x():Number;
		function get y():Number;
		function get width():Number;
		function get height():Number;
		function place(source:IBitmapDrawable):Rectangle;
	}
}