package ;
import openfl.Assets;
import openfl.display.Bitmap;
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
	
	public var votedHero:Int;
	public var type:String;
	
	var bmpHero1:Bitmap;
	var bmpHero2:Bitmap;
	var bmpHero3:Bitmap;
	var voteRect:Sprite;
	
	public function new(type:String) 
	{
		super();
		this.type = type;
		screenText = new TextField();
		screenText.multiline = true;
		if (type == "gameover") {
			screenText.htmlText = "Your score :" + Main.score + "<br>Best score : " + Main.bestScore + "<br>Click space to restart";
		} else if (type == "helloscreen") {
			screenText.htmlText = "To start click - SPACE. <br> For moving use right and left arrows";
			/* accommodation of heroes */
			bmpHero1 = new Bitmap(Assets.getBitmapData("img/hero1.png"));
			bmpHero2 = new Bitmap(Assets.getBitmapData("img/hero2.png"));
			bmpHero3 = new Bitmap(Assets.getBitmapData("img/hero3.png"));
			bmpHero1.x = 230; 
			bmpHero1.y = 115;
			bmpHero2.x = 350; 
			bmpHero2.y = 120;
			bmpHero3.x = 490; 
			bmpHero3.y = 120;
			
			voteRect = new Sprite();
			voteRect.graphics.beginFill(0xff0000);
			voteRect.graphics.drawRect(230, 110, 120, 120);
			voteRect.graphics.endFill();
			addChild(voteRect);
			
			addChild(bmpHero1);
			addChild(bmpHero2);
			addChild(bmpHero3);
			
			/* for first vote */
			votedHero = 1;
			changeHero(votedHero);
		}
		screenText.autoSize = TextFieldAutoSize.CENTER;
		screenText.textColor = 0xffffff;
		screenText.x = 330;
		screenText.y = 230;
		addChild(screenText);
	}
	
	public function changeHero(votedHero:Int) {
		if (votedHero == 1) {
			voteRect.graphics.clear();
			voteRect.graphics.beginFill(0xff0000);
			voteRect.graphics.drawRect(230, 110, 120, 120);
			voteRect.graphics.endFill();
			Main.heroBmp = this.bmpHero1;
		} else if (votedHero == 2) {
			voteRect.graphics.clear();
			voteRect.graphics.beginFill(0xff0000);
			voteRect.graphics.drawRect(353, 110, 120, 120);
			voteRect.graphics.endFill();
			Main.heroBmp = this.bmpHero2;
		} else if (votedHero == 3) {
			voteRect.graphics.clear();
			voteRect.graphics.beginFill(0xff0000);
			voteRect.graphics.drawRect(480, 110, 120, 120);
			voteRect.graphics.endFill();
			Main.heroBmp = this.bmpHero3;
		}
		
	}
	
}