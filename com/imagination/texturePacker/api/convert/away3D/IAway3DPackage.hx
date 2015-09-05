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
	var container(get, null):ObjectContainer3D;
	var meshs(get, null):Vector<Mesh>;
	var textures(get, null):Vector<BitmapTexture>;
	var materials(get, null):Vector<TextureMaterial>;
	var rectangles(get, null):Vector<Rectangle>;
	
	function meshByName(name:String):Mesh;
	function textureByName(name:String):BitmapTexture;
	function materialByName(name:String):TextureMaterial;
	function rectangleByName(name:String):Rectangle;		
}