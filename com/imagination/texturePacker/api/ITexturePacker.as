package com.imagination.texturePacker.api 
{
	import flash.display.IBitmapDrawable;
	
	/**
	 * ...
	 * @author P.J.Shand
	 */
	public interface ITexturePacker 
	{
		function clear():void;
		function add(source:IBitmapDrawable):void;
		function pack():IAtlasPackage;
	}
	
}