package com.imagination.texturePacker.impl.convert.away3D;

import away3d.core.base.CompactSubGeometry;
import away3d.core.base.SubMesh;
import away3d.entities.Mesh;
import away3d.textures.BitmapTexture;
import com.imagination.texturePacker.api.IAtlasPackage;
import openfl.display.BitmapData;
import openfl.errors.ArgumentError;
import openfl.geom.Rectangle;
import openfl.Vector;
/**
 * ...
 * @author ...
 */
class AtlasUtil 
{
	
	public function new() 
	{
		
	}
	
	public static function setUV(mesh:Mesh, name:String, xml:Xml, texture:BitmapTexture):Void 
	{
		if(mesh == null)
			throw new ArgumentError("submesh cannot be null");
		
		var regionRc:Rectangle = null;
		for (TextureAtlas in xml.elementsNamed("TextureAtlas")) {
			if (TextureAtlas.nodeType == Xml.Element ) {
				for (SubTexture in TextureAtlas.elementsNamed("SubTexture")) {
					if (SubTexture.nodeType == Xml.Element ) {
						if (SubTexture.get("name") == name) {
							var _x:Float = Std.parseFloat(SubTexture.get("x"));
							var _y:Float = Std.parseFloat(SubTexture.get("y"));
							var _width:Float = Std.parseFloat(SubTexture.get("width"));
							var _height:Float = Std.parseFloat(SubTexture.get("height"));
							regionRc = new Rectangle(_x, _y, _width, _height);
						}
					}
				}
			}
		}
		
		if(regionRc == null)
			throw new ArgumentError("given region does not exist: " + name);
			
		var submesh:SubMesh = mesh.subMeshes[0];
		
		var w:Float = texture.width;
		var h:Float = texture.height;
		
		var fractionRect:Rectangle = new Rectangle();
		fractionRect.x = regionRc.x / w;
		fractionRect.y = regionRc.y / h;
		fractionRect.width =  regionRc.width / w;
		fractionRect.height = regionRc.height / h;
		
		var compactSubGeometry:CompactSubGeometry = cast(mesh.geometry.subGeometries[0]);
		var vertexData = compactSubGeometry.vertexData;
		updateUVData(fractionRect, vertexData, compactSubGeometry);
	}
	
	private static function updateUVData(fractionRect:Rectangle, vertexData:Vector<Float>, compactSubGeometry:CompactSubGeometry):Void 
	{
		/**
		 * Updates the vertex data. All vertex properties are contained in a single Vector, and the order is as follows:
		 * 0 - 2: vertex position X, Y, Z
		 * 3 - 5: front X, Y, Z
		 * 6 - 8: tangent X, Y, Z
		 * 9 - 10: U V
		 * 11 - 12: Secondary U V
		 */
		var i:Int = 0;
		vertexData[(0 * 13) + (i + 9)] = fractionRect.x;// 0;
		vertexData[(0 * 13) + (i + 10)] = fractionRect.y + fractionRect.height;//1;
		
		vertexData[(1 * 13) + (i + 9)] = fractionRect.x + fractionRect.width;//1;
		vertexData[(1 * 13) + (i + 10)] = fractionRect.y + fractionRect.height;//1;
		
		vertexData[(2 * 13) + (i + 9)] = fractionRect.x;//0;
		vertexData[(2 * 13) + (i + 10)] = fractionRect.y;//0;
		
		vertexData[(3 * 13) + (i + 9)] = fractionRect.x + fractionRect.width;//1;
		vertexData[(3 * 13) + (i + 10)] = fractionRect.y;//0;
		
		compactSubGeometry.updateData(vertexData);
	}	
}