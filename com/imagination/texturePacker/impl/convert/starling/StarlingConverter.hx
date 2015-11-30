package com.imagination.texturePacker.impl.convert.starling;

import com.imagination.texturePacker.api.convert.starling.IStarlingPackage;
import com.imagination.texturePacker.api.IAtlasPackage;
import com.imagination.texturePacker.api.ITexturePacker;
import com.imagination.texturePacker.impl.TexturePacker;
import openfl.display.Bitmap;
import openfl.display.DisplayObject;
import openfl.display.DisplayObjectContainer;
import openfl.utils.Dictionary;
import openfl.Vector;
import starling.display.Image;
import starling.display.Sprite;
import starling.textures.Texture;
import starling.textures.TextureAtlas;

/**
 * ...
 * @author P.J.Shand
 */
class StarlingConverter 
{
	private static var cache = new Map<String, Dynamic>();
	
	public function new() 
	{
		
	}		
	
	public static function parse(base:Dynamic, generateMipmaps:Bool):IStarlingPackage 
	{
		var baseDisplay:DisplayObjectContainer;
		if (Std.is(base, Class)) {
			var className = Type.getClassName(base);
			if (!cache.exists(className)) {
				cache.set(className, Type.createInstance(base, []));
			}
			baseDisplay = cache.get(className);
		}
		else {
			baseDisplay = base;
		}
		
		var container:Sprite = new Sprite();
		var texturePacker:ITexturePacker = new TexturePacker();
		
		var itemObjects = new Map<String,ItemObject>();
		
		for (i in 0...baseDisplay.numChildren) 
		{
			var child:DisplayObject = baseDisplay.getChildAt(i);
			texturePacker.add(child);
			itemObjects.set(child.name, new ItemObject(child));
		}
		
		var atlasPackage = texturePacker.pack();
		
		var texture = Texture.fromBitmapData(atlasPackage.bitmapData, generateMipmaps);
		var textureAtlas = new TextureAtlas(texture, atlasPackage.xml);
		var images = new Vector<Image>();
		
		for (item in itemObjects) 
		{
			var image:Image = new Image(textureAtlas.getTexture(item.name));
			image.x = item.x;
			image.y = item.y;
			image.pivotX = -item.bounds.x;
			image.pivotY = -item.bounds.y;
			image.name = item.name;
			container.addChild(image);
			images.push(image);
		}
		
		var starlingPackage = new StarlingPackage(container, images);
		
		return starlingPackage;
	}
}