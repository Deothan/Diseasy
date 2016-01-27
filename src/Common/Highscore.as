package Common{
	/** import external libraries **/
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.text.TextFormat;
	
	import Main.View;
	
	import VirusScreen.VirusScreen;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.AssetManager;
	
	/**
	 * Class to record/show highscores.
	 * 
	 * HOW TO USE (SET automaticly checkes whether a score needs to be added and saved): 
	 * SET HIGHSCORE: IO.GetInstance().getHighscoreInstance().HighscoreCheck(LEVEL,NAME,SCORE);
	 * GET HIGHSCORE: var result:Array = IO.GetInstance().getHighscoreInstance().getLevelHighScore(LEVEL);
	 * 
	 * Uses ((level - 1)* 5) + position + position to record to disk
	 * where 5 = the number of score being kept per level
	 * I.E; LVL1->POSITION1 = 1;
	 * I.E; LVL2->POSITION5 = 10;
	 * I.E; LVL3->POSITION1 = 11;
	 * 
	 * Storage location(C:\Users\'username'\AppData\Roaming\Diseasy.debug\Local Store\Storage)
	 */
	public class Highscore extends Sprite implements Screen{
		
		[Embed(source   = 'assets/DISEASY.TTF'
		    ,fontFamily     ='Diseasy'
		    ,fontStyle      = 'normal'  // normal|italic
		    ,fontWeight     = 'normal'  // normal|bold
		    ,mimeType       = "application/x-font-truetype"
		    ,unicodeRange   = 'U+0020-U+002F,U+0030-U+0039,U+003A-U+0040,U+0041-U+005A,U+005B-U+0060,U+0061-U+007A,U+007B-U+007E'
		    ,embedAsCFF     = 'false'
		    )]
		private const _regular:Class;
		public static const name:String = "Diseasy";
		
		/** Highscore in memory **/
		private var records:Array;
		/** FileWriter**/
		private var stream:FileStream;
		/** File location **/
		private var _file:File;
		/** Assets **/
		private var assetManager:AssetManager;
		private var continueButton:Button;
		
		public function Highscore(){
			records = new Array();
			Load();
			HighscoreCheck();
			this.addEventListener(Event.ADDED_TO_STAGE, Initialize);
		}
		
		private function Initialize():void{
			assetManager = new AssetManager();
			var folder:File = File.applicationDirectory.resolvePath("Common/assets");
			assetManager.enqueue(folder);
			assetManager.loadQueue(Render);
		}
		
		private function Render(ratio:Number):void{
			if(ratio == 1){
				draw();
			}
		}
		
		private function draw():void{
			var background:Image = new Image(assetManager.getTexture('backgroundscore'));
			addChild(background);
			
			continueButton = new Button(assetManager.getTexture('button_ok'));
			continueButton.x = 340;
			continueButton.y = 250;
			addChild(continueButton);
			continueButton.addEventListener(Event.TRIGGERED, Continue);
			
			var PersonalBest:Image = new Image(assetManager.getTexture('First'));
			var width:int = PersonalBest.width /= 2.3;
			var height:int = PersonalBest.height /= 1.5;
			PersonalBest.x = 255;
			PersonalBest.y = 80;
			addChild(PersonalBest);
			
			var PersonalBestText:TextField 	= new TextField(width, height, ""+View.GetInstance().GetPlayer().getHighscore()[View.GetInstance().getCurrentLevel() -1], "Diseasy", 20);
			PersonalBestText.autoScale = true;
			PersonalBestText.x = 255;
			PersonalBestText.y = 85;
			addChild(PersonalBestText);
			
			var First:Image  = new Image(assetManager.getTexture('First'));
			First.width /= 2.3;
			First.height /= 1.5;
			First.x = 45;
			First.y = 80;
			addChild(First);
			
			var FirstText:TextField = new TextField(width, height, ""+getLevelHighScore(View.GetInstance().getCurrentLevel())[0], "Diseasy", 20);
			FirstText.autoScale = true;
			FirstText.x = 45;
			FirstText.y = 85;
			addChild(FirstText);
			
			var Second:Image  = new Image(assetManager.getTexture('Second'));
			Second.width /= 2.3;
			Second.height /= 1.5;
			Second.x = 45;
			Second.y = 130;
			addChild(Second);
			
			var SecondText:TextField = new TextField(width, height, ""+getLevelHighScore(View.GetInstance().getCurrentLevel())[1], "Diseasy", 20);
			SecondText.autoScale = true;
			SecondText.x = 45;
			SecondText.y = 128;
			addChild(SecondText);
			
			var Third:Image  = new Image(assetManager.getTexture('Third'));
			Third.width /= 2.3;
			Third.height /= 1.5;
			Third.x = 45;
			Third.y = 180;
			addChild(Third);
			
			var ThirdText:TextField = new TextField(width, height, ""+getLevelHighScore(View.GetInstance().getCurrentLevel())[2], "Diseasy", 20);
			ThirdText.autoScale = true;
			ThirdText.x = 45;
			ThirdText.y = 178;
			addChild(ThirdText);
			
			var Fourth:Image  = new Image(assetManager.getTexture('RestScores'));
			Fourth.width /= 2.3;
			Fourth.height /= 1.5;
			Fourth.x = 45;
			Fourth.y = 230;
			addChild(Fourth);
			
			var FourthText:TextField = new TextField(width, height, ""+getLevelHighScore(View.GetInstance().getCurrentLevel())[3], "Diseasy", 20);
			FourthText.autoScale = true;
			FourthText.x = 45;
			FourthText.y = 228;
			addChild(FourthText);
			
			var Fifth:Image  = new Image(assetManager.getTexture('RestScores'));
			Fifth.width /= 2.3;
			Fifth.height /= 1.5;
			Fifth.x = 45;
			Fifth.y = 280;
			addChild(Fifth);
			
			var FifthText:TextField = new TextField(width, height, ""+getLevelHighScore(View.GetInstance().getCurrentLevel())[4], "Diseasy", 20);
			FifthText.autoScale = true;
			FifthText.x = 45;
			FifthText.y = 278;
			addChild(FifthText);
		}
		
		private function Continue():void{
			View.GetInstance().LoadScreen(VirusScreen);
		}
		
		/** method to read array from disk to memory **/
		private function Load():void{
			var _dir:File = File.userDirectory.resolvePath("DISEASY");
			var _file:File = File.userDirectory.resolvePath("DISEASY/highscore.save");
			if(!_dir.exists){
				_dir.createDirectory();
			}
			if(!_file.exists){
				for(var pointer:int = 0; pointer < 25; pointer++){
					records.push("null");
				}
				trace('file does not exist');
			}
			else{
				var stream:FileStream = new FileStream();
				stream.open(_file, FileMode.READ);
				var foo:String = stream.readUTFBytes(stream.bytesAvailable);
				stream.close();
				records = foo.split("\r\n");
			}
		}
		
		/** method to write array from memory to disk **/
		private function Save():void{
			var stream:FileStream = new FileStream();
			
			var sourceFile:File = File.userDirectory.resolvePath("DISEASY/highscoreShadowCopy.save");
			var destinationFile:File = File.userDirectory.resolvePath("DISEASY/highscore.save");
			
			if(!sourceFile.exists){
				stream.open(sourceFile, FileMode.WRITE);
				stream.writeUTFBytes("");
				stream.close();	
			}
			
			if(!destinationFile.exists){
				stream.open(destinationFile, FileMode.WRITE);
				stream.writeUTFBytes("");
				stream.close();	
			}
			
			stream.open(sourceFile, FileMode.WRITE);
			for(var pointer:int = 0; pointer < records.length; pointer++){
				stream.writeUTFBytes(records[pointer] + "\r\n");
			}
			stream.close();
			
			/**
			 * replace shadowcopy with origin
			 */
			try {
				sourceFile.moveTo(destinationFile, true);
			}
			catch (error:Error){
				trace(error.message);
				trace("[IO] Cannot replace save file. Contact HelpHeal" + error.message);
			}
		}
		
		/**
		 * Method to retrieve the high score list from memory.
		 * @param: level; the level from which to retrieve
		 * @return: the 5 highscores
		 */
		public function getLevelHighScore(level:int):Array{
			var tmp:Array = new Array();
			tmp[0] = records[((level - 1)*5)];
			tmp[1] = records[((level - 1)*5) + 1];
			tmp[2] = records[((level - 1)*5) + 2];
			tmp[3] = records[((level - 1)*5) + 3];
			tmp[4] = records[((level - 1)*5) + 4];
			return tmp;
		}
		
		/** method to check if a score is worthy of highscore
		 * if score is worthy replace value and save
		 */
		private function HighscoreCheck():void{
			var tmp:Array = new Array();
			
			var level:int = View.GetInstance().getCurrentLevel();
			var playername:String = View.GetInstance().GetPlayer().GetName();
			var time:int = Math.ceil(View.GetInstance().GetTime() /24);
			
			
			tmp[0] = records[((level - 1)*5)];
			tmp[1] = records[((level - 1)*5) + 1];
			tmp[2] = records[((level - 1)*5) + 2];
			tmp[3] = records[((level - 1)*5) + 3];
			tmp[4] = records[((level - 1)*5) + 4];
				
			for(var loop:int = 0; loop < tmp.length; loop++){
				if(tmp[loop] != 'null'){
					var splitRecord:Array = new Array();
					splitRecord = tmp[loop].split(":");
				}
				if(tmp[loop] == 'null'){
					tmp[loop] = "" + playername +":" + time;
					break;
				}	
				else if(time < splitRecord[1]){
					tmp.splice(loop, 0,  "" + playername +":" + time);
					//records[((level - 1)*5) + loop] = "" + playername +":" + time;
					break;
				}
			}
			records[((level - 1)*5)] = tmp[0].toString();
			records[((level - 1)*5) +1] = tmp[1].toString();
			records[((level - 1)*5) +2] = tmp[2].toString();
			records[((level - 1)*5) +3] = tmp[3].toString();
			records[((level - 1)*5) +4] = tmp[4].toString();
			Save();
		}
		
		public function Update():void{
			
		}
		
		public function Destroy() :void{
			removeEventListeners(null);
			assetManager.dispose();
		}
	}
}