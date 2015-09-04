package com.imagination.texturePacker.impl.convert.away3D 
{
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
	import openfl.utils.Dictionary;
	import openfl.Vector;
	/**
	 * ...
	 * @author P.J.Shand
	 */
	class Away3DConverter 
	{
		private static var cache:Dictionary = new Dictionary();
		
		public function new() 
		{
			
		}
		
		public static function parse(base:*, generateMipmaps:Boolean=true):IAway3DPackage
		{
			var baseDisplay:DisplayObjectContainer;
			if (base is Class) {
				if (!cache[base]) {
					cache[base] = new base();
				}
				baseDisplay = cache[base];
			}
			else {
				baseDisplay = base;
			}
			var container:ObjectContainer3D = new ObjectContainer3D();
			//TexturePacker.MAX_SIZE = 2048;
			var texturePacker:ITexturePacker = new TexturePacker();
			
			var itemObjects:Dictionary = new Dictionary();
			
			for (var i:Int = 0; i < baseDisplay.numChildren; i++) 
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
			for each (var item:ItemObject in itemObjects) 
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

}

import openfl.display.DisplayObject;
import openfl.geom.Point;

class ItemObject
{
	public var x:Float;
	public var y:Float;
	public var width:Float;
	public var height:Float;
	public var name:String;
	
	public function ItemObject(child:DisplayObject):Void
	{
		this.name = child.name;
		this.x = child.x;
		this.y = child.y;
		this.width = child.width;
		this.height = child.height;
	}
}