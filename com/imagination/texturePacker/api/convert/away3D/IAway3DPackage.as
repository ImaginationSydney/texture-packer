package com.imagination.texturePacker.api.convert.away3D 
{
	import away3d.containers.ObjectContainer3D;
	import away3d.entities.Mesh;
	import away3d.materials.TextureMaterial;
	import away3d.textures.BitmapTexture;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author P.J.Shand
	 */
	public interface IAway3DPackage 
	{
		function get container():ObjectContainer3D;
		function get meshs():Vector.<Mesh>;
		function meshByName(name:String):Mesh;
		function get textures():Vector.<BitmapTexture>;
		function textureByName(name:String):BitmapTexture;
		function get materials():Vector.<TextureMaterial>;
		function materialByName(name:String):TextureMaterial;
		function get rectangles():Vector.<Rectangle>;
		function rectangleByName(name:String):Rectangle;
		
		
	}
}