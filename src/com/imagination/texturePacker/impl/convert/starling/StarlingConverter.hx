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
	private static var cache:Dictionary = new Dictionary();
	
	public function new() 
	{
		
	}		
	
	public static function parse(base:*, generateMipmaps:Boolean):IStarlingPackage 
	{
		var baseDisplay:DisplayObjectContainer;
		if (base is Class) {
			if (!cache[base]) {
				cache[base] = new base();
			}
			baseDisplay = cache[base];
		}
		else {
			baseDisplay = base;
		}
		
		var container:Sprite = new Sprite();
		var texturePacker:ITexturePacker = new TexturePacker();
		
		var itemObjects = new Vector<ItemObject>();
		
		for (var i:Int = 0; i < baseDisplay.numChildren; i++) 
		{
			var child:DisplayObject = baseDisplay.getChildAt(i);
			texturePacker.add(child);
			itemObjects.push(new ItemObject(child));
		}
		
		var atlasPackage:IAtlasPackage = texturePacker.pack();
		
		var texture:Texture = Texture.fromBitmapData(atlasPackage.bitmapData, generateMipmaps);
		var textureAtlas:TextureAtlas = new TextureAtlas(texture, atlasPackage.xml);
		var images = new Vector<Image>();
		
		for (var j:Int = 0; j < itemObjects.length; j++) 
		{
			var item:ItemObject = itemObjects[j];
			var image:Image = new Image(textureAtlas.getTexture(item.name));
			image.x = item.x;
			image.y = item.y;
			image.pivotX = -item.bounds.x;
			image.pivotY = -item.bounds.y;
			image.name = item.name;
			container.addChild(image);
			images.push(image);
		}
		
		var starlingPackage:IStarlingPackage = new StarlingPackage(container, images);
		
		return starlingPackage;
	}
}