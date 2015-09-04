package com.imagination.texturePacker.impl;

import com.imagination.texturePacker.api.IAtlasPackage;
import openfl.display.BitmapData;

/**
 * ...
 * @author P.J.Shand
 */
class AtlasPackage implements IAtlasPackage 
{	
	private var _bitmapData:BitmapData;
	private var _xml:Xml;
	private var _next:IAtlasPackage;
	
	public var bitmapData(get, null):BitmapData;
	public var xml(get, null):Xml;
	public var next(get, null):IAtlasPackage;
	
	public function new(bmdWidth:Int, bmdHeight:Int, xmlString:String, n:IAtlasPackage=null) 
	{
		_next = n;
		_bitmapData = new BitmapData(bmdWidth, bmdHeight, true, 0x00222222);
		_xml = Xml.parse(xmlString);
	}		
	
	public function get_bitmapData():BitmapData 
	{
		return _bitmapData;
	}
	
	public function get_xml():Xml 
	{
		return _xml;
	}
	
	public function get_next():IAtlasPackage 
	{
		return _next;
	}
}