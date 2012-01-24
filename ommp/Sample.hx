package ommp;

class Sample
{
	public var name:String;
	public var data:Array<Float>;
	public var length:Int;
	public var fine:Int;
	public var volume:Int;
	public var repeatOffset:Int;
	public var repeatLength:Int;
	
	public function new()
	{
	
	}
	public function getData( ):Array<Float>
	{
		if( data == null )
		{
			data = new Array<Float>();
		}
		
		return data;
	}
	
}