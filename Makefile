all: ommp test

test: test.swf
	
ommp: ommp.swf OMMP.hx
	
ommp.swf: ommp.hxml $(wildcard ommp/*.hx)
	haxe $<
	cp ommp.swf build

OMMP.hx: ommp.swf
	haxe --gen-hx-classes ommp/ModulePlayer.hx -swf /dev/null
	cp hxclasses/ommp/ModulePlayer.hx build/ommp/


test.swf: test.hxml testdata.swf $(wildcard test/*.hx) build/ommp.swf build/ommp/ModulePlayer.hx
	haxe $<

testdata.swf: $(wildcard test/data/*)
	swfmill simple testdata.xml testdata.swf
	
clean:
	rm test.swf
	
