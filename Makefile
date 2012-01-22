all: test ommp
	
test: test.swf
	
ommp: ommp.swf OMMP.hx
	
ommp.swf: ommp.hxml $(wildcard ommp/*.hx)
	haxe $<
	cp ommp.swf build

OMMP.hx: ommp.swf
	haxe --gen-hx-classes ommp/ModulePlayer.hx
	cp hxclasses/ommp/ModulePlayer.hx build/ommp/


test.swf: test.hxml testdata.swf $(wildcard test/*.hx)
	haxe $<

testdata.swf: $(wildcard test/data/*)
	swfmill simple testdata.xml testdata.swf