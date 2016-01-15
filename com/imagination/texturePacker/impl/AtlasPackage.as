package com.imagination.texturePacker.impl 
{
	import com.imagination.texturePacker.api.IAtlasPackage;
	import flash.display.BitmapData;
	
	/**
	 * ...
	 * @author P.J.Shand
	 */
	public class AtlasPackage implements IAtlasPackage 
	{	
		private var _bitmapData:BitmapData;
		private var _xml:XML;
		private var _next:IAtlasPackage;
		
		public function AtlasPackage(bmdWidth:int, bmdHeight:int, xmlString:String, n:IAtlasPackage=null) 
		{
			_next = n;
			_bitmapData = new BitmapData(bmdWidth, bmdHeight, true, 0x00222222);
			_xml = XML(xmlString);
		}		
		
		public function get bitmapData():BitmapData 
		{
			return _bitmapData;
		}
		
		public function get xml():XML 
		{
			return _xml;
		}
		
		public function get next():IAtlasPackage 
		{
			return _next;
		}
	}
}