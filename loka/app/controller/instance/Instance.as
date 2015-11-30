package utils.loka.app.controller.instance
{
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;

	public class Instance extends EventDispatcher
	{
		private var _list:Dictionary;
		private static var initiator:Instance = new Instance();
		public function Instance()
		{
			init();
		}
		
		private function init():void
		{
			_list = new Dictionary();
		}
		
		public static function getInstance(name:String):Object
		{
			return initiator._list[name];
		}
		
		public static function hasInstance(name:String):Boolean
		{
			return initiator._list.hasOwnProperty(name);
		}
		
		public static function addInstance(instance:Object, name:String):void
		{
			if(!initiator._list[name])
			{
				initiator._list[name] = instance;
			}
			else
			{
				throw new Error("need unique name for instance");
			}
		}
		
		public static function removeInstance(instance:Object, name:String):void
		{
			if(initiator._list[name])
			{
				delete initiator._list[name];
			}
		}
	}
}