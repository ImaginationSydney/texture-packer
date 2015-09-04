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
	function get_container():Sprite;
	function get_images():Vector<Image>;
	function imageByName(name:String):Image;
	function get_textures():Vector<Texture>;
	function textureByName(name:String):Texture;
}