package com.imagination.texturePacker.impl;

import com.imagination.texturePacker.api.IAtlasPackage;
import openfl.display.BitmapData;

/**
 * ...
 * @author P.J.Shand
 */
class AtlasPackage implements IAtlasPackage 
{	
	public var bitmapData(default, null):BitmapData;
	public var xml(default, null):Xml;
	public var next(default, null):IAtlasPackage;
	
	public function new(bmdWidth:Int, bmdHeight:Int, xmlString:String, n:IAtlasPackage=null) 
	{
		next = n;
		bitmapData = new BitmapData(bmdWidth, bmdHeight, true, 0x00222222);
		xml = Xml.parse(xmlString);
	}
}