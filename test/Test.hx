package ;

import flash.utils.ByteArray;
import haxe.Log;

import TestData;

class Test
{
	static function main()
	{
		var test = new Test();
	}
	
	public function new()
	{
		var mp = new ommp.ModulePlayer();
		Log.trace( mp );
		
		try {
				var data:ByteArray = new TestMod01();
//				Log.trace( data );
				Log.trace( "TestMod01 Size: "+data.bytesAvailable );
//				mp.playBytes( data );
		} catch( msg : String ) {
		   Log.trace("Error occurred: " + msg);
		}
	}
}