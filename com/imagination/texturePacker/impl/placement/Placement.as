package com.imagination.texturePacker.impl.placement 
{
	import com.imagination.texturePacker.api.placement.IPlacement;
	import flash.display.IBitmapDrawable;
	import flash.display.Shape;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author P.J.Shand
	 */
	public class Placement implements IPlacement 
	{
		private var areaRect:Rectangle;
		
		public function Placement(areaRect:Rectangle) 
		{
			this.areaRect = areaRect;
		}
		
		public function get x():Number 
		{
			return areaRect.x;
		}
		
		public function get y():Number 
		{
			return areaRect.y;
		}
		
		public function get width():Number 
		{
			return areaRect.width;
		}
		
		public function get height():Number 
		{
			return areaRect.height;
		}
		
		public function place(source:IBitmapDrawable):Rectangle
		{
			var objectRect:Rectangle;
			if (source is Shape) objectRect = new Rectangle(0, 0, source['width'], source['height']);
			else objectRect = source['rect'];
			
			if (!objectRect) objectRect = new Rectangle(0, 0, source['width'], source['height']);
			
			if (objectRect.width < width && objectRect.height < height) {
				return new Rectangle(x, y, source['width'], source['height']);
			}
			else {
				return null;
			}
		}
	}
}