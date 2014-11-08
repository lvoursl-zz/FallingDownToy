package ;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.text.TextField;

/**
 * ...
 * @author lvoursl 
 */
class Game extends Sprite
{
	var hero:Hero;
	
	var obstruction:Obstruction;
	var arrayOfObstruction:Array<Obstruction> = [];
	
	var wall:Wall;
	var arrayOfWalls:Array<Wall> = [];
	
	var random:Int;
	var speed:Int = 4;
	var frame:Int = 0;
	var scoreTable:TextField;
	
	public function new() 
	{
		super();
		frame = 0;
		createHero();
		createWalls();
		createScoreTable();
		addEventListener(Event.ENTER_FRAME, onFrame);
	}
	
	
	public function createHero() {
		hero = new Hero(360, 20);
		addChild(hero.bmp);
	}
	
	public function createWalls() {
		var x:Int = 0;
		var y:Int = 1;
		
		graphics.beginFill(0xa8b8c6);
		graphics.drawRect(0, 0, 800, 480);
		graphics.endFill();
		
		for (i in 0 ... 16) {
			if (i < 4) { 
				x = 0;
				y = 122 * i;
		    } else if ((i >= 4) && (i < 8)) {
				x = 89;
				y = 122 * (i - 4);
			} else if ((i >= 8) && (i < 12)) {
				x = 622;
				y = 122 * (i - 8);
			} else if ((i >= 12) && (i < 16)) {
				x = 711;
				y = 122 * (i - 12);
			}
			wall = new Wall(x, y);
			arrayOfWalls.push(wall);
			addChild(wall.bmp);
		}
	}
	
	public function createScoreTable() {
		scoreTable = new TextField();
		scoreTable.text = "Score :" + frame;
		scoreTable.x = 180;
		scoreTable.y = 20;
		addChild(scoreTable);
	}
	
	public function onFrame(e:Event) {
		frame++;
		scoreTable.text = "Score :" + frame;
		
		if ((frame % 50) == 0) createObstruction();
		if ((frame % 300) == 0) speed++;
		
		moveHero();
		moveWall();
		moveObstruction();
	}
	
	public function moveHero() {
		if (Main.keys[37]) {
			hero.x -= 7;
		} else if (Main.keys[39]) {
			hero.x += 7;
		} 
		
		if (hero.x > 562) {
			hero.x = 562; 
		} else if (hero.x < 178) {
			hero.x = 178;
		}
		hero.bmp.x = hero.x;
		for (oneObstruction in arrayOfObstruction) {
			if (hero.bmp.hitTestObject(oneObstruction.bmp)) { 
				Main.score = frame;
				frame = 0;
				if (Main.score > Main.bestScore) {
					Main.bestScore = Main.score;
				}
				dispatchEvent(new Event("gameover")); 
			}
		}

	}
	
	public function moveWall() {
		for (oneWall in arrayOfWalls) {
			oneWall.y -= speed;
			oneWall.bmp.y = oneWall.y;
			if (oneWall.y < -222) {
				removeChild(oneWall.bmp);
				arrayOfWalls.remove(oneWall);
			} 		
			if (arrayOfWalls[arrayOfWalls.length - 1].y <= 370) {
				/* shit method */
				wall = new Wall(0, 480);
				arrayOfWalls.push(wall);
				addChild(wall.bmp);
				wall = new Wall(89, 480);
				arrayOfWalls.push(wall);
				addChild(wall.bmp);
				wall = new Wall(622, 480);
				arrayOfWalls.push(wall);
				addChild(wall.bmp);
				wall = new Wall(711, 480);
				arrayOfWalls.push(wall);
				addChild(wall.bmp);
			}
		}
	}
	
	public function createObstruction() {
		random = Math.round(Std.random(410) + 160);
		obstruction = new Obstruction(random, 420);
		arrayOfObstruction.push(obstruction);
		addChild(obstruction.bmp);
	}
	
	public function moveObstruction() {
		for (oneObstruction in arrayOfObstruction) {
			oneObstruction.y -= speed;
			oneObstruction.bmp.y = oneObstruction.y;
			if (oneObstruction.y < -5) {
				arrayOfObstruction.remove(oneObstruction);
				removeChild(oneObstruction.bmp);
			}
		}
	}
	
}