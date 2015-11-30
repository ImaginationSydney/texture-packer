package com.imagination.texturePacker.api;

import openfl.display.BitmapData;
/**
 * ...
 * @author P.J.Shand
 */
interface IAtlasPackage 
{
	#if swc
		@:extern
		//@:noCompletion
		var bitmapData(default, null):BitmapData;
		
		@:extern
		//@:noCompletion
		var xml(default, null):Xml;
		
		@:extern
		//@:noCompletion
		var next(default, null):IAtlasPackage;
		
		/*@:getter(bitmapData) 
		function bitmapData():BitmapData;
		
		@:getter(xml)
		function xml():Xml;
		
		@:getter(next)
		function next():IAtlasPackage;*/
	#else
		var bitmapData(get, null):BitmapData;
		var xml(get, null):Xml;
		var next(get, null):IAtlasPackage;
	#end
}