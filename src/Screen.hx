package ;
import openfl.display.Sprite;
import openfl.text.TextField;
import openfl.text.TextFieldAutoSize;

/**
 * ...
 * @author lvoursl
 */
class Screen extends Sprite
{
	var screenText:TextField;
	public function new(type:String) 
	{
		super();
		screenText = new TextField();
		screenText.multiline = true;
		if (type == "gameover") {
			screenText.htmlText = "Your score :" + Main.score + "<br>Best score : " + Main.bestScore + "<br>Click space to restart";
		} else if (type == "helloscreen") {
			screenText.htmlText = "To start click - SPACE. <br> For moving use right and left arrows";
		}
		screenText.autoSize = TextFieldAutoSize.CENTER;
		screenText.textColor = 0xffffff;
		screenText.x = 360;
		screenText.y = 220;
		addChild(screenText);
	}
	
}