package com.imagination.texturePacker.impl.placement; 

import com.imagination.texturePacker.api.placement.IPlacement;
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
		var objectRect:Rectangle;
		
		if (Std.is(source, Shape)) objectRect = new Rectangle(0, 0, Reflect.getProperty(source, "width"), Reflect.getProperty(source, "height"));
		else objectRect = Reflect.getProperty(source, "rect");
		
		if (objectRect == null) objectRect = new Rectangle(0, 0, Reflect.getProperty(source, "width"), Reflect.getProperty(source, "height"));
		
		if (objectRect.width < width && objectRect.height < height) {
			return new Rectangle(x, y, Reflect.getProperty(source, "width"), Reflect.getProperty(source, "height"));
		}
		else {
			return null;
		}
	}
}