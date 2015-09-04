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
	
	public function new(container:Sprite, images:Vector<Image>) 
	{
		_container = container;
		_images = images;
		
		_textures = new Vector<Texture>();
		for (var i:Int = 0; i < _images.length; i++) 
		{
			_textures.push(_images[i].texture);
		}
	}
	
	public function get_container():Sprite 
	{
		return _container;
	}
	
	public function get_images():Vector<Image> 
	{
		return _images;
	}
	
	public function imageByName(name:String):Image
	{
		for (var i:Int = 0; i < _images.length; i++) 
		{
			if (_images[i].name == name) return _images[i];
		}
		return null;
	}
	
	public function get_textures():Vector<Texture> 
	{
		return _textures;
	}
	
	public function textureByName(name:String):Texture
	{
		var image:Image = imageByName(name);
		if (image) return image.texture;
		return null;
	}
}