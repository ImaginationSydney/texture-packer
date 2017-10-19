package com.imagination.texturePacker.api.convert.starling;

import openfl.Vector;
import starling.display.Image;
import starling.display.Sprite;
import starling.textures.Texture;

/**
 * ...
 * @author P.J.Shand
 */
interface IStarlingPackage 
{
	var container(get, null):Sprite;
	var images(get, null):Vector<Image>;
	var textures(get, null):Vector<Texture>;
	
	function imageByName(name:String, clone:Bool = false):Image;
	function textureByName(name:String):Texture;
}