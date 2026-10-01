package;

import haxe.io.Bytes;
import haxe.io.Path;
import lime.utils.AssetBundle;
import lime.utils.AssetLibrary;
import lime.utils.AssetManifest;
import lime.utils.Assets;

#if sys
import sys.FileSystem;
#end

#if disable_preloader_assets
@:dox(hide) class ManifestResources {
	public static var preloadLibraries:Array<Dynamic>;
	public static var preloadLibraryNames:Array<String>;
	public static var rootPath:String;

	public static function init (config:Dynamic):Void {
		preloadLibraries = new Array ();
		preloadLibraryNames = new Array ();
	}
}
#else
@:access(lime.utils.Assets)


@:keep @:dox(hide) class ManifestResources {


	public static var preloadLibraries:Array<AssetLibrary>;
	public static var preloadLibraryNames:Array<String>;
	public static var rootPath:String;


	public static function init (config:Dynamic):Void {

		preloadLibraries = new Array ();
		preloadLibraryNames = new Array ();

		rootPath = null;

		if (config != null && Reflect.hasField (config, "rootPath")) {

			rootPath = Reflect.field (config, "rootPath");

			if(!StringTools.endsWith (rootPath, "/")) {

				rootPath += "/";

			}

		}

		if (rootPath == null) {

			#if (ios || tvos)
			rootPath = "assets/";
			#elseif android
			rootPath = "";
			#elseif (emscripten || webassembly)
			rootPath = "";
			#elseif (console || sys)
			rootPath = lime.system.System.applicationDirectory;
			#else
			rootPath = "./";
			#end

		}

		#if (openfl && !flash && !display)
		
		#end

		var data, manifest, library, bundle;

		data = '{"name":null,"assets":"aoy4:sizei228672y4:typey5:MUSICy2:idy21:assets%2Fambiente.mp3y9:pathGroupaR4hy7:preloadtgoy4:pathy18:assets%2FArbol.pngR0i160424R1y5:IMAGER3R8R6tgoR0i36780R1R2R3y25:assets%2Fatrapar_roja.mp3R5aR10hR6tgoR0i50155R1y5:SOUNDR3y26:assets%2Fatrapar_verde.oggR5aR12hR6tgoR0i30929R1R11R3y23:assets%2Fcaida_roja.oggR5aR13hR6tgoR7y20:assets%2FCanasta.pngR0i226883R1R9R3R14R6tgoR0i106997R1R11R3y20:assets%2Fderrota.oggR5aR15hR6tgoR7y27:assets%2FManzana%20Roja.pngR0i60967R1R9R3R16R6tgoR7y28:assets%2FManzana%20Verde.pngR0i52270R1R9R3R17R6tgoR0i1012800R1R11R3y19:assets%2Fmusica.oggR5aR18hR6tgoR0i70080R1R11R3y21:assets%2Fvictoria.oggR5aR19hR6tgh","rootPath":null,"version":2,"libraryArgs":[],"libraryType":null}';
		manifest = AssetManifest.parse (data, rootPath);
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("default", library);
		

		library = Assets.getLibrary ("default");
		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("default");
		

	}


}

#if !display
#if flash

@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_ambiente_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_arbol_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_atrapar_roja_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_atrapar_verde_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_caida_roja_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_canasta_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_derrota_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_manzana_roja_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_manzana_verde_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_musica_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_victoria_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__manifest_default_json extends null { }


#elseif (desktop || cpp)

@:keep @:file("Assets/ambiente.mp3") @:noCompletion #if display private #end class __ASSET__assets_ambiente_mp3 extends haxe.io.Bytes {}
@:keep @:image("Assets/Arbol.png") @:noCompletion #if display private #end class __ASSET__assets_arbol_png extends lime.graphics.Image {}
@:keep @:file("Assets/atrapar_roja.mp3") @:noCompletion #if display private #end class __ASSET__assets_atrapar_roja_mp3 extends haxe.io.Bytes {}
@:keep @:file("Assets/atrapar_verde.ogg") @:noCompletion #if display private #end class __ASSET__assets_atrapar_verde_ogg extends haxe.io.Bytes {}
@:keep @:file("Assets/caida_roja.ogg") @:noCompletion #if display private #end class __ASSET__assets_caida_roja_ogg extends haxe.io.Bytes {}
@:keep @:image("Assets/Canasta.png") @:noCompletion #if display private #end class __ASSET__assets_canasta_png extends lime.graphics.Image {}
@:keep @:file("Assets/derrota.ogg") @:noCompletion #if display private #end class __ASSET__assets_derrota_ogg extends haxe.io.Bytes {}
@:keep @:image("Assets/Manzana Roja.png") @:noCompletion #if display private #end class __ASSET__assets_manzana_roja_png extends lime.graphics.Image {}
@:keep @:image("Assets/Manzana Verde.png") @:noCompletion #if display private #end class __ASSET__assets_manzana_verde_png extends lime.graphics.Image {}
@:keep @:file("Assets/musica.ogg") @:noCompletion #if display private #end class __ASSET__assets_musica_ogg extends haxe.io.Bytes {}
@:keep @:file("Assets/victoria.ogg") @:noCompletion #if display private #end class __ASSET__assets_victoria_ogg extends haxe.io.Bytes {}
@:keep @:file("") @:noCompletion #if display private #end class __ASSET__manifest_default_json extends haxe.io.Bytes {}



#else



#end

#if (openfl && !flash)

#if html5

#else

#end

#end
#end

#end