package com.imagination.texturePacker.impl 
{
	import com.imagination.texturePacker.api.IAtlasPackage;
	import com.imagination.texturePacker.api.ITexturePacker;
	import com.imagination.texturePacker.api.sheet.ISheet;
	import com.imagination.texturePacker.impl.sheet.Sheet;
	import flash.display.IBitmapDrawable;
	
	/**
	 * ...
	 * @author P.J.Shand
	 */
	public class TexturePacker implements ITexturePacker
	{
		public static var debug:Boolean = false;
		public static var MAX_SIZE:int = 2048;
		public static var framePadding:int = 0;
		public static var objectPadding:int = 2;
		
		private var atlasPackage:IAtlasPackage;
		private var sources:Vector.<IBitmapDrawable> = new Vector.<IBitmapDrawable>();
		private var sheets:Vector.<ISheet> = new Vector.<ISheet>();
		
		public function TexturePacker() 
		{
			
		}
		
		public function clear():void
		{
			sources = new Vector.<IBitmapDrawable>();
		}
		
		public function add(source:IBitmapDrawable):void
		{
			sources.push(source);
		}
		
		public function pack():IAtlasPackage
		{
			var sheet:ISheet = new Sheet();
			for (var i:int = 0; i < sources.length; i++) 
			{
				sheet.add(sources[i]);
			}
			return sheet.pack();
		}
	}
}