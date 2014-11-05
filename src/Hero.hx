package ;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.Sprite;

/**
 * ...
 * @author lvoursl 
 */
class Hero extends Sprite
{
	public var bmp:Bitmap;
	
	public function new(x:Int, y:Int) 
	{
		super();
		bmp = new Bitmap(Assets.getBitmapData("img/hero.png"));
		this.x = x;
		this.y = y;
		bmp.x = x;
		bmp.y = y;
		bmp.scaleX = 0.5;
		bmp.scaleY = 0.5;
	}
	
}