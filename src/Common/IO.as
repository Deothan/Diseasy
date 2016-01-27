
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
		
		/**
		 * method to get the available save games
		 * @return: Array, an array with the names to choose from
		 */
		public function getNames():Array{
			var bar:Array = new Array();
			for(var i:int = 0; i< profileNames.length; i++){
				if(profileNames[i].name == 'highscore.save');
				else bar.push(profileNames[i].name);
			}
			return bar;
		}
		
		/**
		 * method to save current progress to disk
		 * makes a shadow copy and replaces the origin since partial change is not available in current language
		 */
		public function Save():void{
			var destinationFolder:File = File.userDirectory.resolvePath("DISEASY");
			var destinationFolderName:File = File.userDirectory.resolvePath("DISEASY/"+ View.GetInstance().GetPlayer().GetName());
			var SaveFile:File = File.userDirectory.resolvePath("DISEASY/"+ View.GetInstance().GetPlayer().GetName() + "/" + "profile.save");
			var SaveFileShadowCopy:File = File.userDirectory.resolvePath("DISEASY/"+ View.GetInstance().GetPlayer().GetName() + "/" + "shadowcopy.save");
			if(!destinationFolder.exists) destinationFolder.createDirectory();
			if(!destinationFolderName.exists) destinationFolderName.createDirectory();
			if(!SaveFile.exists){
				stream.open(SaveFile, FileMode.WRITE);
				stream.writeUTFBytes('');
				stream.close();
			}
			stream.open(SaveFileShadowCopy , FileMode.WRITE);
			stream.writeUTFBytes('' + View.GetInstance().GetPlayer().getLife() + '\r\n'); //life
			stream.writeUTFBytes('' + View.GetInstance().GetPlayer().getCoins() + '\r\n'); //coins
			if(writeArray(View.GetInstance().GetPlayer().getUnlock()))  stream.writeUTFBytes('null' + '\r\n'); //unlocked levels 
			stream.writeUTFBytes('' + View.GetInstance().GetPlayer().GetLooks() + '\r\n'); //looks
			if(writeArray(View.GetInstance().GetPlayer().getItems()))  stream.writeUTFBytes('null' + '\r\n'); //items
			if(writeArray(View.GetInstance().GetPlayer().GetCheckedViruses()))  stream.writeUTFBytes('null' + '\r\n'); //virus
			if(writeArray(View.GetInstance().GetPlayer().GetTutorials()))  stream.writeUTFBytes('null' + '\r\n');//tutorials
			if(writeArray(View.GetInstance().GetPlayer().getHighscore()))  stream.writeUTFBytes('null' + '\r\n');
			stream.close();
			
			try {
				SaveFileShadowCopy.moveTo(SaveFile, true);
			}
			catch (error:Error){
				trace("[IO] Cannot replace save file. Contact HelpHeal" + error.message);
			}
			
				function writeArray(_array:Array):Boolean{
					if(_array == null || _array.length == 0) return true;
					for(var pointer:int = 0; pointer < _array.length; pointer++){
						if(pointer == _array.length - 1) stream.writeUTFBytes(_array[pointer] + '\r\n');
						else stream.writeUTFBytes(_array[pointer] + ',');
					}
					return false;
				}
		}
		
		public function loadUserProfile(_profileName:String):void{
			var targetFolder:File = File.userDirectory.resolvePath("DISEASY/"+_profileName+"/profile.save");
			var userProfileArray:Array = new Array;
			
			stream.open(targetFolder, FileMode.READ);
			userProfileArray = stream.readUTFBytes(stream.bytesAvailable).split('\r\n');
			stream.close();
			View.GetInstance().GetPlayer().SetName(_profileName);
			View.GetInstance().GetPlayer().setLife(userProfileArray[0]);//life
			View.GetInstance().GetPlayer().setCoin(userProfileArray[1]);//coins
			
			/** strange bug, therefor manual overwrite **/
			var foo:Array = userProfileArray[2].split(',');
			writeLevels(foo);
			
			View.GetInstance().GetPlayer().SetLooks(userProfileArray[3]); //looks
			View.GetInstance().GetPlayer().setItems(userProfileArray[4].split(',')); //items
			View.GetInstance().GetPlayer().SetCheckedViruses(userProfileArray[5].split(','));//virus
			View.GetInstance().GetPlayer().overWriteSetTutorials(userProfileArray[6].split(','));//tutorials
			View.GetInstance().GetPlayer().overWriteSetHighscore(userProfileArray[7].split(','));//highscores
		}
		
		private function writeLevels(foo:Array):void{
			for(var k:int = 0; k < foo.length; k++){
				if(foo[k] == "true")
					View.GetInstance().GetPlayer().setLevel(k+1, true);
				else
					View.GetInstance().GetPlayer().setLevel(k+1, false);
			}
		}
		
		/**
		 * method to seperate names from profiles data
		 * @return names, an array holding the profile names
		 */
		private function loadNames():Array{
			var userNames:Array = new Array();
			var targetFolder:File = File.userDirectory.resolvePath("DISEASY");
			userNames = targetFolder.getDirectoryListing();
			return userNames;
		}
	}
}