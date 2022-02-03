# Bug Overview

Using a filter shader that works fine in SDL throws a shader compilation error at runtime in DX.

# Setup Instructions

1. Install latest [Haxe](https://haxe.org/download/) and [hashlink](https://hashlink.haxe.org/)
2. Navigate to project directory in your CLI
3. Run `haxelib newrepo` and `haxelib install haxelib.json`
4. Compile program with `haxe heaps.hxml`
5. Run `hl hl-sdl.dat` to test SDL version and observe outline shader functioning as expected
6. Run `hl hl-dx.dat` to test DX version and observe outline shader throw an error
