package com.imagination.texturePacker.impl.convert;

import com.imagination.texturePacker.api.convert.away3D.IAway3DPackage;
//import com.imagination.texturePacker.api.convert.starling.IStarlingPackage;
import com.imagination.texturePacker.impl.convert.away3D.Away3DConverter;
//import com.imagination.texturePacker.impl.convert.starling.StarlingConverter;
import openfl.display.Sprite;

/**
 * ...
 * @author P.J.Shand
 */
class Convert
{
	public function new() { }
	
	public static function toAway3D(base:Dynamic, generateMipmaps:Bool=true):IAway3DPackage
	{
		return Away3DConverter.parse(base, generateMipmaps);
	}
	
	/*public static function toStarling(base:Dynamic, generateMipmaps:Bool=true):IStarlingPackage
	{
		return StarlingConverter.parse(base, generateMipmaps);
	}*/
}