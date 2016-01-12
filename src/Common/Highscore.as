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
		}
		
		/** method to read array from disk to memory **/
		public function loadFromDisk():void{
			
		}
		
		/** method to write array from memory to disk **/
		public function writeToDisk():void{
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
				
			}
		}
	}
}