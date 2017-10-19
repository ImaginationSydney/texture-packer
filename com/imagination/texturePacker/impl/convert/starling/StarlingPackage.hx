package com.imagination.texturePacker.impl.convert.starling;

import com.imagination.texturePacker.api.convert.starling.IStarlingPackage;
import openfl.Vector;
import starling.display.Image;
import starling.display.Sprite;
import starling.textures.Texture;

/**
 * ...
 * @author P.J.Shand
 */
class StarlingPackage implements IStarlingPackage 
{
	private var _container:Sprite;
	private var _images:Vector<Image>;
	private var _textures:Vector<Texture>;
	
	public var container(get, null):Sprite;
	public var images(get, null):Vector<Image>;
	public var textures(get, null):Vector<Texture>;
	
	public function new(container:Sprite, images:Vector<Image>) 
	{
		_container = container;
		_images = images;
		
		_textures = new Vector<Texture>();
		for (i in 0..._images.length) 
		{
			_textures.push(_images[i].texture);
		}
	}
	
	private function get_container():Sprite 
	{
		return _container;
	}
	
	private function get_images():Vector<Image> 
	{
		return _images;
	}
	
	public function imageByName(name:String, clone:Bool = false):Image
	{
		for (i in 0..._images.length) 
		{
			if (_images[i].name == name) {
				if (clone) {
					var image:Image = new Image(_images[i].texture);
					image.x = _images[i].x;
					image.y = _images[i].y;
					image.width = _images[i].width;
					image.height = _images[i].height;
					image.scaleX = _images[i].scaleX;
					image.scaleY = _images[i].scaleY;
					image.pivotX = _images[i].pivotX;
					image.pivotY = _images[i].pivotY;
					image.rotation = _images[i].rotation;
					image.alpha = _images[i].alpha;
					return image;
				}
				else {
					return _images[i];
				}
			}
		}
		return null;
	}
	
	private function get_textures():Vector<Texture> 
	{
		return _textures;
	}
	
	public function textureByName(name:String):Texture
	{
		var image:Image = imageByName(name);
		if (image != null) return image.texture;
		return null;
	}
}