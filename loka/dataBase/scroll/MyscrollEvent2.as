package utils.loka.dataBase.scroll {
	import flash.events.Event;
	
	/**
	 * ...
	 * @author hello
	 */
	public class MyscrollEvent2 extends Event 
	{
		
		public function MyscrollEvent2(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new MyscrollEvent2(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("MyscrollEvent2", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}