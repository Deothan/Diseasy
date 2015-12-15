
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
	 */
	public class IO{
		/** singleton instance**/
		private static var instance:IO;
		
		/** Array holding information on disk **/
		private static var profiles:Array;
		private static var profileNames:Array;
		private var playerPointer:int;
		
		/** FileWriter**/
		private var stream:FileStream;
		/** File location **/
		private var _file:File;
		
		/** constant variables 
		 * SIZEOFPROFILE needs to be adjusted every time new data is added in a sprint 
		 **/
		private const SIZEOFPROFILE:int = 9;
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
			//appendProfile(); 
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
			View.GetInstance().GetPlayer().SetCheckedViruses(fobar);
			
			var playerUnlocked:String =profiles[(loop +5)];
			tmp = playerUnlocked.split(":");
			fobar = tmp[1].split(",");
			if(fobar[1].search("true") >= 0){
				View.GetInstance().GetPlayer().setLevel(2, true);	
			}
			if(fobar[2].search("true") >= 0){
				View.GetInstance().GetPlayer().setLevel(3, true);	
			}
			if(fobar[3].search("true") >= 0){
				View.GetInstance().GetPlayer().setLevel(4, true );	
			}
			if(fobar[4].search("true") >= 0){
				View.GetInstance().GetPlayer().setLevel(5, true );	
			}
			
			var playerItems:String =profiles[(loop +6)];
			tmp = playerItems.split(":");
			fobar = tmp[1].split(",");
			trace(fobar);
			View.GetInstance().GetPlayer().setItems(fobar);
			playerPointer = (loop -1);
		}
		
		/**
		 * method to save current progress to disk
		 * makes a shadow copy and replaces the origin since partial change is not available in current language
		 */
		public function Save():void{
			var pathToFile:String = File.applicationDirectory.resolvePath('Storage/memoryShadowCopy.save').nativePath;
			var pathToDestination:String = File.applicationDirectory.resolvePath('Storage/memory.save').nativePath;
			var currentUser:Array = addProfile();
			var foo:int = 0;
			
			_file = new File(pathToFile);
			
			//first time use
			if(!_file.exists){
				stream.open(_file, FileMode.WRITE);
				stream.writeUTFBytes("");
				stream.close();	
			}
			
			stream.open(_file, FileMode.WRITE);
			for (var i:int = 0; i < profiles.length; i++){
				/**
				 * if pointer in array holding all users information = playerPointer set in load and user is loaded not created.
				 * write current progress rather then array
				 **/
				if(i >= playerPointer && i<= (playerPointer + SIZEOFRECORDS) && playerPointer != 0){
					stream.writeUTFBytes(currentUser[foo]);
					foo++;
				}
				/**
				 * but if no pointer is found (i.e.: user is created) do write other profiles
				 */
				else if(profiles.length != 0){
					if(i < (profiles.length - 1)){
						stream.writeUTFBytes(profiles[i] + "\r\n");	
					}
				}
			}
			/**
			 * then finish with created profile but only if created
			 */
			if(playerPointer ==0){
				for(var j:int=0; j < currentUser.length; j++){
					stream.writeUTFBytes(currentUser[j]);	
				}
				
			}
			stream.close();
			
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
		 * Varify if file already exists or is first time use
		 */
		private function CheckMemory():void{
			var FolderToFile:String = File.applicationDirectory.resolvePath('Storage').nativePath;
			var pathToFile:String = File.applicationDirectory.resolvePath('Storage/memory.save').nativePath;
			
			var Folder:File = new File(FolderToFile);
			
			if(!Folder.exists){
				Folder.createDirectory();
			}
			_file = new File(pathToFile);
			
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
			var foo:Array = new Array();
			
			foo[0] = "<PROFILE>\r\n";
			foo[1] = "NAME:" + name + "\r\n";
			foo[2] = "LIFE:" + life + "\r\n";
			foo[3] = "COINS:" + coins + "\r\n";
			foo[4] = "LOOKS:" + looks + "\r\n";
			foo[5] = "VIRUSSES:" + virusses[0] + "," + virusses[1] + "," + virusses[2] + "," +  virusses[3] + "," + virusses[4] +  "\r\n";
			foo[6] = "LEVELS:" + unlock[0] + "," + unlock[1] + "," + unlock[2] + "," +  unlock[3] + "," + unlock[4] +"\r\n";
			foo[7] = "ITEMS:" + items[0] + "," + items[1] + "," + items[2] + "," + items[3]+ "\r\n";
			foo[8] = "</PROFILE>\r\n";
			
			return foo;
		}
	}
}
