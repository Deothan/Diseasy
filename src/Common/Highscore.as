package Common{
	/** import external libraries **/
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
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
	public class Highscore{
		/** Highscore in memory **/
		private var records:Array;
		/** FileWriter**/
		private var stream:FileStream;
		/** File location **/
		private var _file:File;
		
		
		public function Highscore(){
			records = new Array();
			Load();
		}
		
		/** method to read array from disk to memory **/
		private function Load():void{
			var pathToDestination:String = File.applicationStorageDirectory.resolvePath('Storage/highscore.save').nativePath;
			var _file:File = new File(pathToDestination);
			if(!_file.exists){
				for(var pointer:int = 0; pointer < 25; pointer++){
					records.push("null");
					trace('file does not exist');
				}
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
			var pathToFile:String = File.applicationStorageDirectory.resolvePath('Storage/highscoreShadowCopy.save').nativePath;
			var pathToDestination:String = File.applicationStorageDirectory.resolvePath('Storage/highscore.save').nativePath;
			
			var sourceFile:File = new File(pathToFile);
			var destinationFile:File = new File(pathToDestination); 
			
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
		public function HighscoreCheck(level:int , playername:String, time:Number):void{
			var tmp:Array = new Array();
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
	}
}