package com.imagination.texturePacker.impl.sheet;

import com.imagination.texturePacker.api.IAtlasPackage;
import com.imagination.texturePacker.api.placement.IPlacement;
import com.imagination.texturePacker.api.sheet.ISheet;
import com.imagination.texturePacker.impl.AtlasPackage;
import com.imagination.texturePacker.impl.math.PowerOf2;
import com.imagination.texturePacker.impl.placement.Placement;
import com.imagination.texturePacker.impl.TexturePacker;
import openfl.display.BitmapData;
import openfl.display.DisplayObject;
import openfl.display.IBitmapDrawable;
import openfl.display.Shape;
import openfl.geom.Matrix;
import openfl.geom.Point;
import openfl.geom.Rectangle;
import openfl.Vector;
/**
 * ...
 * @author P.J.Shand
 */
class Sheet implements ISheet 
{
	private var atlasPackage:IAtlasPackage;
	private var sources = new Vector<IBitmapDrawableObject>();
	
	private var placements = new Vector<IPlacement>();
	
	private var xmlString:String;
	
	private var tempBmd:BitmapData;
	
	private var minRect:Rectangle;
	private var bitmapSize:Point = new Point();
	
	public function new() 
	{
		minRect = new Rectangle();
		
		bitmapSize.setTo(TexturePacker.TARGET_TEXTURE_SIZE.x, TexturePacker.TARGET_TEXTURE_SIZE.y);
		createPlacement();
	}
	
	private function createPlacement() 
	{
		placements.push(new Placement(new Rectangle(
			TexturePacker.framePadding, 
			TexturePacker.framePadding, 
			bitmapSize.x - (TexturePacker.framePadding * 2), 
			bitmapSize.y - (TexturePacker.framePadding * 2)
		)));
	}
	
	public function add(source:IBitmapDrawable):Void
	{
		sources.push(new IBitmapDrawableObject(source));
	}
	
	public function pack():IAtlasPackage
	{
		var unsuccessfullyItems:Vector<IBitmapDrawableObject> = new Vector<IBitmapDrawableObject>();
		sources.sort(SortSourceHeight);
		
		checkSize();
		
		
		if (TexturePacker.debug) tempBmd = new BitmapData(Std.int(bitmapSize.x), Std.int(bitmapSize.y), true, 0x2200FF00);
		else tempBmd = new BitmapData(Std.int(bitmapSize.x), Std.int(bitmapSize.y), true, 0x00000000);
		
		xmlString = "";
		xmlString += '<TextureAtlas imagePath="">';
		
		for (i in 0...sources.length) 
		{
			var unsuccessfully:IBitmapDrawableObject = place(sources[i]);
			if (unsuccessfully != null) unsuccessfullyItems.push(unsuccessfully);
		}
		
		/*if (TexturePacker.debug){
			for (var j:Int = 0; j < placements.length; j++) 
			{
				var boundRect:Shape = new Shape();
				boundRect.graphics.lineStyle(1, 0xFF0000, 1);
				boundRect.graphics.drawRect(placements[j].x+1, placements[j].y+1, placements[j].width-1, placements[j].height-1);
				tempBmd.draw(boundRect);
			}
		}*/
		
		xmlString += '</TextureAtlas>';
		
		var bmdWidth:Int = PowerOf2.next(Std.int(minRect.width));
		var bmdHeight:Int = PowerOf2.next(Std.int(minRect.height));
		atlasPackage = new AtlasPackage(bmdWidth, bmdHeight, xmlString, atlasPackage);
		atlasPackage.bitmapData.copyPixels(tempBmd, atlasPackage.bitmapData.rect, atlasPackage.bitmapData.rect.topLeft);
		tempBmd.dispose();
		tempBmd = null;
		
		// If there are any left over IBitmapDrawableObjects then create another sheet and link via the next property
		if (unsuccessfullyItems.length > 0) {
			placements = new Vector<IPlacement>();
			sources = unsuccessfullyItems;
			minRect = new Rectangle();
			createPlacement();
			pack();
		}
		
		return atlasPackage;
	}
	
	private function checkSize():Void
	{
		if (TexturePacker.AUTO_INCREASE_TEXTURE_SIZE == false) return;
		for (j in 0...sources.length) 
		{
			var newMax:Point = new Point(Std.int(sources[j].width), Std.int(sources[j].height));
			if (newMax.x > bitmapSize.x) {
				newMax.x = PowerOf2.next(Std.int(newMax.x));
				bitmapSize.x = newMax.x;
			}
			if (newMax.y > bitmapSize.y) {
				newMax.y = PowerOf2.next(Std.int(newMax.y));
				bitmapSize.y = newMax.y;
			}
		}
	}
	
	private function SortSourceHeight(itemA:IBitmapDrawableObject, itemB:IBitmapDrawableObject):Int 
	{
		if (itemA.height < itemB.height) return 1;
		else if (itemA.height > itemB.height) return -1;
		else return 0;
	}
	
	private function place(sourceObject:IBitmapDrawableObject):IBitmapDrawableObject 
	{
		var bounds:Rectangle = sourceObject.bounds;
		if (Std.is(sourceObject, DisplayObject)) {
			var sourceDisplayObject:DisplayObject = cast(sourceObject);
			bounds = sourceDisplayObject.getBounds(sourceDisplayObject.parent);
		}
		
		if (sourceObject.width > sourceObject.height) {
			placements.sort(SortWidth);
		}
		else {
			placements.sort(SortHeight);
		}
		
		for (i in 0...placements.length) 
		{
			var placement:IPlacement = placements[i];
			var placementRect:Rectangle = placement.place(sourceObject.source);
			
			if (placementRect != null) {
				
				var matrix:Matrix = new Matrix();
				
				/*matrix.scale(
					(placementRect.width - (TexturePacker.objectPadding * 2)) / placementRect.width, 
					(placementRect.height - (TexturePacker.objectPadding * 2)) / placementRect.height
				);*/
				matrix.tx = placementRect.x - bounds.x;
				matrix.ty = placementRect.y - bounds.y;
				
				xmlString += '<SubTexture name="' + sourceObject.id +
					'" x="' + Math.round(placementRect.x) + 
					'" y="' + Math.round(placementRect.y) + 
					'" width="' + Math.round(placementRect.width) + 
					'" height="' + Math.round(placementRect.height) + 
					'" pivotX="' + Math.round(bounds.x) + 
					'" pivotY="' + Math.round(bounds.y) + 
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
		
		if (sourceObject.width <= bitmapSize.x && sourceObject.height <= bitmapSize.y) {
			return sourceObject;
		}
		return null;
	}
	
	private function SortWidth(itemA:IPlacement, itemB:IPlacement):Int 
	{
		if (itemA.width < itemB.width) return -1;
		else if (itemA.width > itemB.width) return 1;
		else return 0;
	}
	
	private function SortHeight(itemA:IPlacement, itemB:IPlacement):Int 
	{
		if (itemA.height < itemB.height) return -1;
		else if (itemA.height > itemB.height) return 1;
		else return 0;
	}
}