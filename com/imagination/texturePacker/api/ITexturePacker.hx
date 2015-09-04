package com.imagination.texturePacker.api;

import openfl.display.IBitmapDrawable;

/**
 * ...
 * @author P.J.Shand
 */
interface ITexturePacker 
{
	function clear():Void;
	function add(source:IBitmapDrawable):Void;
	function pack():IAtlasPackage;
}