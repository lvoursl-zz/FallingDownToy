package ;

import flash.display.Sprite;
import flash.events.Event;
import flash.Lib;
import openfl.display.Bitmap;
import openfl.events.KeyboardEvent;
import openfl.events.MouseEvent;

/**
 * ...
 * @author lvoursl 
 */

class Main extends Sprite 
{
	var inited:Bool;
	var game:Game;
	var screen:Screen;
	var frame:Int = 0;
	public static var score:Int = 0;
	public static var bestScore:Int = 0;
	public static var keys:Map<Int,Bool> = new Map();
	public static var heroBmp:Bitmap = new Bitmap();
	/* ENTRY POINT */
	
	function resize(e) 
	{
		if (!inited) init();
		// else (resize or orientation change)
	}
	
	function init() 
	{
		if (inited) return;
		inited = true;
		
		screen = new Screen("helloscreen");
		addChild(screen);
			
		
		stage.addEventListener(KeyboardEvent.KEY_DOWN, onDown);
		stage.addEventListener(KeyboardEvent.KEY_UP, onUp);	
		// (your code here)
		
		// Stage:
		// stage.stageWidth x stage.stageHeight @ stage.dpiScale
		
		// Assets:
		// nme.Assets.getBitmapData("img/assetname.jpg");
	}
		
	public function onDown(e:KeyboardEvent) {
		keys[e.keyCode] = true;
		if ((screen != null) && (keys[32])) {
			screen.parent.removeChild(screen);
			screen = null;
			game = new Game();
			game.addEventListener("gameover", gameover);
			addChild(game);
		} else if ((screen != null) && (screen.type == "helloscreen") && (keys[37])) {
			// left; shit code ;p
			if (screen.votedHero == 2) screen.votedHero = 1;
				else if (screen.votedHero == 3) screen.votedHero = 2;
			screen.changeHero(screen.votedHero);
		} else if ((screen != null) && (screen.type == "helloscreen") && (keys[39])) {
			// right;
			if (screen.votedHero == 1) screen.votedHero = 2;
				else if (screen.votedHero == 2) screen.votedHero = 3;
			screen.changeHero(screen.votedHero);
		}
	}
	
	public function onUp(e:KeyboardEvent) {
		keys[e.keyCode] = false;
	}
	
	public function gameover(e:Event) {
		if (game != null) {
			game.removeEventListener("gameover", gameover);
			game.parent.removeChild(game);
			game = null;

			screen = new Screen("gameover");
			addChild(screen); 
		}
	}
	

	/* SETUP */

	public function new() 
	{
		super();	
		addEventListener(Event.ADDED_TO_STAGE, added);
	}

	function added(e) 
	{
		removeEventListener(Event.ADDED_TO_STAGE, added);
		stage.addEventListener(Event.RESIZE, resize);
		#if ios
		haxe.Timer.delay(init, 100); // iOS 6
		#else
		init();
		#end
	}
	
	public static function main() 
	{
		// static entry point
		Lib.current.stage.align = flash.display.StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
		Lib.current.addChild(new Main());
	}
}
