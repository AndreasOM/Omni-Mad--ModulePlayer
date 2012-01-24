package ommp;

extern class ModulePlayer {
	function new() : Void;
	function loadFromBytes(data : flash.utils.ByteArray) : Void;
	function renderSample(instrument : Int, sampleIndex : Int, data : flash.display.BitmapData) : Void;
}
