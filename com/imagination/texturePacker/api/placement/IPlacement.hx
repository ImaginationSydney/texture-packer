package com.imagination.texturePacker.api.placement;

import openfl.display.IBitmapDrawable;
import openfl.geom.Rectangle;

/**
 * ...
 * @author P.J.Shand
 */
interface IPlacement 
{
	public var x(get, null):Float;
	public var y(get, null):Float;
	public var width(get, null):Float;
	public var height(get, null):Float;
	
	/*function get_x():Float;
	function get_y():Float;
	function get_width():Float;
	function get_height():Float;*/
	
	function place(source:IBitmapDrawable):Rectangle;
}