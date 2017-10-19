package com.imagination.texturePacker.impl;

import com.imagination.texturePacker.api.IAtlasPackage;
import com.imagination.texturePacker.api.ITexturePacker;
import com.imagination.texturePacker.api.sheet.ISheet;
import com.imagination.texturePacker.impl.sheet.IBitmapDrawableObject;
import com.imagination.texturePacker.impl.sheet.Sheet;
import openfl.display.IBitmapDrawable;
import openfl.geom.Point;
import openfl.Vector;

/**
 * ...
 * @author P.J.Shand
 */
class TexturePacker implements ITexturePacker
{
	public static var debug:Bool = false;
	public static var TARGET_TEXTURE_SIZE:Point = new Point(4096, 4096);
	public static var AUTO_INCREASE_TEXTURE_SIZE:Bool = false;
	
	public static var framePadding:Int = 0;
	public static var objectPadding:Int = 2;
	
	private var atlasPackage:IAtlasPackage;
	private var sources = new Vector<IBitmapDrawableObject>();
	private var sheets = new Vector<ISheet>();
	
	public static function main()
	{
		
	}
	
	public function new() 
	{
		
	}
	
	public function clear():Void
	{
		var i:Int = sources.length - 1;
		while (i >= 0) 
		{
			sources[i].source = null;
			sources.splice(i, 1);
			i--;
		}
		sources = new Vector<IBitmapDrawableObject>();
	}
	
	public function add(source:IBitmapDrawable, id:String=null):Void
	{
		sources.push(new IBitmapDrawableObject(source, id));
	}
	
	public function pack():IAtlasPackage
	{
		var sheet:ISheet = new Sheet();
		for (i in 0...sources.length) 
		{
			sheet.add(sources[i]);
		}
		return sheet.pack();
	}
}