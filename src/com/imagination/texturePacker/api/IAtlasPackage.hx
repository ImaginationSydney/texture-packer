package com.imagination.texturePacker.api;

import openfl.display.BitmapData;
/**
 * ...
 * @author P.J.Shand
 */
interface IAtlasPackage 
{
	var bitmapData(get, null):BitmapData;
	var xml(get, null):Xml;
	var next(get, null):IAtlasPackage;
	
	/*function get_bitmapData():BitmapData;
	function get_xml():Xml;
	function get_next():IAtlasPackage;*/
}