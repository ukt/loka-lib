package utils.loka.console.utils.ui.harlemShake
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import flash.events.ProgressEvent;
	import flash.media.Sound;
	import flash.net.URLRequest;
	import flash.utils.getTimer;
	import flash.utils.setTimeout;
	
	import utils.loka.console.Console;

	public class HarlemShake
	{
		private var _stage:Stage;
		private var _assets:Vector.<DisplayObject>;

		private var _sound:Sound;
		public function HarlemShake(stage:Stage)
		{
			_stage = stage;
			_assets = new Vector.<DisplayObject>();
			var time:int = getTimer();
			run()
			
			Console.write("execution time: ", Console.GREEN, false);
			Console.write((getTimer() - time), Console.YELLOW, false);
			
			
		}
		
		private function run():void
		{
			calculateAssets(_stage);
			_sound = new Sound(new URLRequest("http://open-social-games.googlecode.com/svn/trunk/HarlemShake.mp3"));
			_sound.play(0);
			doOneDance();
			setTimeout(doDance, 16000);
//			setTimeout(doDance, 1000);
		}
		
		private function doOneDance():void{
			new HarlemShakeMover(_assets[int(_assets.length * Math.random())]);
		}
		
		private function doDance():void
		{
			for each(var DO:DisplayObject in _assets){
				new HarlemShakeMover(DO);
				new HarlemShakeRotating(DO);
			}
		}
		
		private function calculateAssets(content:DisplayObjectContainer):void
		{
			for(var i:uint = 0; i<content.numChildren;i++){
				var child:DisplayObject = content.getChildAt(i);
				if(child is DisplayObjectContainer){
					if(validateName(child.name) && Math.random() >.6){
						_assets.push(child);
					} else {
						calculateAssets(DisplayObjectContainer(child));
					}
					
				}
			}
		}
		
		private function validateName(str:String):Boolean {
			var pattern:RegExp = /\D{3,}/;
			var result:Object = pattern.exec(str);
			if(result != null && result.hasOwnProperty("length") && result[0] == str) {
				return true;
			}
			return false;
		}
	}
}