package ommp;

extern class ModulePlayer {
	function new() : Void;
	function bresenham(bitmapData : flash.display.BitmapData, x0 : Float, y0 : Float, x1 : Float, y1 : Float, c : UInt) : Void;
	function loadFromBytes(data : flash.utils.ByteArray) : Void;
	function renderSample(instrument : Int, sampleIndex : Int, data : flash.display.BitmapData, ?offset : Int, ?range : Int) : Void;
}
