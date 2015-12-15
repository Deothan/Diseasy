package Viruses{

		import flash.filesystem.File;
		import flash.text.ReturnKeyLabel;
		
		import Common.Entity;
		import Common.Virus;
		
		import Main.View;
		
		import starling.display.Image;
		import starling.display.Sprite;
		import starling.events.Event;
		import starling.utils.AssetManager;
		
		public class NeonatalSepsis extends Sprite implements Entity, Virus{
			private var destroyed:Boolean = false;
			private var assetManager:AssetManager;
			private var bacteriaImage:Image;
			
			//Constructor that start the initialze function when this is added to the stage
			public function NeonatalSepsis() {
				addEventListener(Event.ADDED_TO_STAGE, Initialize);
			}
			
			//If added to the stage load the assetmanager and call function progress
			private function Initialize():void{
				assetManager = new AssetManager();
				var folder:File = File.applicationDirectory.resolvePath("Viruses/assets");
				assetManager.enqueue(folder);
				assetManager.loadQueue(Progress);
			}
			
			//Functions that checks whether the assetmanager is done loading, if so continue
			private function Progress(ratio:Number):void{
				if(ratio == 1){
					Start();
				}
			}
			
			//If assetmanager is loaded, get the texture set its size and add it to the stage
			private function Start():void{
				bacteriaImage = new Image(assetManager.getTexture("NeonatalSepsis"));
				bacteriaImage.width = 40; // to be removed later
				bacteriaImage.height = 40; // to be removed later
				addChild(bacteriaImage);
			}
			
			//Function to remove the listener and assetmanager of this object, 
			public function Destroy():void{
				removeEventListener(Event.ADDED_TO_STAGE, Initialize);
				removeChild(bacteriaImage);
				assetManager.dispose();
				destroyed = true;
			}
			
			public function Destroyed():Boolean{
				return destroyed;
			}
			
			public function getWidth():int{
				return this.width;
			}
			
			public function getHeight():int{
				return this.height;
			}
			
			public function Encounter():void{
				Destroy();
				View.GetInstance().GetInfant().setHealth(-2);
				View.GetInstance().GetInfant().setHygiene(-4);
				View.GetInstance().GetPlayer().loseLife();
			}
		}
	}
