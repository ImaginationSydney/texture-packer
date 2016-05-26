package com.imagination.texturePacker.api;

import openfl.display.IBitmapDrawable;

/**
 * ...
 * @author P.J.Shand
 */
interface ITexturePacker 
{
	function clear():Void;
	function add(source:IBitmapDrawable, id:String=null):Void;
	function pack():IAtlasPackage;
}