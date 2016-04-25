package loka.asUtils {
	import flash.utils.Dictionary;
	import flash.utils.getTimer;

	/**
	 * ...
	 * @author loka
	 */
	public class TimeDoing {
		private static var _number:Dictionary = new Dictionary();
		private static var _maxNumber:Dictionary = new Dictionary();
		private static var _minNumber:Dictionary = new Dictionary();

		public function TimeDoing() {

		}

		public static function setTime(name:String):void {
			_number[name] = getTimer();
		}

		public static function reset(name:String):void {
			delete _number[name];
			delete _maxNumber[name];
			delete _minNumber[name];

		}
		public static function resetAll():void {
			_number = new Dictionary();
			_maxNumber = new Dictionary();
			_minNumber = new Dictionary();
		}

		/**
		 *
		 * @param name
		 * @param timeType: "milliseconds", "seconds"
		 * @return
		 *
		 */
		public static function getTime(name:String, timeType:String = "milliseconds"):Number {
			if (_number.hasOwnProperty(name)) {
				var number:int = _number[name] as int;
				delete _number[name];
				var timeExecutionInMls:int = (getTimer() - number);
				saveTimeExecutionInMls(name, timeExecutionInMls);
				if (timeType == "milliseconds") {
					return timeExecutionInMls;
				} else {
					return timeExecutionInMls / 60;
				}
			} else {
				return -1;
			}
		}

		public static function getMaxTime(name:String, timeType:String = "milliseconds"):Number {
			if (_maxNumber.hasOwnProperty(name)) {
				var timeExecutionInMls:int = int(_maxNumber[name]);
				if (timeType == "milliseconds") {
					return timeExecutionInMls;
				} else {
					return timeExecutionInMls / 60;
				}
			} else {
				return -1;
			}
		}

		public static function getMinTime(name:String, timeType:String = "milliseconds"):Number {
			if (_minNumber.hasOwnProperty(name)) {
				var timeExecutionInMls:int = int(_minNumber[name]);
				if (timeType == "milliseconds") {
					return timeExecutionInMls;
				} else {
					return timeExecutionInMls / 60;
				}
			} else {
				return -1;
			}
		}

		private static function saveTimeExecutionInMls(name:String, timeExecutionInMls:int):void {
			if (!_maxNumber.hasOwnProperty(name)) {
				_maxNumber[name] = timeExecutionInMls;
			}
			if (!_minNumber.hasOwnProperty(name)) {
				_minNumber[name] = timeExecutionInMls;
			}

			if (int(_maxNumber[name]) < timeExecutionInMls) {
				_maxNumber[name] = timeExecutionInMls;
			}

			if (int(_minNumber[name]) > timeExecutionInMls) {
				_minNumber[name] = timeExecutionInMls;
			}
		}

		public static function traceTime(name:String, timeType:String = "milliseconds"):void {
			trace(name, getTime(name, timeType));
		}

		public static function traceIfIncreased(name:String, timeType:String = "milliseconds"):void {
			var maxTime:Number = getMaxTime(name);
			var time:Number = getTime(name, timeType);
			if(maxTime<time){
				trace(name, time);
			}
		}

		public static function traceIfDecreased(name:String, timeType:String = "milliseconds"):void {
			var minTime:Number = getMinTime(name);
			var time:Number = getTime(name, timeType);
			if(minTime>time){
				trace(name, time);
			}
		}
	}

}