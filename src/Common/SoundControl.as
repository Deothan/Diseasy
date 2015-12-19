package Common{
	import flash.filesystem.File;
	import flash.media.Sound;
	
	import starling.utils.AssetManager;
	import flash.media.SoundChannel;
	
	public class SoundControl
	{
		private var assetManager:AssetManager;
		private var Channel:SoundChannel =  new SoundChannel();
		private var sound:Sound;
		
		public function SoundControl(){
			Initialize();
		}
		
		private function Initialize():void{
			assetManager = new AssetManager();
			var folder:File = File.applicationDirectory.resolvePath("Common/assets");
			assetManager.enqueue(folder);
			assetManager.verbose = true;
			assetManager.loadQueue(Progress);
		}
		
		private function Progress(ratio:Number):void{
			if(ratio == 1){
				trace("[AssetManager] MUSIC LOADED");
			}
		}
		
		public function playSad():void{
			if(Channel != null) Channel.stop();
			sound = assetManager.getSound("sadtheme");
			Channel = sound.play();
		}
	}
}