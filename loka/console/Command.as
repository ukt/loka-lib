package utils.loka.console {
	internal class Command {
		private var _name:String;

		private var _command:Function;
		private var _comment:String;
		private var _hotKey:Object;
		public function Command(name:String, command:Function, comment:String = "", hotKey:Object = null) {
			this._name = name;
			this._command = command;
			this._comment = comment;
			this._hotKey = hotKey;
		}
		public function call(params:Array = null):Object {
			try {
				if(_command.length > 0) {
					if(params is Array){
						return _command.apply(null, params);
					} else {
						return _command.call(null, params);
					}
				} else {
					return _command.call();
				}
			} catch (e:Error) {
				Console.write(ConsoleConfig.ERROR_COMMAND,	Console.RED,				false,	Console.instance.getCurrentStream());
				Console.write(name + ": ",					Console.BLUE_LIGHT,			false,	Console.instance.getCurrentStream());
				Console.write(_command,						Console.GREEN,				true,	Console.instance.getCurrentStream());
				Console.write("Error: " + e.errorID,		Console.RED,				false,	Console.instance.getCurrentStream());
				Console.write(", " + e.name,				Console.RED,				false,	Console.instance.getCurrentStream());
				Console.write(", " + e.message, 			Console.RED,				false,	Console.instance.getCurrentStream());
				Console.write(", " + e.getStackTrace(), 	Console.RED,				true,	Console.instance.getCurrentStream());
				
			}
			return null;
		}
		public function get hotKey():Object {
			return _hotKey;
		}

		public function get comment():String {
			return _comment;
		}

		public function get command():Function {
			return _command;
		}

		public function get name():String {
			return _name;
		}
	}
}