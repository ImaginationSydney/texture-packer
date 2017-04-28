package com.imagination.texturePacker.impl.convert.starling;

import com.imagination.texturePacker.api.convert.starling.IStarlingPackage;
import com.imagination.texturePacker.api.IAtlasPackage;
import com.imagination.texturePacker.api.ITexturePacker;
import com.imagination.texturePacker.impl.TexturePacker;
import openfl.display.Bitmap;
import openfl.display.DisplayObject;
import openfl.display.DisplayObjectContainer;
import openfl.display.MovieClip;
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
		if (Std.is(baseDisplay, MovieClip)) {
			var mc:MovieClip = untyped baseDisplay;
			mc.stop();
		}
		var container:Sprite = new Sprite();
		var texturePacker:ITexturePacker = new TexturePacker();
		
		var itemObjects = new Array<ItemObject>();
		
		for (i in 0...baseDisplay.numChildren) 
		{
			var child:DisplayObject = baseDisplay.getChildAt(i);
			texturePacker.add(child);
			itemObjects.push(new ItemObject(child));
		}
		
		var atlasPackage = texturePacker.pack();
		
		
		/*var bm:Bitmap = new Bitmap(atlasPackage.bitmapData);
		bm.y = 400;
		Starling.current.nativeStage.addChild(bm);*/
		
		textureAtlases = new Array<TextureAtlas>();
		
		createTextures(atlasPackage, generateMipmaps);
		
		var images = new Vector<Image>();
		
		for (i in 0...itemObjects.length) 
		{
			var item = itemObjects[i];
			var texture = getTexture(item.name);
			if (texture == null) {
				trace("Can't find texture for " + item.name);
				continue;
			}
			if (texture.width == 0 || texture.height == 0) {
				trace("texture can't have a width or height of 0px: " + item.name);
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
	
	static private function getTexture(name:String):Texture
	{
		var texture:Texture = null;
		
		for (i in 0...textureAtlases.length) 
		{
			var textureAtlas:TextureAtlas = textureAtlases[i];
			texture = textureAtlas.getTexture(name);
			if (texture != null) break;
		}
		return texture;
	}
}