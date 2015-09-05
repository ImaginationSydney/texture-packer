package com.imagination.texturePacker.impl.convert.away3D;

import openfl.display.DisplayObject;
import openfl.geom.Point;

/**
 * ...
 * @author P.J.Shand
 */
class ItemObject
{
	public var x:Float;
	public var y:Float;
	public var width:Float;
	public var height:Float;
	public var name:String;
	
	public function new(child:DisplayObject):Void
	{
		this.name = child.name;
		this.x = child.x;
		this.y = child.y;
		this.width = child.width;
		this.height = child.height;
	}
}