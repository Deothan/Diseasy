package Levels{
	import flash.events.TimerEvent;
	import flash.filesystem.File;
	import flash.utils.Timer;
	
	import Common.Entity;
	import Common.Highscore;
	import Common.IO;
	import Common.Physicus;
	import Common.Screen;
	
	import Items.Blanket;
	import Items.Coin;
	import Items.Heart;
	import Items.Medicine;
	import Items.Towel;
	import Items.Watch;
	
	import Main.View;
	
	import Obstacles.Branch;
	import Obstacles.WaterPit;
	
	import Platforms.Platform;
	
	import VirusScreen.VirusScreen;
	
	import Viruses.Malaria;
	import Viruses.NeonatalSepsis;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.AssetManager;
	
	public class Level_4 extends Sprite implements Screen{
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
		
		//Changeable variables
		private var widthOfLevelInPixels:int = 6150;
		private var speed:int = View.GetInstance().getSpeed();
		private var spawnTimeInSeconds:int = 13;
		
		public function Level_4(){
			addEventListener(Event.ADDED_TO_STAGE, Initialize);
		}
		
		private function Initialize():void{
			assetManager = new AssetManager();
			var folder:File = File.applicationDirectory.resolvePath("Levels/assets/level4");
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
			
			AddEntities();
			
			addChild(jumpLayer);
			
			View.GetInstance().GetPlayer().Run();
			View.GetInstance().GetPlayer().setIdleFlag(false);
			
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
				winImage = new Image(assetManager.getTexture("Level4FinalStage"));
				winImage.x = 480;
				winImage.y = 0;
				View.GetInstance().AddEntity(winImage);
				addChildAt(winImage, 1);
			}
			if(bottom.GetProgress() >= 100){
				timer.start();		
				View.GetInstance().setLockInformationScreen(true);
				View.GetInstance().GetPlayer().Stop();
				View.GetInstance().GetPlayer().setLevel(5, true);
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
				
				var nextEnemyX:int = 500;
				var nextEnemy:int = Math.floor(Math.random()*5);
				SpawnEnemies(nextEnemy, nextEnemyX);
				
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
				
				nextEnemyX = 850;
				nextEnemy = Math.floor(Math.random()*5);
				SpawnEnemies(nextEnemy, nextEnemyX);
				
				nextPowerUpX = 950;
				nextPowerUpY = 215;
				nextPowerUp = Math.floor(Math.random()*5);
				SpawnPowerUp(nextPowerUp, nextPowerUpX, nextPowerUpY);
				
				nextEnemyX = 1050;
				nextEnemy = Math.floor(Math.random()*5);
				SpawnEnemies(nextEnemy, nextEnemyX);
				
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
				
				nextEnemyX = 1325;
				nextEnemy = Math.floor(Math.random()*5);
				SpawnEnemies(nextEnemy, nextEnemyX);
				
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
					towel.x = 550;
					towel.y = 215;
					View.GetInstance().AddEntity(towel);
					addChildAt(towel, 3);			
					break;
			}
		}
		
		
		private function SpawnEnemies(type:int, xLocation:int):void{
			switch (type){
				case 0:
					//do nothing
					break;
				
				case 1:
					var malaria:Sprite  = new Malaria();
					malaria.x = 500;
					malaria.y = 215;
					View.GetInstance().AddEntity(malaria);
					addChildAt(malaria, 3);
					break;
				
				case 2:
					var branch:Sprite = new Branch();
					branch.x = (500 + 130);
					branch.y = 215;
					View.GetInstance().AddEntity(branch);
					addChildAt(branch, 3);
					break;
				
				case 3:
					var malaria2:Sprite  = new Malaria();
					malaria2.x = 500;
					malaria2.y = 215;
					View.GetInstance().AddEntity(malaria2);
					addChildAt(malaria2, 3);
					break;
				
				case 4:
					var branch2:Sprite = new Branch();
					branch2.x = (500 + 130);
					branch2.y = 215;
					View.GetInstance().AddEntity(branch2);
					addChildAt(branch2, 3);				
					break;
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
			View.GetInstance().GetPlayer().setHighscore(4, View.GetInstance().GetTime());
			View.GetInstance().setCurrentLevel(4);
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