package com.imagination.texturePacker.impl.convert 
{
	import com.imagination.texturePacker.api.convert.away3D.IAway3DPackage;
	import com.imagination.texturePacker.api.convert.starling.IStarlingPackage;
	import com.imagination.texturePacker.impl.convert.away3D.Away3DConverter;
	import com.imagination.texturePacker.impl.convert.starling.StarlingConverter;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author P.J.Shand
	 */
	public class Convert
	{
		public function Convert() { }
		
		public static function toAway3D(base:*, generateMipmaps:Boolean=true):IAway3DPackage
		{
			return Away3DConverter.parse(base, generateMipmaps);
		}
		
		public static function toStarling(base:*, generateMipmaps:Boolean=true):IStarlingPackage
		{
			return StarlingConverter.parse(base, generateMipmaps);
		}
	}
}