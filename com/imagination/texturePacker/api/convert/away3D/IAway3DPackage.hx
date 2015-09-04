package com.imagination.texturePacker.api.convert.away3D;

import away3d.containers.ObjectContainer3D;
import away3d.entities.Mesh;
import away3d.materials.TextureMaterial;
import away3d.textures.BitmapTexture;
import openfl.geom.Rectangle;
import openfl.Vector;

/**
 * ...
 * @author P.J.Shand
 */
interface IAway3DPackage 
{
	function get_container():ObjectContainer3D;
	function get_meshs():Vector<Mesh>;
	function meshByName(name:String):Mesh;
	function get_textures():Vector<BitmapTexture>;
	function textureByName(name:String):BitmapTexture;
	function get_materials():Vector<TextureMaterial>;
	function materialByName(name:String):TextureMaterial;
	function get_rectangles():Vector<Rectangle>;
	function rectangleByName(name:String):Rectangle;	
}