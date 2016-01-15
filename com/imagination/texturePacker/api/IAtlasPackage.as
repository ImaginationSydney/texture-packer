package com.imagination.texturePacker.api 
{
	import flash.display.BitmapData;
	/**
	 * ...
	 * @author P.J.Shand
	 */
	public interface IAtlasPackage 
	{
		function get bitmapData():BitmapData;
		function get xml():XML;
		function get next():IAtlasPackage;
	}
}