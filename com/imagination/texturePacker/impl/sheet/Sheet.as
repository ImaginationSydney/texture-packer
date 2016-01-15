package com.imagination.texturePacker.impl.sheet 
{
	import com.imagination.core.utils.bitmapdata.BitmapDataUtils;
	import com.imagination.core.utils.math.PowerOf2;
	import com.imagination.texturePacker.api.IAtlasPackage;
	import com.imagination.texturePacker.api.placement.IPlacement;
	import com.imagination.texturePacker.api.sheet.ISheet;
	import com.imagination.texturePacker.impl.AtlasPackage;
	import com.imagination.texturePacker.impl.placement.Placement;
	import com.imagination.texturePacker.impl.TexturePacker;
	import flash.display.BitmapData;
	import flash.display.IBitmapDrawable;
	import flash.display.Shape;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author P.J.Shand
	 */
	public class Sheet implements ISheet 
	{
		private var atlasPackage:IAtlasPackage;
		private var sources:Vector.<IBitmapDrawableObject> = new Vector.<IBitmapDrawableObject>();
		
		private var placements:Vector.<IPlacement> = new Vector.<IPlacement>();
		
		private var xmlString:String;
		
		private var tempBmd:BitmapData;
		
		private var minRect:Rectangle;
		
		public function Sheet() 
		{
			minRect = new Rectangle();
			
			placements.push(new Placement(new Rectangle(
				TexturePacker.framePadding, 
				TexturePacker.framePadding, 
				TexturePacker.MAX_SIZE - (TexturePacker.framePadding * 2), 
				TexturePacker.MAX_SIZE - (TexturePacker.framePadding * 2)
			)));
		}
		
		public function add(source:IBitmapDrawable):void
		{
			sources.push(new IBitmapDrawableObject(source));
		}
		
		public function pack():IAtlasPackage
		{
			var unsuccessfullyItems:Vector.<IBitmapDrawableObject> = new Vector.<IBitmapDrawableObject>();
			sources.sort(SortSourceHeight);
			
			tempBmd = new BitmapData(TexturePacker.MAX_SIZE, TexturePacker.MAX_SIZE, true, 0x00000000);
			
			xmlString = "";
			xmlString += '<TextureAtlas imagePath="">'
			
			for (var i:int = 0; i < sources.length; i++) 
			{
				var unsuccessfully:IBitmapDrawableObject = place(sources[i]);
				if (unsuccessfully) unsuccessfullyItems.push(unsuccessfully);
			}
			
			/*if (TexturePacker.debug){
				for (var j:int = 0; j < placements.length; j++) 
				{
					var boundRect:Shape = new Shape();
					boundRect.graphics.lineStyle(1, 0xFF0000, 1);
					boundRect.graphics.drawRect(placements[j].x+1, placements[j].y+1, placements[j].width-1, placements[j].height-1);
					tempBmd.draw(boundRect);
				}
			}*/
			
			xmlString += '</TextureAtlas>';
			
			var bmdWidth:int = PowerOf2.next(minRect.width);
			var bmdHeight:int = PowerOf2.next(minRect.height);
			atlasPackage = new AtlasPackage(bmdWidth, bmdHeight, xmlString, atlasPackage);
			atlasPackage.bitmapData.copyPixels(tempBmd, atlasPackage.bitmapData.rect, atlasPackage.bitmapData.rect.topLeft);
			tempBmd.dispose();
			tempBmd = null;
			
			// If there are any left over IBitmapDrawableObjects then create another sheet and link via the next property
			if (unsuccessfullyItems.length > 0) {
				placements = new Vector.<IPlacement>();
				sources = unsuccessfullyItems;
				minRect = new Rectangle();
				placements.push(new Placement(new Rectangle(
					TexturePacker.framePadding, 
					TexturePacker.framePadding, 
					TexturePacker.MAX_SIZE - (TexturePacker.framePadding * 2), 
					TexturePacker.MAX_SIZE - (TexturePacker.framePadding * 2)
				)));
				
				pack();
			}
			
			return atlasPackage;
		}
		
		private function SortSourceHeight(itemA:IBitmapDrawableObject, itemB:IBitmapDrawableObject):Number 
		{
			if (itemA.height < itemB.height) return 1;
			else if (itemA.height > itemB.height) return -1;
			else return 0;
		}
		
		private function place(sourceObject:IBitmapDrawableObject):IBitmapDrawableObject 
		{
			if (sourceObject.width > TexturePacker.MAX_SIZE || sourceObject.height > TexturePacker.MAX_SIZE) {
				trace("WARMING: source larger than max texture size");
				return sourceObject;
			}
			if (sourceObject.width > sourceObject.height) {
				placements.sort(SortWidth);
			}
			else {
				placements.sort(SortHeight);
			}
			
			for (var i:int = 0; i < placements.length; i++) 
			{
				var placement:IPlacement = placements[i];
				var placementRect:Rectangle = placement.place(sourceObject.source);
				
				if (placementRect) {
					
					var matrix:Matrix = new Matrix();
					
					/*matrix.scale(
						(placementRect.width - (TexturePacker.objectPadding * 2)) / placementRect.width, 
						(placementRect.height - (TexturePacker.objectPadding * 2)) / placementRect.height
					);*/
					matrix.tx = placementRect.x - sourceObject.bounds.x;
					matrix.ty = placementRect.y - sourceObject.bounds.y;
					
					xmlString += '<SubTexture name="' + sourceObject.id +
						'" x="' + Math.round(placementRect.x) + 
						'" y="' + Math.round(placementRect.y) + 
						'" width="' + Math.round(placementRect.width) + 
						'" height="' + Math.round(placementRect.height) + 
						'" pivotX="' + Math.round(sourceObject.bounds.x) + 
						'" pivotY="' + Math.round(sourceObject.bounds.y) + 
					'"/>';
					
					if (minRect.width < Math.round(placementRect.x) + Math.round(placementRect.width + TexturePacker.objectPadding)) {
						minRect.width = Math.round(placementRect.x) + Math.round(placementRect.width + TexturePacker.objectPadding);
					}
					if (minRect.height < Math.round(placementRect.y) + Math.round(placementRect.height + TexturePacker.objectPadding)) {
						minRect.height = Math.round(placementRect.y) + Math.round(placementRect.height + TexturePacker.objectPadding);
					}
					
					
					if (TexturePacker.debug) {
						var rect:Shape = new Shape();
						rect.graphics.lineStyle(3, 0xFFFF0000);
						rect.graphics.beginFill(0xFF0000, 0.1);
						rect.graphics.drawRect(Math.round(placementRect.x), Math.round(placementRect.y), Math.round(placementRect.width), Math.round(placementRect.height));
						tempBmd.draw(rect);
						rect = null;
					}
					
					tempBmd.draw(sourceObject.source, matrix, null, null, null, true);
					
					placements.splice(i, 1);
					
					placements.push(new Placement(new Rectangle(
						placement.x + placementRect.width + TexturePacker.objectPadding, 
						placement.y, 
						placement.width - placementRect.width - TexturePacker.objectPadding, 
						placementRect.height + TexturePacker.objectPadding
					)));
					
					placements.push(new Placement(new Rectangle(
						placement.x, 
						placement.y + placementRect.height + TexturePacker.objectPadding, 
						placement.width, 
						placement.height - placementRect.height - TexturePacker.objectPadding
					)));
					return null;
				}
			}
			
			return sourceObject;
		}
		
		private function SortWidth(itemA:IPlacement, itemB:IPlacement):Number 
		{
			if (itemA.width < itemB.width) return -1;
			else if (itemA.width > itemB.width) return 1;
			else return 0;
		}
		
		private function SortHeight(itemA:IPlacement, itemB:IPlacement):Number 
		{
			if (itemA.height < itemB.height) return -1;
			else if (itemA.height > itemB.height) return 1;
			else return 0;
		}
	}
}

import flash.display.IBitmapDrawable;
import flash.geom.Rectangle;
import flash.utils.Dictionary;

class IBitmapDrawableObject
{
	public var source:IBitmapDrawable;
	//public var area:Number;
	private var _width:Number;
	private var _height:Number;
	private var _id:String;
	private var _bounds:Rectangle;
	private var _name:String;
	
	private static var ref:Dictionary = new Dictionary();
	
	public function IBitmapDrawableObject(source:IBitmapDrawable):void
	{
		this.source = source;
		_width = source['width'];
		_height = source['height'];
		if (source['name']) _name = source['name'];
		_bounds = new Rectangle(0, 0, _width, _height);
		if (source['getBounds']) _bounds = source['getBounds'](source);
		
		if (!ref[source]) {
			if (_name) ref[source] = _name;
			else ref[source] = Math.floor(Math.random() * 100000000).toString(16);
		}
	}
	
	public function get width():Number 
	{
		return _width;
	}
	
	public function get height():Number 
	{
		return _height;
	}
	
	public function get id():String 
	{
		return ref[source];
	}
	
	public function get bounds():Rectangle 
	{
		return _bounds;
	}
}