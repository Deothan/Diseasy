
package Common
{
	/** import external libraries **/
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import Main.View;
	
	/**
	 * Class file that handles read/write with saving
	 * Singleton class with three functions:
	 * getNames() -> returns available save games
	 * loadUserProfile() -> loads a user profile (needs name from getNames)
	 * Save() -> saves the current loaded profile
	 * Storage location(C:\Users\'username'\AppData\Roaming\Diseasy.debug\Local Store\Storage)
	 */
	public class IO{
		/** singleton instance**/
		private static var instance:IO;
		private var highscore:Highscore = new Highscore();
		
		/** Array holding information on disk **/
		private static var profiles:Array;
		private static var profileNames:Array;
		private var playerPointer:int = -1;
		
		/** FileWriter**/
		private var stream:FileStream;
		/** File location **/
		private var _file:File;
		
		/** constant variables 
		 * SIZEOFPROFILE needs to be adjusted every time new data is added in a sprint 
		 **/
		private const SIZEOFPROFILE:int = 10;
		private const SIZEOFRECORDS:int = SIZEOFPROFILE - 1;
		
		/**
		 * constructor method
		 */
		public function IO(){
			profiles = new Array();
			profileNames = new Array();
			stream = new FileStream();
			CheckMemory();
			loadToMemory();
			profileNames = loadNames();
		}
		
		/**
		 * Singlton method
		 */
		public static function GetInstance():IO{
			if (instance == null){
				instance = new IO();
			}
			return instance;
		}
		
		public function reset():IO{
			return instance = new IO();
			
		}
		
		public function getHighscoreInstance():Highscore{
			return highscore;
		}
		
		/**
		 * method to get the available save games
		 * @return: Array, an array with the names to choose from
		 */
		public function getNames():Array{
			var foo:Array = new Array();
			var bar:Array = new Array();
			for(var i:int = 0; i< profileNames.length; i++){
				foo = profileNames[i].split(":");
				bar[i] = foo[1];
			}
			return bar;
		}
		
		/**
		 * method to load the player profile. multiply pointer * SIZEOFPROFILE
		 * @param param: the name of the character to load
		 */
		public function loadUserProfile(param:String):void{
			trace(param);
			trace(View.GetInstance().GetPlayer().GetName());
			if(param == View.GetInstance().GetPlayer().GetName()) return;
			var pointer:int = 0;
			var loop:int = 0;
			for (var i:int =0; i < profileNames.length; i++){
				var foo:String = profileNames[i];
				if(foo.search("NAME:"+param) >= 0){
					pointer = i;
				}
			}
			
			loop = (pointer * SIZEOFPROFILE) + 1;
			var tmp:Array = new Array();
			var foobar:int;
			var fobar:Array = new Array();
			var fooobar:Array = new Array();
			
			//set person parameters
			View.GetInstance().GetPlayer().SetName(param);
			
			var playerlife:String = profiles[(loop + 1)];
			tmp = playerlife.split(":");
			View.GetInstance().GetPlayer().setLife(tmp[1]);
			
			var playercoins:String = profiles[(loop + 2)];
			tmp = playercoins.split(":");
			View.GetInstance().GetPlayer().setCoin(tmp[1]);
			
			var playerlooks:String = profiles[(loop + 3)];
			tmp = playerlooks.split(":");
			foobar = tmp[1];
			View.GetInstance().GetPlayer().SetLooks(foobar);
			
			var playerVirusses:String =profiles[(loop +4)];
			tmp = playerVirusses.split(":");
			fobar = tmp[1].split(",");
			for(var j:int = 0; j < fobar.length; j++){
				if(fobar[j] == "true")
					fooobar[j] = true;
				else
					fooobar[j] = false;
			}
			View.GetInstance().GetPlayer().SetCheckedViruses(fooobar);
			
			var playerUnlocked:String =profiles[(loop +5)];
			tmp = playerUnlocked.split(":");
			fobar = tmp[1].split(",");
			for(var k:int = 0; k < fobar.length; k++){
				if(fobar[k] == "true")
					View.GetInstance().GetPlayer().setLevel(k+1, true);
				else
					View.GetInstance().GetPlayer().setLevel(k+1, false);
			}
			
			var playerItems:String =profiles[(loop +6)];
			tmp = playerItems.split(":");
			fobar = tmp[1].split(",");
			View.GetInstance().GetPlayer().setItems(fobar);
			
			var playerTutorials:String =profiles[(loop +7)];
			tmp = playerTutorials.split(":");
			fobar = tmp[1].split(",");
			for(var l:int = 0; l < fobar.length; l++){
				if(fobar[l] == "true")
					View.GetInstance().GetPlayer().setTutorials(l, true);
				else
					View.GetInstance().GetPlayer().setTutorials(l, false);   
			}
			
			playerPointer = (loop -1);
		}
		
		public function setNewPlayerPointer():void{
			playerPointer = -1;
		}
		
		public function getPlayerPointer():int{
			return playerPointer;
		}
		
		/**
		 * method to save current progress to disk
		 * makes a shadow copy and replaces the origin since partial change is not available in current language
		 */
		public function Save():void{
			var currentUser:Array = addProfile();
			var foo:int = 0;
			
			_file = File.userDirectory.resolvePath("DISEASY/memoryShadowCopy.save");
			var destinationFile:File = File.userDirectory.resolvePath("DISEASY/memory.save");
			
			//first time use
			if(!_file.exists){
				stream.open(_file, FileMode.WRITE);
				//stream.writeUTFBytes("");
				stream.close();	
			}
			
			stream.open(_file, FileMode.WRITE);
			var flag:Boolean = false;
			for (var i:int = 0; i < profiles.length; i++){
				if(destinationFile.size == 0){
					
				}
				else{
					if(profiles.length < 5){
						stream.writeUTFBytes(profiles[i]  + "\r\n");
					}
					else{
						if(i == (profiles.length - 1)) stream.writeUTFBytes(profiles[i]);
						else stream.writeUTFBytes(profiles[i]  + "\r\n");
					}
				}
			}
			if(playerPointer == -1){
				trace('playerPointer == -1');
				if(destinationFile.size == 0){
					trace('true == 0');
					var tmp:String = currentUser[0].replace("\r\n", "");
					trace(tmp);
					stream.writeUTFBytes(tmp  + "\r\n");
				}
				else {
					trace('false!!');
					stream.writeUTFBytes("\r\n" + currentUser[0]  + "\r\n");
				}
				stream.writeUTFBytes(currentUser[1]  + "\r\n");
				stream.writeUTFBytes(currentUser[2]  + "\r\n");
				stream.writeUTFBytes(currentUser[3]  + "\r\n");
				stream.writeUTFBytes(currentUser[4]  + "\r\n");
				stream.writeUTFBytes(currentUser[5]  + "\r\n");
				stream.writeUTFBytes(currentUser[6]  + "\r\n");
				stream.writeUTFBytes(currentUser[7]  + "\r\n");
				stream.writeUTFBytes(currentUser[8]  + "\r\n");
				stream.writeUTFBytes(currentUser[9]);
			}
			stream.close();
			
			var sourceFile:File = File.userDirectory.resolvePath("DISEASY/memoryShadowCopy.save");
			
			
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
		 * Varify if file already exists or is first time use
		 */
		private function CheckMemory():void{
			trace('[IO/CHECKMEMORY]');	
			var Folder:File = File.userDirectory.resolvePath("DISEASY");
			
			if(!Folder.exists){
				Folder.createDirectory();
			}
			_file = File.userDirectory.resolvePath("DISEASY/memory.save");
			
			if(!_file.exists){
				stream.open(_file, FileMode.WRITE);
				stream.writeUTFBytes("");
				stream.close();	
			}
		}
		
		/**
		 * method to load all profiles into memory.
		 * playerPointer
		 */
		private function loadToMemory():void{
			stream.open(_file, FileMode.READ);
			var foo:String = stream.readUTFBytes(stream.bytesAvailable);
			stream.close();
			profiles = foo.split("\r\n");
		}
		
		/**
		 * method to seperate names from profiles data
		 * @return names, an array holding the profile names
		 */
		private function loadNames():Array{
			var names:Array = new Array();
			var foo:int = 0;
			for (var i:int = 1; i < profiles.length; i+= SIZEOFPROFILE){
				names[foo] = profiles[i];
				foo++;
			}
			return names;
		}
		
		/**
		 * method to concur the current profile to save file
		 * @return: foo, return an array with user data ready to be written to disk
		 */
		private function addProfile():Array{
			var name:String = View.GetInstance().GetPlayer().GetName();
			var life:int = View.GetInstance().GetPlayer().getLife();
			var coins:int = View.GetInstance().GetPlayer().getCoins();
			var looks:int = View.GetInstance().GetPlayer().GetLooks();
			var virusses:Array = View.GetInstance().GetPlayer().GetCheckedViruses();
			var unlock:Array = View.GetInstance().GetPlayer().getUnlock();
			var items:Array = View.GetInstance().GetPlayer().getItems();
			var tutorials:Array = View.GetInstance().GetPlayer().GetTutorials();
			var foo:Array = new Array();
			
			foo[0] = "<PROFILE>";
			foo[1] = "NAME:" + name;
			foo[2] = "LIFE:" + life;
			foo[3] = "COINS:" + coins;
			foo[4] = "LOOKS:" + looks;
			foo[5] = "VIRUSSES:" + virusses[0] + "," + virusses[1] + "," + virusses[2] + "," +  virusses[3] + "," + virusses[4];
			foo[6] = "LEVELS:" + unlock[0] + "," + unlock[1] + "," + unlock[2] + "," +  unlock[3] + "," + unlock[4];
			foo[7] = "ITEMS:" + items[0] + "," + items[1] + "," + items[2] + "," + items[3];
			foo[8] = "TUTORIALS:" + tutorials[0] + "," + tutorials[1] + "," + tutorials[2] + "," + tutorials[3] + "," + tutorials[4] + "," + tutorials[5];
			foo[9] = "</PROFILE>";
			
			return foo;
		}
	}
}