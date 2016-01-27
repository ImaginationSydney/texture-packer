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
import starling.core.Starling;
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
	private static var cache = new Map<String, IStarlingPackage>();
	//static private var textures;
	static private var textureAtlases;
	
	public function new() 
	{
		
	}		
	
	public static function parse(base:Class<Dynamic>, generateMipmaps:Bool):IStarlingPackage 
	{
		var className = Type.getClassName(base);
		var starlingPackage = cache.get(className);
		if (starlingPackage != null) return starlingPackage;
		
		var baseDisplay:DisplayObjectContainer = Type.createInstance(base, []);
		
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
		
		
		/*var bm:Bitmap = new Bitmap(atlasPackage.bitmapData);
		bm.y = 400;
		Starling.current.nativeStage.addChild(bm);*/
		
		textureAtlases = new Array<TextureAtlas>();
		
		createTextures(atlasPackage, generateMipmaps);
		var images = new Vector<Image>();
		
		for (item in itemObjects) 
		{
			var texture = getTexture(item.name, atlasPackage);
			if (texture == null) {
				trace("Can't find texture for " + item.name);
				continue;
			}
			var image:Image = new Image(texture);
			image.x = item.x;
			image.y = item.y;
			image.pivotX = -item.bounds.x;
			image.pivotY = -item.bounds.y;
			image.name = item.name;
			container.addChild(image);
			images.push(image);
		}
		
		starlingPackage = new StarlingPackage(container, images);
		
		cache.set(className, starlingPackage);
		
		return starlingPackage;
	}
	
	static private function createTextures(atlasPackage:IAtlasPackage, generateMipmaps:Bool) 
	{
		var texture = Texture.fromBitmapData(atlasPackage.bitmapData, generateMipmaps);
		textureAtlases.push(new TextureAtlas(texture, atlasPackage.xml));
		if (atlasPackage.next != null) createTextures(atlasPackage.next, generateMipmaps);
	}
	
	static private function getTexture(name:String, atlasPackage:IAtlasPackage):Texture
	{
		var texture = null;
		for (i in 0...textureAtlases.length) 
		{
			texture = textureAtlases[i].getTexture(name);
			if (texture != null) break;
		}
		return texture;
	}
}