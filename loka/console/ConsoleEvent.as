package utils.loka.console
{
	import flash.events.Event;
	
	public class ConsoleEvent extends Event
	{
		public static var WRITE_IN_CONSOLE:String = "WRITE_IN_CONSOLE";
		
		public var text:String;
		public var color:uint;
		public var wrap:Boolean; 
		public var data:Object;
		public var stream:uint;
		public function ConsoleEvent(type:String = "WRITE_IN_CONSOLE", text:String = "", color:uint = 0xffffff, wrap:Boolean = true, data:Object = null, stream:uint = 1, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			this.text = text;
			this.color = color;
			this.wrap = wrap;
			this.data = data;
			this.stream = stream;
			
			super(type, bubbles, cancelable);
		}
	}
}