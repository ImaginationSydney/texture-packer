package com.imagination.texturePacker.impl.convert.away3D 
{
	import away3d.containers.ObjectContainer3D;
	import away3d.entities.Mesh;
	import away3d.materials.TextureMaterial;
	import away3d.textures.BitmapTexture;
	import com.imagination.texturePacker.api.convert.away3D.IAway3DPackage;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author P.J.Shand
	 */
	public class Away3DPackage implements IAway3DPackage 
	{
		private var _container:ObjectContainer3D;
		private var _meshs:Vector.<Mesh>;
		private var _textures:Vector.<BitmapTexture>;
		private var _materials:Vector.<TextureMaterial>;
		private var _rectangles:Vector.<Rectangle>;
		
		private var _meshDic:Dictionary = new Dictionary();
		private var _textureDic:Dictionary = new Dictionary();
		private var _materialDic:Dictionary = new Dictionary();
		private var _rectangleDic:Dictionary = new Dictionary();
		
		public function Away3DPackage(container:ObjectContainer3D, meshs:Vector.<Mesh>, materials:Vector.<TextureMaterial>, rectangles:Vector.<Rectangle>) 
		{
			_container = container;
			_meshs = meshs;
			_materials = materials;
			_rectangles = rectangles;
			
			_textures = new Vector.<BitmapTexture>();
			for (var i:int = 0; i < _meshs.length; i++) 
			{
				_meshDic[_meshs[i].name] = _meshs[i];
				_textures.push(_materials[i].texture);
				_textureDic[_meshs[i].name] = _textures[i];
				_materialDic[_meshs[i].name] = _materials[i];
				_rectangleDic[_meshs[i].name] = _rectangles[i];
			}
		}
		
		public function get container():ObjectContainer3D 
		{
			return _container;
		}
		
		public function get meshs():Vector.<Mesh> 
		{
			return _meshs;
		}
		
		public function meshByName(name:String):Mesh
		{
			return _meshDic[name];
		}
		
		public function get textures():Vector.<BitmapTexture> 
		{
			return _textures;
		}
		
		public function textureByName(name:String):BitmapTexture
		{
			return _textureDic[name];
		}
		
		public function get materials():Vector.<TextureMaterial> 
		{
			return _materials;
		}
		
		public function materialByName(name:String):TextureMaterial
		{
			return _materialDic[name];
		}
		
		public function get rectangles():Vector.<Rectangle> 
		{
			return _rectangles;
		}
		
		public function rectangleByName(name:String):Rectangle
		{
			return _rectangleDic[name];
		}
	}
}