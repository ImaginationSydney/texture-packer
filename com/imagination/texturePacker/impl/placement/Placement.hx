package com.imagination.texturePacker.impl.placement; 

import com.imagination.texturePacker.api.placement.IPlacement;
import openfl.display.BitmapData;
import openfl.display.DisplayObject;
import openfl.display.IBitmapDrawable;
import openfl.display.Shape;
import openfl.geom.Rectangle;

/**
 * ...
 * @author P.J.Shand
 */
class Placement implements IPlacement 
{
	private var areaRect:Rectangle;
	
	public var x(get, null):Float;
	public var y(get, null):Float;
	public var width(get, null):Float;
	public var height(get, null):Float;
	
	public function new(areaRect:Rectangle) 
	{
		this.areaRect = areaRect;
	}
	
	public function get_x():Float 
	{
		return areaRect.x;
	}
	
	public function get_y():Float 
	{
		return areaRect.y;
	}
	
	public function get_width():Float 
	{
		return areaRect.width;
	}
	
	public function get_height():Float 
	{
		return areaRect.height;
	}
	
	public function place(source:IBitmapDrawable):Rectangle
	{
		var _w:Float;
		var _h:Float;
		
		if (Std.is(source, DisplayObject)) {
			_w = cast(source, DisplayObject).width;
			_h = cast(source, DisplayObject).height;
		}
		else if (Std.is(source, BitmapData)) {
			_w = cast(source, BitmapData).width;
			_h = cast(source, BitmapData).height;
		}
		else {
			_w = Reflect.getProperty(source, "width");
			_h = Reflect.getProperty(source, "height");
		}
		
		var objectRect:Rectangle;
		
		if (Std.is(source, Shape)) {
			objectRect = new Rectangle(0, 0, _w, _h);
		}
		else {
			objectRect = Reflect.getProperty(source, "rect");
		}
		
		if (objectRect == null) {
			objectRect = new Rectangle(0, 0, _w, _h);
		}
		
		if (objectRect.width < width && objectRect.height < height) {
			return new Rectangle(x, y, _w, _h);
		}
		else {
			return null;
		}
	}
}