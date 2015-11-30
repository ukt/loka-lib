package utils.loka.app.controller.event
{
	import flash.events.Event;
	
	/**
	 * 
	 * @author Loka
	 * 
	 */
	public class BaseEvent extends Event
	{
		public var data:*;
		
		public function BaseEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false, data:* = null)
		{
			data = data;
			super(type, bubbles, cancelable);
		}
	}
}