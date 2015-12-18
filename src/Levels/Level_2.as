package Levels{
	import flash.events.TimerEvent;
	import flash.filesystem.File;
	import flash.utils.Timer;
	
	import Common.Entity;
	import Common.IO;
	import Common.Physicus;
	import Common.Screen;
	
	import Items.Coin;
	import Items.Heart;
	import Items.Medicine;
	import Items.Towel;
	import Items.Watch;
	import Items.WaterBottle;
	
	import Main.View;
	
	import Platforms.Platform;
	
	import VirusScreen.VirusScreen;
	
	import Viruses.Diarrhea;
	import Obstacles.Rock;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.AssetManager;
	
	public class Level_2 extends Sprite implements Screen{
		private var assetManager:AssetManager;
		private var top:TopBar = new TopBar();
		private var bottom:BottomBar = new BottomBar;
		private var jumpLayer:JumpLayer = new JumpLayer();
		private var background:Image;
		private var jumpScreen:Image;
		private var winImage:Image;
		private var loaded:Boolean = false;
		private var playerLoaded:Boolean = false;
		private var timer:flash.utils.Timer;
		
		//Changeable variables
		private var widthOfLevelInPixels:int = 2528;
		private var speed:int = 2;
		private var enemySpawnTimeInSeconds:int = 8;
		private var platformSpawnTimeInSeconds:int = 12;
		private var itemSpawnTimeInSeconds:int = 16;
		
		public function Level_2(){
			addEventListener(Event.ADDED_TO_STAGE, Initialize);
		}
		
		private function Initialize():void{
			assetManager = new AssetManager();
			var folder:File = File.applicationDirectory.resolvePath("Levels/assets/level2");
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
			
			View.GetInstance().GetInfant().setHealth(100);
			View.GetInstance().GetInfant().setHydration(100);
			View.GetInstance().GetInfant().setHygiene(100);
			View.GetInstance().GetInfant().setTemperature(100);

			timer = new flash.utils.Timer(3500, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, Continue);
			
			background = new Image(assetManager.getTexture("background"));
			View.GetInstance().AddEntity(background);
			addChild(background);
			
			addChild(top);
			
			bottom.SetSpeed(speed);
			bottom.SetWidthOfLevelInPixels(widthOfLevelInPixels);
			addChild(bottom);
			
			AddEntities();
			
			addChild(jumpLayer);
			
			View.GetInstance().GetPlayer().Run();
			
			loaded = true;
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
			if(bottom.GetProgress() >= 76 && winImage == null){
				winImage = new Image(assetManager.getTexture("Level2FinalStage"));
				winImage.x = 480;
				winImage.y = 0;
				View.GetInstance().AddEntity(winImage);
				addChildAt(winImage, 1);
			}
			if(bottom.GetProgress() >= 100){
				timer.start();	
				View.GetInstance().GetPlayer().Stop();
				View.GetInstance().GetPlayer().setLevel(3, true);
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
		
		/**
		 * Spawns enemies at a given interval, but not in the end zone.
		 * @param interval:int - interval in seconds between spawn.
		 */
		private function SpawnEnemies(interval:int):void{
			if( (top.GetTime()/24)%interval == 0 && bottom.GetProgress() < 70){
				var diarrhea:Sprite  = new Diarrhea();
				diarrhea.x = 500;
				diarrhea.y = 215;
				View.GetInstance().AddEntity(diarrhea);
				addChildAt(diarrhea, 3);
			}
		}
		
		/**
		 * Spawns items at a given interval, but not in the end zone.
		 * @param interval:int - interval in seconds between spawn.
		 */
		private function SpawnItems(interval:int):void{
			if( (top.GetTime()/24)%interval == 0 && bottom.GetProgress() < 70){				
				var rock:Sprite  = new Rock();
				rock.x = (500 + 230);
				rock.y = 215;
				View.GetInstance().AddEntity(rock);
				addChildAt(rock, 3);
				
				var coin:Coin = new Coin();
				coin.x = 550;
				coin.y = 215;
				View.GetInstance().AddEntity(coin);
				addChildAt(coin, 3);
				
				var watch:Watch = new Watch();
				watch.x = 935;
				watch.y = 100;
				View.GetInstance().AddEntity(watch);
				addChildAt(watch, 3);
				
				var heart:Heart = new Heart();
				heart.x = 730;
				heart.y = 215;
				View.GetInstance().AddEntity(heart);
				addChildAt(heart, 3);
				
				var medicine:Medicine = new Medicine();
				medicine.x = 815;
				medicine.y = 215;
				View.GetInstance().AddEntity(medicine);
				addChildAt(medicine, 3);
				
				var towel:Towel = new Towel();
				towel.x = 770;
				towel.y = 215;
				View.GetInstance().AddEntity(towel);
				addChildAt(towel, 3);
				
				var waterBottle:WaterBottle = new WaterBottle();
				waterBottle.x = 630;
				waterBottle.y = 215;
				View.GetInstance().AddEntity(waterBottle);
				addChildAt(waterBottle, 3);
			}
		}
		
		/**
		 * Spawns platforms at a given interval, but not in the end zone.
		 * @param interval:int - interval in seconds between spawn.
		 */
		private function SpawnPlatforms(interval:int):void{
			if (((top.GetTime())/24)%interval == 0 && bottom.GetProgress() < 70){
				var platform:Platform = new Platform();
				platform.x = 550;
				platform.y = 175;
				View.GetInstance().AddEntity(platform);
				addChildAt(platform, 3);
			}
		}
		
		/**
		 * Updates the screen.
		 */
		public function Update():void{
			if(loaded && top.Loaded() && bottom.Loaded()){
				MoveEntities();
				RemoveOutOfStageEntities();
				SpawnEnemies(enemySpawnTimeInSeconds);
				SpawnPlatforms(platformSpawnTimeInSeconds);
				SpawnItems(itemSpawnTimeInSeconds);
				top.Update();
				ScreenProgression();
				bottom.Update();
				
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
			View.GetInstance().LoadScreen(VirusScreen);
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