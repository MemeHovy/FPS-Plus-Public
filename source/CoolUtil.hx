package;

import cpp.Float32;
import sys.io.File;
import sys.FileSystem;
import flixel.math.FlxMath;
import flixel.FlxG;
import lime.utils.Assets;

using StringTools;

class CoolUtil
{

	public static function coolTextFile(path:String):Array<String>{
		var daList:Array<String> = getText(path).trim().split('\n');

		for (i in 0...daList.length){
			daList[i] = daList[i].trim();
		}

		return daList;
	}

	public static function numberArray(max:Int, ?min = 0):Array<Int>{
		var dumbArray:Array<Int> = [];
		for (i in min...max)
		{
			dumbArray.push(i);
		}
		return dumbArray;
	}

	/*
	*	Adjusts the value based on the reference FPS.
	*/
	public static inline function fpsAdjust(value:Float, ?referenceFps:Float = 60):Float{
		return value * (referenceFps * FlxG.elapsed);
	}

	/*
	*	Lerp that calls `fpsAdjust` on the ratio.
	*/
	public static inline function fpsAdjsutedLerp(a:Float, b:Float, ratio:Float):Float{
		return FlxMath.lerp(a, b, clamp(fpsAdjust(ratio), 0, 1));
	}

	/*
	* Uses FileSystem.exists for desktop and Assets.exists for non-desktop builds.
	* This is because Assets.exists just checks the manifest and can't find files that weren't compiled with the game.
	* This also means that if you delete a file, it will return true because it's still in the manifest.
	* FileSystem only works on certain build types though (namely, not web).
	*/
	public static function exists(path:String):Bool{
		#if desktop
		return FileSystem.exists(path);
        #else
        return Assets.exists(path);
		#end
	}

	//Same as above but for getting text from a file.
	public static function getText(path:String):String{
		#if desktop
		return File.getContent(path);
        #else
        return Assets.getText(path);
		#end
	}

	public static function clamp(v:Float, min:Float, max:Float):Float {
		if(v < min) { v = min; }
		if(v > max) { v = max; }
		return v;
	}
}
