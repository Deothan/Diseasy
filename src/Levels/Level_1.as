package Levels{
	import flash.events.TimerEvent;
	import flash.filesystem.File;
	import flash.utils.Timer;
	
	import Common.Entity;
	import Common.Highscore;
	import Common.IO;
	import Common.Obstacle;
	import Common.Physicus;
	import Common.Screen;
	import Common.Virus;
	
	import Items.Coin;
	import Items.Heart;
	import Items.Medicine;
	import Items.Towel;
	import Items.Watch;
	
	import Main.View;
	
	import Platforms.Platform;
	
	import Viruses.NeonatalSepsis;
	
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.AssetManager;
	import starling.filters.ColorMatrixFilter;
	
	public class Level_1 extends Sprite implements Screen{
		private var assetManager:AssetManager;
		private var top:TopBar = new TopBar();
		private var bottom:BottomBar = new BottomBar;
		private var jumpLayer:JumpLayer = new JumpLayer();
		private var background1:Image;
		private var background2:Image;
		private var background3:Image;
		private var jumpScreen:Image;
		private var winImage:Image;
		private var loaded:Boolean = false;
		private var playerLoaded:Boolean = false;
		private var timer:flash.utils.Timer;
		private var spawned76:Boolean = false;
		private var spawned57:Boolean = false;
		private var spawned38:Boolean = false;
		private var spawned19:Boolean = false;
		private var spawned0:Boolean = false;
		private var tutorial0:Image;
		private var tutorial1:Image;
		private var tutorial2:Image;
		private var pulseTracker:int = 0;
		private var pulseGoingUp:Boolean = true;
		
		//Changeable variables
		private var pulseSize:int = 15;
		private var widthOfLevelInPixels:int = 6150;
		private var speed:int = View.GetInstance().getSpeed();
		private var spawnTimeInSeconds:int = 18;
		//identifier for shrinking or growing
		private var increasePulse:Boolean = true;
		//timer to switch
		private var pulseCounter:int = 0;
		
		public function Level_1(){
			addEventListener(Event.ADDED_TO_STAGE, Initialize);
		}
		
		private function Initialize():void{
			assetManager = new AssetManager();
			var folder:File = File.applicationDirectory.resolvePath("Levels/assets/level1");
			assetManager.enqueue(folder);
			assetManager.loadQueue(Progress);
		}
		
		private function Progress(ratio:Number):void{
			if(ratio == 1){
				Start();
			}
		}
		
		private function Start():void{
			View.GetInstance().GetPlayer().setLife(5);
			View.GetInstance().SetTime(0);
			View.GetInstance().getSoundControl().playStartGame();
			View.GetInstance().GetInfant().setHealth(100);
			View.GetInstance().GetInfant().setHydration(100);
			View.GetInstance().GetInfant().setHygiene(100);
			View.GetInstance().GetInfant().setTemperature(100);
			
			timer = new flash.utils.Timer(3500, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, Continue);
			
			background1 = new Image(assetManager.getTexture("background"));
			View.GetInstance().AddEntity(background1);
			addChild(background1);
			
			addChild(top);
			
			bottom.SetSpeed(speed);
			bottom.SetWidthOfLevelInPixels(widthOfLevelInPixels);
			addChild(bottom);
			
			addChild(jumpLayer);
			
			if(!View.GetInstance().GetPlayer().GetTutorials()[2]){
				tutorial0 = new Image(assetManager.getTexture("gradient"));
				addChild(tutorial0);
				
				tutorial1 = new Image(assetManager.getTexture("cutscene_platform1"));
				tutorial1.addEventListener(TouchEvent.TOUCH, TutorialTouch);
				addChild(tutorial1);
			}
			else{
				AddEntities();
				View.GetInstance().GetPlayer().Run();
				
				loaded = true;
			}
		}
		
		private function TutorialTouch(event:TouchEvent):void{
			if(event.getTouch(this, TouchPhase.BEGAN)){
				View.GetInstance().getSoundControl().playButton();
				if(event.target == tutorial1){
					tutorial1.removeEventListener(TouchEvent.TOUCH, TutorialTouch);
					removeChild(tutorial1);
					tutorial2 = new Image(assetManager.getTexture("cutscene_platform2"));
					tutorial2.addEventListener(TouchEvent.TOUCH, TutorialTouch);
					addChild(tutorial2);
				}
				else if(event.target == tutorial2){
					tutorial2.removeEventListener(TouchEvent.TOUCH, TutorialTouch);
					removeChild(tutorial2);
					removeChild(tutorial0);
					
					AddEntities();
					View.GetInstance().GetPlayer().Run();
					
					loaded = true;
					
					View.GetInstance().GetPlayer().setTutorials(2, true);
				}
			}				
		}
		
		/**
		 * This is where all the entites specific for the level is added.
		 */
		private function AddEntities():void{
			/* CHANGING PLAYER SPAWN POSITION ALSO NEEDS TO BE CHANGED IN PHYSICUS -> GRAVITY */
			View.GetInstance().GetPlayer().x = 100;
			View.GetInstance().GetPlayer().y = 205;
			addChild(View.GetInstance().GetPlayer());
		}
		
		public function ScreenProgression():void{
			if(bottom.GetProgress() >= 25 && background2 == null){
				background2 = new Image(assetManager.getTexture("background"));
				background2.x = 480;
				background2.y = 0;
				View.GetInstance().AddEntity(background2);
				addChildAt(background2, 1);
			}
			if(bottom.GetProgress() >= 58 && background3 == null){
				background3 = new Image(assetManager.getTexture("background"));
				background3.x = 480;
				background3.y = 0;
				View.GetInstance().AddEntity(background3);
				addChildAt(background3, 1);
			}
			
			if(bottom.GetProgress() >= 92 && winImage == null){
				winImage = new Image(assetManager.getTexture("Level1FinalStage"));
				winImage.x = 480;
				winImage.y = 0;
				View.GetInstance().AddEntity(winImage);
				addChildAt(winImage, 1);
			}
			if(bottom.GetProgress() >= 100){
				timer.start();
				View.GetInstance().setLockInformationScreen(true);
				View.GetInstance().GetPlayer().Stop();
				View.GetInstance().GetPlayer().setLevel(2, true);
			}
		}
		
		/**
		 * Changes the x coordinate of the entites so they all move, it uses the variable speed decide how many pixels to move.
		 * To change the speed of the level change the speed variable in the top.
		 */
		private function MoveEntities():void{
			if(bottom.GetProgress() < 100){
				for(var i:int = 0; i < View.GetInstance().GetEntities().length; i++){
					View.GetInstance().GetEntities()[i].x -= speed;
				}
			}
		}
		
		private function SpawnAll(interval:int):void{
			if(bottom.GetProgress() == 19 && !spawned19 || bottom.GetProgress() == 0 && !spawned0 || bottom.GetProgress() == 38 && !spawned38 || bottom.GetProgress() == 57 && !spawned57 || bottom.GetProgress() == 76 && !spawned76){
				var spawnEnemy:int = Math.floor(Math.random()*5);
				if ( spawnEnemy != 1){
					var neonatalSepsis:Sprite  = new NeonatalSepsis();
					neonatalSepsis.x = 500;
					neonatalSepsis.y = 215;
					View.GetInstance().AddEntity(neonatalSepsis);
					addChildAt(neonatalSepsis, 3);
				}
				
				var platform:Platform = new Platform();
				platform.x = 575;
				platform.y = 175;
				View.GetInstance().AddEntity(platform);
				addChildAt(platform, 3);
				
				var nextPowerUpX:int = 650;
				var nextPowerUpY:int = 60;
				var nextPowerUp:int = Math.floor(Math.random()*5);
				SpawnPowerUp(nextPowerUp, nextPowerUpX, nextPowerUpY);
				
				nextPowerUpX = 600;
				nextPowerUpY = 155;
				nextPowerUp = Math.floor(Math.random()*5);
				SpawnPowerUp(nextPowerUp, nextPowerUpX, nextPowerUpY);
				
				if ( spawnEnemy != 2){
					var neonatalSepsis2:Sprite  = new NeonatalSepsis();
					neonatalSepsis2.x = 850;
					neonatalSepsis2.y = 215;
					View.GetInstance().AddEntity(neonatalSepsis2);
					addChildAt(neonatalSepsis2, 3);
				}
				
				nextPowerUpX = 950;
				nextPowerUpY = 215;
				nextPowerUp = Math.floor(Math.random()*5);
				SpawnPowerUp(nextPowerUp, nextPowerUpX, nextPowerUpY);
				
				if ( spawnEnemy != 3){
					var neonatalSepsis3:Sprite  = new NeonatalSepsis();
					neonatalSepsis3.x = 1050;
					neonatalSepsis3.y = 215;
					View.GetInstance().AddEntity(neonatalSepsis3);
					addChildAt(neonatalSepsis3, 3);
				}
				
				nextPowerUpX = 1125;
				nextPowerUpY = 215;
				nextPowerUp = Math.floor(Math.random()*5);
				SpawnPowerUp(nextPowerUp, nextPowerUpX, nextPowerUpY);
				
				var coinOrHeart:int =  Math.floor(Math.random()*2)
				if(coinOrHeart == 1){
					var coin:Coin = new Coin();
					coin.x = 1225;
					coin.y = 215;
					View.GetInstance().AddEntity(coin);
					addChildAt(coin, 3);
				}else{
					var heart:Heart = new Heart();
					heart.x = 1225;
					heart.y = 215;
					View.GetInstance().AddEntity(heart);
					addChildAt(heart, 3);
				}
				
				if ( spawnEnemy != 4){
					var neonatalSepsis4:Sprite  = new NeonatalSepsis();
					neonatalSepsis4.x = 1325;
					neonatalSepsis4.y = 215;
					View.GetInstance().AddEntity(neonatalSepsis4);
					addChildAt(neonatalSepsis4, 3);
				}
				if(bottom.GetProgress() == 0){
					spawned0 = true;
				}
				if(bottom.GetProgress() == 19){
					spawned19 = true;
				}
				if(bottom.GetProgress() == 38){
					spawned38 = true;
				}
				if(bottom.GetProgress() == 57){
					spawned57 = true;
				}
				if(bottom.GetProgress() == 76){
					spawned76 = true;
				}
			}
		}
		
		private function SpawnPowerUp(type:int, xLocation:int, yLocation:int):void{
			switch (type){
				case 0:
					//do nothing
					break;
				
				case 1:
					var coin:Coin = new Coin();
					coin.x = xLocation;
					coin.y = yLocation;
					View.GetInstance().AddEntity(coin);
					addChildAt(coin, 3);
					break;
				
				case 2:
					var watch:Watch = new Watch();
					watch.x = xLocation;
					watch.y = yLocation;
					View.GetInstance().AddEntity(watch);
					addChildAt(watch, 3);	
					break;
				
				case 3:
					var medicine:Medicine = new Medicine();
					medicine.x = xLocation;
					medicine.y = yLocation;
					View.GetInstance().AddEntity(medicine);
					addChildAt(medicine, 3);					
					break;
				
				case 4:
					var towel:Towel = new Towel();
					towel.x = xLocation;
					towel.y = yLocation;
					View.GetInstance().AddEntity(towel);
					addChildAt(towel, 3);					
					break;
			}
		}
		
		/**
		 * This function decides how much the virus pulses in this level.
		 * By changing the pulseSize integer in the top, the level of the pulse can be changed for this level.
		 */
		private function VirusPulse():void{
			for(var i:int = 0; i < View.GetInstance().GetEntities().length; i++){
				if(View.GetInstance().GetEntities()[i] is Virus){
					if(pulseTracker < pulseSize && pulseGoingUp){
						(View.GetInstance().GetEntities()[i] as Virus).Pulse(pulseTracker);
						pulseTracker++;
					}
					else if(pulseTracker == pulseSize && pulseGoingUp){
						(View.GetInstance().GetEntities()[i] as Virus).Pulse(pulseTracker);
						pulseGoingUp = false;
						pulseTracker--;
					}
					else if(pulseTracker > 0 && !pulseGoingUp){
						(View.GetInstance().GetEntities()[i] as Virus).Pulse(pulseTracker);
						pulseTracker--;
					}
					else if(pulseTracker == 0 && !pulseGoingUp){
						(View.GetInstance().GetEntities()[i] as Virus).Pulse(pulseTracker);
						pulseGoingUp = true;
						pulseTracker++;
					}
				}
			}
		}
		
		/**
		 * Updates the screen.
		 */
		public function Update():void{
			if(loaded && top.Loaded() && bottom.Loaded()){
				speed = View.GetInstance().getSpeed();
				MoveEntities();
				RemoveOutOfStageEntities();
				SpawnAll(spawnTimeInSeconds);
				top.Update();
				ScreenProgression();
				bottom.Update();
				VirusPulse();
			}
			if(View.GetInstance().GetPlayer().getSpawned()){
				Common.Physicus.GetInstance().Collision();
				Common.Physicus.GetInstance().Gravity();
			}
		}
		
		/**
		 * Deleting the Entites when it leaves the screen.
		 * If it is an Entity call Destroy().
		 */
		private function RemoveOutOfStageEntities():void{
			for(var i:int = 0; i < View.GetInstance().GetEntities().length; i++){
				if(View.GetInstance().GetEntities()[i].x < (0 - View.GetInstance().GetEntities()[i].width)){	
					removeChild(View.GetInstance().GetEntities()[i]);
					
					if(View.GetInstance().GetEntities()[i] is Entity){
						View.GetInstance().GetEntities()[i].Destroy();
						View.GetInstance().RemoveEntity(View.GetInstance().GetEntities()[i]);
					}
				}
			}
		}
		
		/**
		 * Continues to next screen.
		 */
		private function Continue(event:TimerEvent):void{
			View.GetInstance().GetPlayer().setHighscore(1, View.GetInstance().GetTime());
			View.GetInstance().setCurrentLevel(1);
			View.GetInstance().LoadScreen(Highscore);
		}
		
		/**
		 * Called when the screen is changed.
		 */
		public function Destroy():void{
			bottom.Destroy();
			top.Destroy();
			jumpLayer.Destroy();
			timer.removeEventListener(TimerEvent.TIMER_COMPLETE, Continue);
			removeEventListeners(null);
			assetManager.dispose();
			IO.GetInstance().Save();
		}
	}
}