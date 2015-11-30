package loka.asUtils {
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	/**
	 * ...
	 * @author loka
	 */
	public class TimeDoing {
		private static var _number:Dictionary = new Dictionary();
		public function TimeDoing() {
			
		}
		
		public static function setTime(name:String):void {
			_number[name] = getTimer();
		}
		
        /**
         * 
         * @param name
         * @param timeType: "milliseconds", "seconds"
         * @return 
         * 
         */
		public static function getTime(name:String, timeType:String = "milliseconds"):Number {
			if(_number.hasOwnProperty(name)) {
				var number:int = _number[name] as int;
				delete _number[name];
                if(timeType == "milliseconds") {
    				return (getTimer() - number);
                } else {
                    return (getTimer() - number) / 60;
                }
			} else {
				return 666;
			}
		}
	}

}