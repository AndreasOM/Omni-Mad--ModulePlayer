package ommp;

import flash.events.SampleDataEvent;
import flash.media.SoundChannel;

import ommp.Sample;

class Channel
{

	public var soundChannel:SoundChannel;
	public var sample:Sample;
	public var position:Int;
	
	public function new()
	{
	
	}
	
	public function setSample( sample:Sample )
	{
		this.sample = sample;
		position = 0;
	}
	
	public function handleSampleData( e:SampleDataEvent )
	{
		var data = sample.getData();
		for( i in 0...8192 )
		{
//			var v:Float = Math.random();
//			var v:Float = Math.sin((Std.int(i+e.position)/Math.PI/2))*0.25;
			var v:Float = data[ position ];
			++position;
			if( position > sample.length )
			{
				position = 0;
			}
			e.data.writeFloat( v );
			e.data.writeFloat( v );
		}
	}
	
}
