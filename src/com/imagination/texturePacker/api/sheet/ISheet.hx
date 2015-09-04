package com.imagination.texturePacker.api.sheet;

import com.imagination.texturePacker.api.IAtlasPackage;
import openfl.display.IBitmapDrawable;

/**
 * ...
 * @author P.J.Shand
 */
interface ISheet 
{
	function add(source:IBitmapDrawable):Void;
	function pack():IAtlasPackage;
}