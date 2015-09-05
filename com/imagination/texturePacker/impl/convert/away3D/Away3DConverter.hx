package com.imagination.texturePacker.impl.convert.away3D; 

import away3d.containers.ObjectContainer3D;
import away3d.entities.Mesh;
import away3d.materials.TextureMaterial;
import away3d.primitives.PlaneGeometry;
import away3d.textures.BitmapTexture;
import com.imagination.texturePacker.api.convert.away3D.IAway3DPackage;
import com.imagination.texturePacker.api.IAtlasPackage;
import com.imagination.texturePacker.api.ITexturePacker;
import com.imagination.texturePacker.impl.TexturePacker;
import openfl.display.DisplayObject;
import openfl.display.DisplayObjectContainer;
import openfl.geom.Rectangle;
import openfl.Vector;
/**
 * ...
 * @author P.J.Shand
 */
class Away3DConverter 
{
	private static var cache = new Map<String, Dynamic>();
	
	public function new() 
	{
		
	}
	
	public static function parse(base:Dynamic, generateMipmaps:Bool=true):IAway3DPackage
	{
		var baseDisplay:DisplayObjectContainer;
		if (Std.is(base, Class)) {
			var className = Type.getClassName(base);
			if (cache[className] == null) {
				cache[className] = Type.createInstance(base, []);
			}
			baseDisplay = cache[className];
		}
		else {
			baseDisplay = base;
		}
		var container:ObjectContainer3D = new ObjectContainer3D();
		var texturePacker:ITexturePacker = new TexturePacker();
		
		var itemObjects = new Map<String,ItemObject>();
		
		for (i in 0...baseDisplay.numChildren) 
		{
			var child:DisplayObject = baseDisplay.getChildAt(i);
			texturePacker.add(child);
			itemObjects[child.name] = new ItemObject(child);
			
		}
		
		var atlasPackage:IAtlasPackage = texturePacker.pack();
		
		var atlasTexture:BitmapTexture = new BitmapTexture(atlasPackage.bitmapData, generateMipmaps);
		var meshs = new Vector<Mesh>();
		var materials = new Vector<TextureMaterial>();
		var rectangles = new Vector<Rectangle>();
		var j:Int = 0;
		for (item in itemObjects) 
		{
			var material:TextureMaterial = new TextureMaterial(atlasTexture, true, false, generateMipmaps);
			//material.animateUVs = true;
			material.alphaBlending = true;
			material.smooth = true;
			material.name = item.name;
			materials.push(material);
			
			var geo:PlaneGeometry = new PlaneGeometry(item.width, item.height, 1, 1, false);
			var mesh:Mesh = new Mesh(geo, material);
			mesh.x = item.x;
			mesh.y = -item.y;
			mesh.name = item.name;
			container.addChild(mesh);
			
			AtlasUtil.setUV(mesh, item.name, atlasPackage.xml, atlasTexture);
			meshs.push(mesh);
			
			rectangles.push(new Rectangle(item.x, item.y, item.width, item.height));
			
			j++;
		}
		
		var away3DPackage:IAway3DPackage = new Away3DPackage(container, meshs, materials, rectangles);
		
		return away3DPackage;
	}
}