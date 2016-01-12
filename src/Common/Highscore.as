package Common{
	/** import external libraries **/
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	/**
	 * Class to record/show highscores.
	 * Uses (level* 5) + position to record to disk
	 * Starts at lv0
	 * I.E; LVL0->POSITION1 = 1;
	 * I.E; LVL2->POSITION5 = 15;
	 * I.E; LVL3->POSITION1 = 16;
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
					records.push(null);
				}
			}
			else{
				stream.open(_file, FileMode.READ);
				var foo:String = stream.readUTFBytes(stream.bytesAvailable);
				stream.close();
				records = foo.split("\r\n");
			}
		}
		
		/** method to write array from memory to disk **/
		public function Save():void{
			var pathToFile:String = File.applicationStorageDirectory.resolvePath('Storage/highscoreShadowCopy.save').nativePath;
			var pathToDestination:String = File.applicationStorageDirectory.resolvePath('Storage/highscore.save').nativePath;
			
			var _file:File = new File(pathToFile);
			if(!_file.exists){
				stream.open(_file, FileMode.WRITE);
				stream.writeUTFBytes("");
				stream.close();	
			}
			
			stream.open(_file, FileMode.WRITE);
			for(var pointer:int = 0; pointer < records.length; pointer++){
				if(records[pointer] == null) stream.writeUTFBytes("\r\n");
				else stream.writeUTFBytes(records[pointer] + "\r\n");
			}
			
			var sourceFile:File = new File(pathToFile);
			var destinationFile:File = new File(pathToDestination);
			
			/**
			 * replace shadowcopy with origin
			 */
			try {
				sourceFile.moveTo(destinationFile, true);
			}
			catch (error:Error){
				trace("[IO] Cannot replace save file. Contact HelpHeal" + error.message);
			}
		}
		
		/**
		 * Method to retrieve the high score list from memory.
		 * @param: level; the level from which to retrieve
		 * @return: the highscores
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
				if(tmp[loop] != null){
					var splitRecord:Array = new Array();
					splitRecord = tmp[loop].split(":");
				}
				if(tmp[loop] == null){
					records[((level - 1)*5) + loop] = "" + playername +":" + time;
					Save();
					return;
				}	
				else if(time < splitRecord[1]){
					records[((level - 1)*5) + loop] = "" + playername +":" + time;
					Save();
					return;
				}
			}
		}
	}
}