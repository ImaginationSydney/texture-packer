package com.imagination.texturePacker.api.convert.starling 
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author P.J.Shand
	 */
	public interface IStarlingPackage 
	{
		function get container():Sprite;
		function get images():Vector.<Image>;
		function imageByName(name:String):Image;
		function get textures():Vector.<Texture>;
		function textureByName(name:String):Texture;
	}
}