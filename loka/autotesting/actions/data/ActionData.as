package loka.autotesting.actions.data {
	public class ActionData	{
		private var _command:String;
		private var _timeOut:uint;
		private var _parrams:Array;
		private var _invocationCount:int;
		private var _isComplete:Boolean;
		public function ActionData() {
		}

		public function get isComleted():Boolean {
			return _isComplete;
		}

		public function set isComleted(value:Boolean):void {
			_isComplete = value;
		}

		public function get invocationCount():int {
			return _invocationCount;
		}

		public function set invocationCount(value:int):void {
			_invocationCount = value;
		}

		public function get parrams():Array {
			return _parrams;
		}

		public function set parrams(value:Array):void {
			_parrams = value;
		}

		public function get timeOut():uint {
			return _timeOut;
		}

		public function set timeOut(value:uint):void {
			_timeOut = value;
		}

		public function get command():String {
			return _command;
		}

		public function set command(value:String):void {
			_command = value;
		}

	}
}