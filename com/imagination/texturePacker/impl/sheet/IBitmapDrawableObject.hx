package com.imagination.texturePacker.impl.sheet;

import openfl.display.DisplayObject;
import openfl.display.IBitmapDrawable;
import openfl.geom.Rectangle;

/**
 * ...
 * @author P.J.Shand
 */
class IBitmapDrawableObject
{
	public var source:IBitmapDrawable;
	private var _width:Float;
	private var _height:Float;
	private var _id:String;
	private var _bounds:Rectangle;
	private var _name:String;
	
	public var name(get, null):String;
	public var width(get, null):Float;
	public var height(get, null):Float;
	public var id(get, null):String;
	public var bounds(get, null):Rectangle;
	
	private static var ref = new Map<String, Dynamic>();
	
	public function new(source:IBitmapDrawable, id:String=null):Void
	{
		this.source = source;
		_id = id;
		_width = Reflect.getProperty(source, "width");
		_height = Reflect.getProperty(source, "height");
		if (Reflect.getProperty(source, "name") != null) _name = Reflect.getProperty(source, "name");
		_bounds = new Rectangle(0, 0, _width, _height);
		
		if (Std.is(source, DisplayObject)) {
			var d:DisplayObject = cast(source, DisplayObject);
			_bounds = d.getBounds(d);
		}
		
		if (Reflect.hasField(source, "getBounds")) {
			var getBoundsFunc = Reflect.getProperty(source, "getBounds");
			_bounds = getBoundsFunc(source);
		}
		
		
		if (!ref.exists("source")) {
			if (_name != null) {
				ref.set("source", _name);
			}
			else {
				var value = Math.floor(Math.random() * 100000000);
				ref.set("source", value);
			}
		}
	}
	
	function get_width():Float 
	{
		return _width;
	}
	
	function get_name():String
	{
		return _name;
	}
	
	function get_height():Float 
	{
		return _height;
	}
	
	function get_id():String 
	{
		if (_id != null) return _id;
		return _name;
	}
	
	function get_bounds():Rectangle 
	{
		return _bounds;
	}
}