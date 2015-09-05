package com.imagination.texturePacker.impl.convert.away3D;

import away3d.containers.ObjectContainer3D;
import away3d.entities.Mesh;
import away3d.materials.TextureMaterial;
import away3d.textures.BitmapTexture;
import com.imagination.texturePacker.api.convert.away3D.IAway3DPackage;
import flash.geom.Rectangle;
import flash.utils.Dictionary;
import openfl.Vector;

/**
 * ...
 * @author P.J.Shand
 */
class Away3DPackage implements IAway3DPackage 
{
	private var _container:ObjectContainer3D;
	private var _meshs:Vector<Mesh>;
	private var _textures:Vector<BitmapTexture>;
	private var _materials:Vector<TextureMaterial>;
	private var _rectangles:Vector<Rectangle>;
	
	private var _meshDic = new Map<String,Mesh>();
	private var _textureDic = new Map<String,BitmapTexture>();
	private var _materialDic = new Map<String,TextureMaterial>();
	private var _rectangleDic = new Map<String,Rectangle>();
	
	public var container(get, null):ObjectContainer3D;
	public var meshs(get, null):Vector<Mesh>;
	public var textures(get, null):Vector<BitmapTexture>;
	public var materials(get, null):Vector<TextureMaterial>;
	public var rectangles(get, null):Vector<Rectangle>;
	
	public function new(container:ObjectContainer3D, meshs:Vector<Mesh>, materials:Vector<TextureMaterial>, rectangles:Vector<Rectangle>) 
	{
		_container = container;
		_meshs = meshs;
		_materials = materials;
		_rectangles = rectangles;
		
		_textures = new Vector<BitmapTexture>();
		for (i in 0..._meshs.length) 
		{
			_meshDic[_meshs[i].name] = _meshs[i];
			_textures.push(cast(_materials[i].texture));
			_textureDic[_meshs[i].name] = _textures[i];
			_materialDic[_meshs[i].name] = _materials[i];
			_rectangleDic[_meshs[i].name] = _rectangles[i];
		}
	}
	
	public function get_container():ObjectContainer3D 
	{
		return _container;
	}
	
	public function get_meshs():Vector<Mesh> 
	{
		return _meshs;
	}
	
	public function meshByName(name:String):Mesh
	{
		return _meshDic[name];
	}
	
	public function get_textures():Vector<BitmapTexture> 
	{
		return _textures;
	}
	
	public function textureByName(name:String):BitmapTexture
	{
		return _textureDic[name];
	}
	
	public function get_materials():Vector<TextureMaterial> 
	{
		return _materials;
	}
	
	public function materialByName(name:String):TextureMaterial
	{
		return _materialDic[name];
	}
	
	public function get_rectangles():Vector<Rectangle> 
	{
		return _rectangles;
	}
	
	public function rectangleByName(name:String):Rectangle
	{
		return _rectangleDic[name];
	}
}