package loka.console {
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	
	public class ConsoleCommand {
		public static var commands:Dictionary;
		public static function CallLater(instance:*, fCall:Function, ...args):void {
			var timer:Timer = new Timer(1000 * 5, 1);
			timer.addEventListener(TimerEvent.TIMER, 
			function(e:TimerEvent):void {
				fCall.call(null, args);
			});
			timer.start();
		}
		
		public static function deleteCommand(command:Object):Boolean {
			instance;
			if(hasCommand(command)) {
				delete commands[getCommand(command).name];
				return true;
			}
			return false;
		}
		
		public static function hasCommand(command:*):Boolean {
			return getCommand(command) != null;
		}
		
		public static function getCommand(command:*):Command {
			if(command is String && commands[command]){
				return commands[command];
			} else if(command is Function){
				for (var key:String in commands) {
					if(commands[key][0] === command) {
						commands[key];
					}
				}
			}
			return null;
		}
		public static function registerCommand(name:String, command:Function, comment:String = "", hotKey:Object = null):void {
			instance;
			if(commands[name]) {
				Console.write(ConsoleConfig.ERROR_NEW_COMMAND, Console.RED, false, Console.instance.getCurrentStream());
				Console.write(" " + name, Console.RED, true, Console.instance.getCurrentStream());
				return;
			}
			commands[name] = new Command(name, command, comment, hotKey);//[command, comment, name, hotKey];
		}
		
		/**
		 * 
		 * @param name - name of command to return
		 * 
		 */
		public static function getCommandByName(name:String):Function {
			return (commands[name][0] as Function);
		}
		/**
		 * don't use in all project, only consol; 
		 * @param name = is name a command to do in console
		 * @param params = has set in command; please write the parameters through the space
		 * 
		 */
		public static function commandDo(name:String, params:Array = null):Object {
			instance;
			if(hasCommand(name)) {
				return getCommand(name).call(params);
			} else {
				Console.write(ConsoleConfig.ERROR_COMMAND_DO, Console.RED, true, Console.instance.getCurrentStream());
				Console.write("Command:	" +	name.toString(), Console.BLUE_LIGHT, true, Console.instance.getCurrentStream());
				if(params && params.length > 0) {
					Console.write(	"params:	" +	params.toString(),Console.YELLOW, true, Console.instance.getCurrentStream());
				}
			}
			return null;
		}
		
		static public function getHotKey(key:uint, ctrl:Boolean = false, shift:Boolean = false, alt:Boolean = false):Object {
			var result:Object = {
					CTRL	: ctrl,
					SHIFT	: shift,
					KEY		: key,
					ALT		: alt
				}
			return result;
		}
		
		static private var _instance:ConsoleCommand;
		static public function get instance():ConsoleCommand { 
			if(ConsoleCommand._instance == null) {
				_instance = new ConsoleCommand();
			}
			return _instance; 
		}
		
		public function ConsoleCommand()  {
			if(ConsoleCommand._instance != null) {
				throw(new Error("Singleton is a singleton class, use instance() instead."));
			}
			ConsoleCommand._instance = this;
			this.init();
		}
		
		private function init():void {
			commands = new Dictionary();
			new InnerConsoleCommands();
		}
	}
}