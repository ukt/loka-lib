package utils.loka.app.controller
{
	import flash.events.EventDispatcher;
	
	import utils.loka.app.controller.command.ICommand;
	import utils.loka.app.controller.instance.Instance;
	import utils.loka.app.model.IModel;

	public class Controller extends EventDispatcher
	{
		
		private static var instance:Controller;
		public function Controller()
		{
			if(instance)
			{
				throw new Error("Only once!!!");
			}
		}
		
		public static function registeCommand(value:Class, alias:String):void
		{
			Instance.addInstance(value, alias);
		}
		
		public static function removeCommand(value:Class, alias:String):void
		{
			Instance.removeInstance(value, alias);
		}
		
		public static function call(alias:String, onRezult:Function = null, onFault:Function = null, parrams:Object = null):void
		{
			try
			{
				(new (Instance.getInstance(alias) as Class)() as ICommand).call(onRezult, onFault, parrams, instance);
			}
			catch(e:Error)
			{
				trace(e.errorID);
				trace(e.name);
				trace(e.message);
				trace(e.getStackTrace());
			}
		}
		
		public static function registeModel(value:IModel):void
		{
			Instance.addInstance(value, value.alias);
		}
		
		public static function getModel(alias:String):IModel
		{
			return Instance.getInstance(alias) as IModel;
		}
		
		public static function init():void
		{
			instance = new Controller();
		}
		
		public static function addEventListener(type:String, listener:Function):void
		{
			instance.addEventListener(type, listener);
		}
		
		public static function removeEventListener(type:String, listener:Function):void
		{
			instance.removeEventListener(type, listener);
		}
	}
}