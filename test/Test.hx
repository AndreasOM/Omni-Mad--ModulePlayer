package ;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.utils.ByteArray;
import haxe.Log;

import TestData;

class Test extends Sprite
{
	static function main()
	{
		var test = new Test();
	}
	
	public function new()
	{
		super();
		flash.Lib.current.addChild( this );
		
		var mp = new ommp.ModulePlayer();
		Log.trace( mp );
		
		try {
				var data:ByteArray = new TestMod01();
				Log.trace( "TestMod01 Size: "+data.bytesAvailable );
				mp.loadFromBytes( data );
		} catch( msg : String ) {
			Log.trace("Error occurred: " + msg);
		} catch (e:Dynamic) {
			Log.trace( "" + e.message);
		}
		
		var debugBitmapData:BitmapData = new BitmapData( 768, 256, false , 0xaa2244 );
		var debugBitmap:Bitmap = new Bitmap( debugBitmapData );
		
		addChild( debugBitmap );
		debugBitmap.x = 1050-debugBitmapData.width;
		
		var renderSample:Int = 0;
		try
		{
			renderSample = Std.parseInt( flash.Lib.current.loaderInfo.parameters.renderSample );
		}
		catch (whatever:Dynamic)
		{
		}

		var renderOffset:Int = 0;
		try
		{
			renderOffset = Std.parseInt( flash.Lib.current.loaderInfo.parameters.renderOffset );
		}
		catch (whatever:Dynamic)
		{
		}
				
//		mp.renderSample( 0, 16, debugBitmapData );
		mp.renderSample( 0, renderSample, debugBitmapData, renderOffset, Std.int( debugBitmapData.width ) );
	}
}