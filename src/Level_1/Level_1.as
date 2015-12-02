package Level_1{
	import flash.events.TimerEvent;
	import flash.filesystem.File;
	import flash.utils.Timer;
	
	import Common.Entity;
	import Common.Screen;
	import Main.View;
	import Menu.Menu;
	import Player.Player;
	import VirusScreen.VirusScreen;
	import Viruses.HIV;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.utils.AssetManager;
	import starling.utils.Color;


	public class Level_1 extends Sprite implements Screen{
		private var assetManager:AssetManager;
		private var background:Image;
		private var coinIcon:Image;
		private var jumpScreen:Image;
		private var winImage:Image;
		//to be removed
		private var shownLife:int = 5;
		private var time:int;
		private var coinText:TextField;
		private var lifeText:TextField;
		private var timeText:TextField;
		private var timeCounterText:TextField;
		private var loaded:Boolean = false;
		private var progress:Quad;
		private var middle:Quad;
		private var left:Quad;
		private var right:Quad;
		private var backButton:Button;
		private var entities:Array = new Array();
		private var hearts:Array = new Array();
		private var timer:flash.utils.Timer;
		private var player:Player = new Player();
		
		//Changeable variables
		private var widthOfLevelInPixels:int = 2528;
		private var speed:int = 2;
		
		public function Level_1(){
			addEventListener(Event.ADDED_TO_STAGE, Initialize);
		}
		
		private function Initialize():void{
			assetManager = new AssetManager();
			var folder:File = File.applicationDirectory.resolvePath("Level_1/assets");
			assetManager.enqueue(folder);
			assetManager.loadQueue(Progress);
		}
		
		private function Progress(ratio:Number):void{
			if(ratio == 1){
				Start();
			}
		}
		
		private function Start():void{
			timer = new flash.utils.Timer(3500, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, Continue);
			
			background = new Image(assetManager.getTexture("background"));
			entities.push(background);
			addChild(background);
			
			coinIcon = new Image(assetManager.getTexture("coin"));
			coinIcon.x = 460;
			coinIcon.y = 7;
			addChild(coinIcon);
			
			backButton = new Button(assetManager.getTexture("button_back"));
			backButton.addEventListener(Event.TRIGGERED, BackButtonTriggered);
			backButton.x = 370;
			backButton.y = 265;
			addChild(backButton);	
			
			coinText = new TextField(35, 25, "0 x");
			coinText.color = 0xFFFFFF;
			coinText.x = 428;
			coinText.y = 4;
			addChild(coinText);
			
			lifeText = new TextField(35, 25, "Life:");
			lifeText.color = 0xFFFFFF;
			lifeText.x = 5;
			lifeText.y = 283;
			addChild(lifeText);
			
			timeText = new TextField(45, 25, "Time:");
			timeText.color = 0xFFFFFF;
			timeText.x = 5;
			timeText.y = 5;
			addChild(timeText);
			
			timeCounterText = new TextField(30, 20, time.toString(10));
			timeCounterText.color = 0xFFFFFF;
			timeCounterText.x = 42;
			timeCounterText.y = 7;
			addChild(timeCounterText);

			middle = new Quad(100 ,2 ,Color.WHITE);
			middle.x = 250;
			middle.y = 292;
			addChild(middle);
			
			left = new Quad(2 ,9 ,Color.WHITE);
			left.x = 250;
			left.y = 288;
			addChild(left);
			
			right = new Quad(2 ,9 ,Color.WHITE);
			right.x = 350;
			right.y = 288;
			addChild(right);
			
			progress = new Quad(2 ,9 ,Color.WHITE);
			progress.x = 250;
			progress.y = 288;
			addChild(progress);
			
			AddEntities();
			
			jumpScreen = new Image(assetManager.getTexture("transparent"));
			jumpScreen.addEventListener(TouchEvent.TOUCH, Jump);
			jumpScreen.x = 0;
			jumpScreen.y = 30;
			addChild(jumpScreen);
			
			loaded = true;
		}
		
		/**
		 * This is where all the entites specific for the level is added.
		 */
		private function AddEntities():void{
			var hiv:HIV  = new HIV();
			hiv.x = 500;
			hiv.y = 215;
			entities.push(hiv);
			addChild(hiv);
			
			player.x = 100;
			player.y = 205;
			addChild(player);			
		}
		
		/**
		 * checks the shownLife variable, and updates the number of hearts in the bottom left accordingly.
		 */
		private function UpdateHearts():void{
			while(player.getLife() > hearts.length){
				var heart:Image = new Image(assetManager.getTexture("heart"));
				heart.x = 45 + (hearts.length*22);
				heart.y = 285;
				hearts.push(heart);
				addChild(heart);
			}
			while(player.getLife() < hearts.length){
				removeChild(hearts.pop());
			}
		}
		
		/**
		 * Will be called when the transparentScreen is clicked.
		 */
		private function Jump(event:TouchEvent):void{
			if(event.getTouch(this, TouchPhase.BEGAN)){

			}
		}
		
		/**
		 * Called when the exitButton is pushed.
		 */
		private function BackButtonTriggered():void{
			View.GetInstance().LoadScreen(Menu);
		}
		
		/**
		 * Timer function, set to 24 fps.
		 */
		private function Timer():void{
			time++;
			var timeString:int = time/24;
			timeCounterText.text = timeString.toString(10);
		}
		
		/**
		 * Moves the middle line to indicate progress.
		 */
		private function ProgressBar():void{
			if(progress.x < 350){
				progress.x += (speed/((widthOfLevelInPixels-480)/100));
			}
			if(progress.x >= 326){
				winImage = new Image(assetManager.getTexture("Level1FinalStage"));
				winImage.x = 480;
				winImage.y = 0;
				entities.push(winImage);
				addChildAt(winImage, 1);
			}
			if(progress.x >= 350){
				timer.start();			
			}
		}
		
		/**
		 * Changes the x coordinate of the entites so they all move, it uses the variable speed decide how many pixels to move.
		 * To change the speed of the level change the speed variable in the top.
		 */
		private function MoveEntities():void{
			if(progress.x < 350){
				for(var i:int = 0; i < entities.length; i++){
					entities[i].x -= speed;
				}
			}
		}
		
		/**
		 * Updates the screen.
		 */
		public function Update():void{
			if(loaded){
				Timer();
				ProgressBar();
				MoveEntities();
				UpdateHearts();
				RemoveOutOfStageEntities();
			}
		}
		
		/**
		 * Deleting the Entites when it leaves the screen.
		 * If it is an Entity call Destroy().
		 */
		private function RemoveOutOfStageEntities():void{
			for(var i:int = 0; i < entities.length; i++){
				if(entities[i].x < (0 - entities[i].width)){
					removeChild(entities[i]);
					
					if(entities[i] is Entity){
						entities[i].Destroy();
					}
				}
			}
		}
		
		private function Continue(event:TimerEvent):void{
			View.GetInstance().LoadScreen(VirusScreen);
		}

		/**
		 * Called when the screen is changed.
		 */
		public function Destroy():void{
			backButton.removeEventListener(Event.TRIGGERED, BackButtonTriggered);
			timer.removeEventListener(TimerEvent.TIMER_COMPLETE, Continue);
			jumpScreen.removeEventListener(TouchEvent.TOUCH, Jump);
			removeEventListener(Event.ADDED_TO_STAGE, Initialize);
			assetManager.dispose();
			/** player destroy **/
		}
	}
}