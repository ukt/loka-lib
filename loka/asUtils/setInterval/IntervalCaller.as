package utils.loka.asUtils.setInterval
{
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 *
	 * @history create Apr 6, 2012 5:38:32 PM
	 * @author g.savenko
	 */    
	public class IntervalCaller
	{
		//------------------------------------------------
		//      Class constants
		//------------------------------------------------
		
		//------------------------------------------------
		//      Variables
		//------------------------------------------------
		private static var iterr:uint = 0;
		private static var _FUNC_MASK:String = "_FUNC";
		private static var _PARAMS_MASK:String = "_PARAMS";
		private static var _slice:Dictionary = new Dictionary();
//		private static var _timerMap:Dictionary = new Dictionary();
		//---------------------------------------------------------------
		//
		//      CONSTRUCTOR
		//
		//---------------------------------------------------------------
		public function IntervalCaller()
		{
		}
		
		//---------------------------------------------------------------
		//
		//      PRIVATE & PROTECTED METHODS
		//
		//---------------------------------------------------------------
		
		private static function dofunc(event:TimerEvent):void
		{
			var timer:DataTimmer = event.currentTarget as DataTimmer;
			var uid:String = timer.getproperty("uid").toString();
			var repeat:Boolean = Boolean(timer.getproperty("repeat"));
			var count:uint = int(timer.getproperty("count"));
			var fun:Function
			if(!repeat && count)
			{
				if(count)
				{
					count--;
					timer.setproperty("count", count);
			
					fun = _slice[uid + _FUNC_MASK];
					if(fun.length > 0)
					{
						var params:Array = _slice[uid + _PARAMS_MASK];
//						var needParams:Array = params;//.slice(0, fun.length); 
						fun.apply(null, params);
						//fun.call(null, _slice[uid + _PARAMS_MASK]);
					}
					else
					{
						fun.call();
					}
					if(!count)
					{
						timer.stop();
					}
				}
				else
				{
					timer.stop();
				}
			}
			else if(repeat)
			{
				fun = _slice[uid + _FUNC_MASK];
			if(fun.length > 0)
			{
				fun.apply(null, _slice[uid + _PARAMS_MASK]);
			}
			else
			{
				fun.call();
			}
		}
		}
		
		//---------------------------------------------------------------
		//
		//      EVENT HANDLERS
		//
		//---------------------------------------------------------------
		
		
		//---------------------------------------------------------------
		//
		//      PUBLIC METHODS
		//
		//---------------------------------------------------------------
		public static function addIntervalCaller(func:Function, delay:Number, count:uint = 0, fastCall:Boolean = true, ...params):int
		{
			var timmer:DataTimmer = new DataTimmer(delay, count);
			timmer.addEventListener(TimerEvent.TIMER, dofunc);
			timmer.addEventListener(TimerEvent.TIMER_COMPLETE, onComplete);
			timmer.setproperty("uid", ++iterr)
			timmer.setproperty("count", count)
			timmer.setproperty("repeat", !count)
			_slice[iterr] = timmer;
			_slice[iterr + _PARAMS_MASK] 	= params;
			_slice[iterr + _FUNC_MASK] 		= func;
//			_timerMap[iterr] = timmer; 
			timmer.start();
			if(fastCall)
			{
				if(func.length > 0)
				{
					func.apply(null, params);
				}
				else
				{
					func.call();
				}
				count--;
			}
			return iterr;
		}
		
		protected static function onComplete(event:TimerEvent):void
		{
			var timer:DataTimmer = event.currentTarget as DataTimmer;
			timer.stop();
			dispose(uint(timer.getproperty("uid")));
		}
		
		/**
		 * 
		 * @param num
		 * @param paused:Boolean = [true: pause, false: play]
		 * 
		 */
		public static function play(num:uint, paused:Boolean = false):void
		{
			var timmer:DataTimmer = DataTimmer(_slice[num]);
			if (paused) {
				timmer.stop();
			} else {			
				timmer.start();
			}
		}
		public static function dispose(num:uint):void
		{
			var timmer:DataTimmer = DataTimmer(_slice[num]);
			if(timmer)
			{
				timmer.removeEventListener(TimerEvent.TIMER, dofunc);
				timmer.removeEventListener(TimerEvent.TIMER_COMPLETE, onComplete);
				delete _slice[num + _PARAMS_MASK];
				delete _slice[num + _FUNC_MASK];
				delete _slice[num]
				
				timmer = null;
			}
		}
		//---------------------------------------------------------------
		//
		//      ACCESSORS
		//
		//---------------------------------------------------------------
	}
}