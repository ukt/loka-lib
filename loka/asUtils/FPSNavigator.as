package loka.asUtils
{
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.utils.getTimer;
	/**
	 * ...
	 * @author loka
	 */
	public class FPSNavigator 
	{
		private static var _instance:DisplayObject = null;
		
		public function FPSNavigator() {}
		
		public static function initFPS(instance:DisplayObject):void 
		{
			if (_instance == null && instance != null) 
			{
				_instance = instance;
				var testTime:Number;
				testTime = getTimer();
				var checkFps:Function = function txtUpdate(e:Event):void {
					//txt.text="RAM: " + Math.round(System.totalMemory/1048576)+" mb\n";
					//txt.text = txt.text + "FPS: " + Math.round(1000 / (getTimer() - testTime));
					_FPS = int(1000 / (getTimer() - testTime));
					testTime = getTimer();
				};
					
				_instance.addEventListener(Event.ENTER_FRAME, checkFps);
				
			}
		}
		
		public static function get FPS():Number {
			return _FPS;
		}
		
		private static var _FPS:Number = 0;
		
	}

}