package loka.asUtils
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
//	import org.osmf.events.TimeEvent;

	public class Action
	{
		public function Action()
		{
		}
		
		private static var deferredMethodQueue:Array = [];
		
		private static var _timer:Timer;
		private static function init():void{
			if(!_timer){
				_timer = new Timer(1000);
				_timer.addEventListener(TimerEvent.TIMER, processScheduledObjects)
				_timer.start();
			}
		}
		public static function callLater(method:Function, args:Array = null):void
		{
			init();
			var dm:DeferredMethod = new DeferredMethod();
			dm.method = method;
			dm.args = args;
			// optimization (better than push?!)
			deferredMethodQueue[deferredMethodQueue.length] = dm;
		}
		
		private static function processScheduledObjects(e:TimerEvent):void
		{
			// Do any deferred methods.
			var oldDeferredMethodQueue:Array = deferredMethodQueue;
			if(oldDeferredMethodQueue.length)
			{
				//Profiler.enter("callLater");
				
				// Put a new array in the queue to avoid getting into corrupted
				// state due to more calls being added.
				deferredMethodQueue = [];
				
				for(var j:int=0; j<oldDeferredMethodQueue.length; j++)
				{
					var curDM:DeferredMethod = oldDeferredMethodQueue[j] as DeferredMethod;
					curDM.method.apply(null, curDM.args);
				}
				
				// Wipe the old array now we're done with it.
				oldDeferredMethodQueue = [];
				
				//Profiler.exit("callLater");      	
			}
		}
	}
}
final class DeferredMethod
{
	public var method:Function = null;;
	public var args:Array = null;
}