package com.imagination.texturePacker.api.sheet;

import com.imagination.texturePacker.api.IAtlasPackage;
import com.imagination.texturePacker.impl.sheet.IBitmapDrawableObject;
import openfl.display.IBitmapDrawable;

/**
 * ...
 * @author P.J.Shand
 */
interface ISheet 
{
	function add(source:IBitmapDrawableObject):Void;
	function pack():IAtlasPackage;
}