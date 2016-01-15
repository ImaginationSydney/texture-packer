package com.imagination.texturePacker.api.sheet 
{
	import com.imagination.texturePacker.api.IAtlasPackage;
	import flash.display.IBitmapDrawable;
	
	/**
	 * ...
	 * @author P.J.Shand
	 */
	public interface ISheet 
	{
		function add(source:IBitmapDrawable):void;
		function pack():IAtlasPackage;
	}
}