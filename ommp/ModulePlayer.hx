package ommp;

import flash.display.BitmapData;
import flash.utils.ByteArray;

import haxe.Log;

import ommp.Module;

class ModulePlayer
{
	static function main()
	{
	}

	var module:Module;
	
	public function new()
	{
		module = null;
	}

	// :TODO: pull out getters into ByteArrayReader/File
	
	private function getStringFromOffset( data:ByteArray, offset:Int, len:Int ) : String
	{
		var s:String = "";
		for( i in (offset+0)...(offset+len) )
		{
			var b:Int = data[ i ];
			if( b == 0 )
			{
				break;
			}
			s += String.fromCharCode( b );
		}
		
		return s;
	}
	
	private function getUint16FromOffset( data:ByteArray, offset:Int ) : Int
	{
		var r:Int = 0;
		r = data[ offset ];
		r *= 256;
		r += data[ offset+1 ];
		
		return r;
	}
	
	private function getUint8FromOffset( data:ByteArray, offset:Int ) : Int
	{
		var r:Int = 0;
		r = data[ offset ];
		
		return r;
	}
	
	private function getSint8FromOffset( data:ByteArray, offset:Int ) : Int
	{
		var r:Int = 0;
		r = data[ offset ];
		if( r > 127 )
		{
			r -= 0x100;
		}
		
		return r;
	}
	
    
	public function loadFromBytes( data:ByteArray )
	{
		// mostly according to http://www.aes.id.au/modformat.html
		
		module = new Module();
		
		data.endian = flash.utils.Endian.BIG_ENDIAN;
		var offset:Int = 0;
		var title:String = getStringFromOffset( data, offset, 20 );
		Log.trace( "Title: "+title );
//        xm = (s == "Extended Module: ");

		// check the signature first
		var sig:String = getStringFromOffset( data, 1080, 4 );
		Log.trace( "Signature: "+sig );
		switch( sig )
		{
			case "M.K.", "FLT4", "4CHN":
				module.sampleCount = 31;
				module.channelCount = 4;
			default:
				throw( "Unknown signature"+sig );
		}
		
		offset += 20;
		var moreSamples:Bool = true;
		
		var sampleCount:Int = 0;
		while( moreSamples )
		{
			var sample:Sample = module.getSample( sampleCount );
			
			sample.name = getStringFromOffset( data, offset, 22 );
			offset += 22;
			
			sample.length = getUint16FromOffset( data, offset )*2;
			offset += 2;
			
			sample.fine = getUint8FromOffset( data, offset );
			offset += 1;
			
			sample.volume = getUint8FromOffset( data, offset );
			offset += 1;
			
			sample.repeatOffset = getUint16FromOffset( data, offset );
			offset += 2;
			
			sample.repeatLength = getUint16FromOffset( data, offset );
			offset += 2;
			
			++sampleCount;
			if( sampleCount>=module.sampleCount )
			{
				moreSamples = false;
			}
		}
		
		var songPositions = getUint8FromOffset( data, offset );
		offset += 1;
		Log.trace( "\tsongPositions: "+songPositions );

		var dummy = getUint8FromOffset( data, offset );
		offset += 1;
		Log.trace( "\tdummy: "+dummy );
		
		var order = module.order;
		for (i in 0...128)
		{
			order[i] = getUint8FromOffset( data, offset );
			++offset;
		}
		
		var sig2 = getStringFromOffset( data, offset, 4 );
		Log.trace( "\tSignature: "+sig2 );
		// :TODO: fix offset for other format subtypes
		
		// there is no field for the pattern count, so we have to find the highest one in the play order
		var patternCount:Int = 0;
		for (i in 0...songPositions)
		{
			if (patternCount < order[ i ] )
			{
				patternCount = order[ i ];
			}
		}
		patternCount += 1;
		
		Log.trace( "\tpatternCount: "+patternCount );
		
		offset += patternCount*1024;
		
		for( s in 0...module.sampleCount )
		{
			var sample = module.getSample( s );
//			Log.trace( "Loading sample ("+s+") "+sample.name );
			var sampleData = sample.getData();
			for( j in 0...sample.length )
			{
				var b:Int = getSint8FromOffset( data, offset );
				++offset;
				var t = Std.int( b*64.0/100 );
				sampleData[ j ] = b/-127.0;
/*
				if( s == 16 && j<20 )
				{
					Log.trace( "S: "+j+" "+b+" "+sampleData[ j ] );
				}
*/
			}
		
		}
		
		Log.trace( "Done" );
	}
	
	public function renderSample( instrument:Int, sampleIndex:Int, data:BitmapData )
	{
		var sample = module.getSample( sampleIndex );
		var wave = sample.getData();
		Log.trace( "Rendering "+sample.name );
		var sX:Float = data.width/sample.length;
		var sY:Float = data.height/2.0;
		var oY:Int = Std.int( data.height/2.0 );
		
		data.lock();
		data.setPixel( 5, 5, 0x000000 );
		for( i in 0...sample.length )
		{
			var x:Int = Std.int( i*sX );
			var y:Int = Std.int( wave[ i ]*sY )+oY;
			data.setPixel( x, y, 0x000000 );
/*
			if( i<20 )
			{
				Log.trace( " "+wave[ i ]+" -> "+y );
			}
*/
		}
		data.unlock();
	}
	
	private function test()
	{
	
	}
}