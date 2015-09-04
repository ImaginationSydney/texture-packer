package com.imagination.texturePacker.impl.math;

/**
 * ...
 * @author ...
 */
class PowerOf2 
{
	
	public function new() 
	{
		
	}
	
	public static function next(value:UInt):UInt
	{
		var p:UInt = 1;
		while (p < value)
			p <<= 1;
		return p;
	}
}