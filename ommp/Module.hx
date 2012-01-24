package ommp;

import ommp.Sample;

class Module
{

	public var sampleCount:Int;
	public var channelCount:Int;
	
    public var samples:Array<Sample>;

	public var order:Array<Int>;
	
	public function new()
	{
		sampleCount = 0;
		channelCount = 0;
		samples = new Array<Sample>();
		order = new Array<Int>();
	}
	
	public function getSample( index:Int ):Sample
	{
		if( samples[ index ] == null )
		{
			samples[ index ] = new Sample();
		}
		
		return samples[ index ];
	}
}
