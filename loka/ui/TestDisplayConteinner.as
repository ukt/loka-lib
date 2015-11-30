package loka.ui
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	
	import loka.asUtils.Action;

	public class TestDisplayConteinner
	{
		public static var STRONG:Boolean = false;
		private static var ignorName:Dictionary = new Dictionary();
		public function TestDisplayConteinner()
		{
		}
		
		private static var _timer:Timer;
		/*private static function init():void{
			if(!_timer){
				_timer = new Timer(1000);
			}
		}*/
		
		public static function addIgnorChildName(name:String, status:Boolean = true):void 
		{
			ignorName[name] = status
		}
		
		private static function testIgnoreList(name:String):Boolean
		{
			if(ignorName.hasOwnProperty(name)){
				return ignorName[name];
			}
			return false;
		}
		
		public static function testDOWithEnterFrame(DO:DisplayObjectContainer):void 
		{
			if (!STRONG) 
			{	
				return;
			}
//			init();
			for(var c:int; c < DO.numChildren; c++)
			{
				var localDO:Object = DO.getChildAt(c); 
				if(localDO as DisplayObjectContainer)
				{
					Action.callLater(testDOWithEnterFrame, [localDO]); 
				}
//				trace((localDO as DisplayObject).name)
				if((localDO as DisplayObject).hasEventListener(Event.ENTER_FRAME) && !testIgnoreList(localDO.name))
				{
					throw new Error("Please don't use EnterFrame methode, use AController to use local method iteration");
				}
			}
			
			Action.callLater(testDOWithEnterFrame, [DO]);
			
		}
	}
}