package utils.loka.console {
	import flash.display.DisplayObjectContainer;
	import flash.display.StageAlign;
	import flash.events.Event;
	import flash.filters.GlowFilter;
	import flash.geom.Rectangle;
	import flash.net.SharedObject;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.getTimer;
	
	import utils.loka.console.utils.ui.DisplaObjectAutoAlign;
	
	/**
	 * version 3.0.0.3
	 */
	public class Console implements IConsole {
		protected var _console: Vector.<TextField>;
		
		protected static var _backGroundMC: BackgroundConsole;
		private var backGroundMCAutoAlign:DisplaObjectAutoAlign;
		protected static var _consoleCommandLine: CommandLine;
		protected static var _consoleCommandLineHeight:	Number = 20;
		protected static var _tf: TextFormat;
		private static var globalInstance:DisplayObjectContainer;
		public static const tabSpace:uint = 5;
		public static var RED:uint = 			0xFF0000;
		public static var ORANGE:uint = 		0xFB7100;
		public static var GREEN:uint = 			0x00FF00;
		public static var BLUE:uint = 			0x0000ff;
		public static var BLUE_LIGHT:uint = 	0x00FFFF;
		public static var ROZE:uint = 			0xFF00FF;
		public static var YELLOW:uint = 		0xFFFF00;
		public static var BLACK:uint = 			0x000000;
		public static var GREEY_BLACK:uint = 	0x333333;
		public static var GREEY_DARK:uint = 	0x666666;
		public static var GREEY:uint = 			0x999999;
		public static var GREEY_LIGHT:uint = 	0xAAAAAA;
		public static var GREEY_WHITE:uint = 	0xCCCCCC;
		public static var WHITE:uint = 			0xFFFFFF;
		
		public static var VERSION:String = "3.0.0.6";
		
		private static const NAME:String = 		"console14785236987456321456987456321598753";
		
		
		public static var COLORS:Array = [RED, GREEN, BLUE, BLUE_LIGHT, ROZE, YELLOW, GREEY, GREEY_LIGHT, GREEY_WHITE, WHITE];
		
		
		public function get console():TextField {
			if(
				_currentStream
				&&
				_console 
				&& 
				(
					!_console.length 
					|| 
					_console.length < _currentStream 
					|| 
					!_console[_currentStream - 1]
				)
			) {
				hideConsoles();
				_console.push(new TextField());
				initConsoleTF();
				_console[_currentStream - 1].visible = false;
				console;
			} else if(_currentStream == 0){
				_currentStream = 1;
			}
			
			return _console[_currentStream - 1];
		}
		
		private function initConsoleTF():void {
			console.wordWrap 				= true;
			console.antiAliasType 			= AntiAliasType.ADVANCED;
			console.defaultTextFormat 		= _tf;
			console.filters 				= [_tfFilter];
			console.name = "console";
		}
		
		public static function get anyColor():uint {
			return COLORS[uint(Math.random()*(COLORS.length - 1))];
		}
		
		private static var _stringWrite:String = "";
		
		static private var _instance:Console;
		
		private var _timeDoing:Number;
		private var _isShowConsole:Boolean 				= false;
		private var _isShowConsoleCommandLine:Boolean	= false;
		private var _currentStream:uint = 1;
		
		
		static public function get instance():IConsole { 
			if(Console._instance == null) {
				_instance = new Console();
			}
			return _instance; 
		}
		
		public function set enabled(value:Boolean):void {
			ConsoleConfig.enabled = value;
		}
		
		/**
		 * 
		 * @param value
		 * @param color
		 * @param wrap
		 * @param stream need improove this parrams
		 * @return 
		 * 
		 */
		public function write(value:Object, color:uint = 0xFFFFFF, wrap:Boolean = true, stream:uint = 1):String	{
			if(_backGroundMC) {
				_timeDoing = getTimer();
				changeStream(stream);
				
				writeInner(value, color, tabSpace, wrap);
				updateStage();
				return getStringWrite();
			} else {
				Console.write(value, color, wrap, stream);
			}
			return value.toString();
		}
		/**
		 * 
		 * @param value
		 * @param color
		 * @param wrap
		 * @param stream need improove this parrams
		 * @return 
		 * 
		 */
		private static var _writeListBeforeInit:Vector.<ConsoleEvent> = new Vector.<ConsoleEvent>();
		public static function write(value:Object, color:uint = 0xFFFFFF, wrap:Boolean = true, stream:uint = 1):void {
			var meessage:ConsoleEvent = new ConsoleEvent(ConsoleEvent.WRITE_IN_CONSOLE, "", color, wrap, value, stream);
			if(globalInstance && globalInstance.stage) {
				globalInstance.stage.dispatchEvent(meessage);
			}
			else {
				_writeListBeforeInit.push(meessage)
			}
		}
		
		public function getCurrentStream():uint {
			return _currentStream;
		}
		
		public function showHidenConsole(stream:uint):void {
			if((stream == _currentStream || !_isShowConsole) && !_backGroundMC.visible) {
				_isShowConsole = ! _isShowConsole;
			}
			changeStream(stream);
			showCurrentConsole();
		}
		
		public function changeStream(stream:uint):void {
			if(stream != _currentStream || !_backGroundMC.visible) {
				hideConsoles();
				_currentStream = stream;
				console;
				showCurrentConsole();
			}
		}
		
		private static function getStringWrite():String {
			var str:String = _stringWrite;
			_stringWrite = "";
			return str;
		}
		
		public function Console() {
			super();
			if(Console._instance != null) {
				throw(new Error("Singleton is a singleton class, use instance() instead."));
			}
			
			Console._instance = this;
		}
		
		public static function init(instance:DisplayObjectContainer, enable:Boolean = true):void {
			Console.instance;
			_instance.init(instance, enable);
			
		}
		
		private function hideAll():void {
			hideConsoles();
			_backGroundMC.visible = false;
			_consoleCommandLine.visible = false;
		}
		private function hideConsoles():void {
			for each(var console:TextField in _console) {
				console.visible = false;
				console.selectable = false;
				console.alpha = 1;
				console.mouseEnabled = true;
			}
		}
		
		private function showCurrentConsole():void {
			_backGroundMC.addChild(_console[_currentStream - 1]);
			_backGroundMC.update();
			
			_console[_currentStream - 1].visible = _isShowConsole;
			_console[_currentStream - 1].selectable = _backGroundMC.backGround.visible ? true : false;
			_console[_currentStream - 1].alpha = _backGroundMC.backGround.visible ? 1 : .5;
			_console[_currentStream - 1].mouseEnabled = _backGroundMC.backGround.visible ? true : false;
			
			_tfFilter.quality = (_backGroundMC.backGround.visible && _isShowConsole) ? 2 : 1;
			_tfFilter.blurX = _tfFilter.blurX = (_backGroundMC.backGround.visible && _isShowConsole) ? 3 : 2;
			_backGroundMC.backGround.visible = _console[_currentStream - 1].selectable;
		}
		
		public function openCommandLine():void {
			_isShowConsoleCommandLine = !_isShowConsoleCommandLine;
			if (_isShowConsoleCommandLine) {
				_consoleCommandLine.visible = true;
				_backGroundMC.visible = true;
				_backGroundMC.hideAllButThis(_consoleCommandLine);
			} else {
				_consoleCommandLine.visible = false;
				_backGroundMC.visible = false;
				_backGroundMC.backGround.visible = false;
			}

			Console.instance.update();
		}
		
		public function openConsole():void {
			_isShowConsole = !_isShowConsole;
			if (_isShowConsole) {
				_backGroundMC.visible = true;
				showCurrentConsole();
				_backGroundMC.addChild(_consoleCommandLine);
				ConsoleConfig.globalInstance.stage.addChild(_backGroundMC);
				_consoleCommandLine.visible = true;
			} else if(_backGroundMC.visible && _console[_currentStream - 1].visible) {
				hideAll();
			}
			
			update();
			
		}
		
		public function updateStage():void {
			update();
		}
		
		public function init(instanceDOC:DisplayObjectContainer, enable:Boolean = true):void {
			try {
				_previousAlign = instanceDOC.stage.align == null ? StageAlign.TOP : instanceDOC.stage.align;
				ConsoleConfig.enabled							= enable;
				
				globalInstance = ConsoleConfig.globalInstance = instanceDOC;
				ConsoleCommand.instance;
				if(!globalInstance.stage.getChildByName(NAME)) {
					_console = new Vector.<TextField>();
					_backGroundMC = new BackgroundConsole();
					backGroundMCAutoAlign = new DisplaObjectAutoAlign(globalInstance.stage, _backGroundMC); 
					_tf 							= new TextFormat("Courier New", 12, 0x94D35A);
					_tf.leading 					= -3;
					
					_consoleCommandLine 			= new CommandLine();
					_consoleCommandLine.visible 	= false;
					_consoleCommandLine.name = NAME;
					globalInstance.stage.addChild(_backGroundMC);
					_backGroundMC.addChild(_consoleCommandLine);
					_backGroundMC.visible = false;
					
					globalInstance.stage.addEventListener(Event.RESIZE, reposCanvas, false, 1);
					globalInstance.stage.addEventListener(ConsoleEvent.WRITE_IN_CONSOLE, sniffer);
					
					writeBeforeInitMessages();
				}
			}
			catch(e:Error) {
				ConsoleCommand.CallLater(this, init, instanceDOC, enable);
			}
		}
		
		private function writeBeforeInitMessages():void	{
			for each(var meessage:ConsoleEvent in _writeListBeforeInit) {
				globalInstance.stage.dispatchEvent(meessage);
			}
		}
		
		protected function sniffer(event:Event):void {
			var data:ConsoleEvent;
			if(!(event is ConsoleEvent)) {
				data = new ConsoleEvent();
				data.data 	= event.hasOwnProperty("data") ? event["data"] : event.currentTarget.hasOwnProperty("data") ? event.currentTarget["data"] : null;
				data.text 	= event.hasOwnProperty("text") ? event["text"] : event.currentTarget.hasOwnProperty("text") ? event.currentTarget["text"] : null;
				data.wrap 	= event.hasOwnProperty("wrap") ? event["wrap"] : event.currentTarget.hasOwnProperty("wrap") ? event.currentTarget["wrap"] : null;
				data.color 	= event.hasOwnProperty("color") ? event["color"] : event.currentTarget.hasOwnProperty("color") ? event.currentTarget["color"] : null;
				data.stream = event.hasOwnProperty("stream") ? event["stream"] : event.currentTarget.hasOwnProperty("stream") ? event.currentTarget["stream"] : null;
			} else {
				data = event as ConsoleEvent;
			}
			
			if(data.text) {
				write(data.text, data.color, data.wrap, data.stream);
			} else if(data.data != null) {
				write(data.data, data.color, data.wrap, data.stream);
			}
		}
		
		public function update():void {
			if(ConsoleConfig.enabled) {
				globalInstance.stage.dispatchEvent(new Event(Event.RESIZE));
			}
		}
		
		private var _previousAlign:String = null; 
		private function reposCanvas(e:Event = null):void {
			stopImmediatePropagation(e);
			try {
				setProportionForConsole()
				_consoleCommandLine.focus(_consoleCommandLine.visible);
				_backGroundMC.update();
			} catch(error:Error) {
				trace("reposCanvas.error: " + error);
			}
		}
		
		private function setProportionForConsole():void {
			console.width = _backGroundMC.width;
			console.height = _backGroundMC.height - _consoleCommandLineHeight;
			_consoleCommandLine.position = new Rectangle(
				0, 
				_backGroundMC.height - _consoleCommandLineHeight,
				_backGroundMC.width, 
				_consoleCommandLineHeight
			);
		}
		
		private function stopImmediatePropagation(e:Event):void {
			if(e) {
				e.stopImmediatePropagation();
				e.stopPropagation();
			}
		}
		
		private function writeInner(value:Object, color:uint = 0xFFFFFF, paddingWhiteSpaceNum:int = tabSpace, wrap:Boolean = true):void {
			
			if(_timeDoing - getTimer() > 1000 * time) {
				writeInner("very long time to wrote", RED);
				return;
			}
			
			if (!ConsoleConfig.enabled) {
				return;
			}
			
			if(
				value is String 
				|| 
				value is Number
				||
				value is Boolean
				||
				value is XML
			) {
				this.writeString(value + Utils.getWrapStr(wrap, value.toString()), color);
				return; 
			}
			
			if(value is Object) {
				this.writeObject(Utils.duplicate(value), color, paddingWhiteSpaceNum);
				return;
			}
		}
		
		private function writeObject(value:Object, color:uint = 0xFFFFFF, paddingWhiteSpaceNum:int = tabSpace):Boolean {
			
			if(getTimer() - _timeDoing > 1000 * time) {
				writeInner("verylong time to wrote", RED);
				return false;
			}
			
			var count:uint					= 0;
			var countProperty:int 			= Utils.getPropertyCount(value);
			var whiteSpaceLength:uint 		= Utils.getMaxPropertyLegthStr(value);
			var whiteSpace:String 			= Utils.getWhiteSpace(whiteSpaceLength + paddingWhiteSpaceNum);
			var paddingWhiteSpace:String 	= Utils.getWhiteSpace(paddingWhiteSpaceNum);
			
			writeString("{\n");
			
			for (var key:String in value) {
				whiteSpace =	Utils.getWhiteSpace(whiteSpaceLength - key.length);
				count ++;
				if (count > 1000) { 
					writeString("Cancel becaus long data!",	RED);
					return false;
				}
				writeString(paddingWhiteSpace + key,	color);
				writeString(": ",						RED);
				if (value[key] is String) {
					writeString(whiteSpace + "\"" + value[key] + "\"",	GREEN);
					writeString(countProperty == count ? " \n" : ",\n",	RED);
				} else if(value[key] is Boolean) {
					writeString(whiteSpace + (value[key] ? "true" : "false"),	BLUE_LIGHT);
					writeString(countProperty == count ? " \n" : ",\n",	RED);					
				} else if(value[key] is Number) {
					writeString(whiteSpace + value[key],				ORANGE);
					writeString(countProperty == count ? " \n" : ",\n",	RED);
				} else if(value[key] is XMLList) {
					writeString(whiteSpace + "\"" + value[key] + "\"",	YELLOW);
					writeString(countProperty == count ? " \n" : ",\n",	RED);
				} else {
					if(!writeObject(value[key], color, paddingWhiteSpaceNum + tabSpace)) {
						return false;
					}
				}
			}
			
			writeString(Utils.getWhiteSpace(paddingWhiteSpaceNum - tabSpace) + "},\n");
			return true;
		}
		
		private function writeString(value:String, color:uint = 0xFFFFFF):void {
			
			if (value == "" || value == "\n" || !ConsoleConfig.enabled) {
				return;
			}
			
			_stringWrite += value;
			var consoleLength:uint = console.numLines;  
			if (consoleLength > 2000) {
				var length:uint = console.numLines - 1000;
				console.replaceText(0, 10000, "");
				this.writeString("\nsub text in console\n", 0x00ff00);
			}
			
			consoleLength = console.length;
			
			console.appendText(value.toString());
			
			if (color != 0) {
				_tf.color = color;
				console.setTextFormat(_tf, consoleLength, console.length);
			} else if(color > 16777215) {
				_tf.color = RED;
				console.setTextFormat(_tf, consoleLength, console.length);
			} else {
				_tf.color = BLACK;
				console.setTextFormat(_tf, consoleLength, console.length);
			}
			
			console.scrollV = console.maxScrollV;
		}
		
		public function clear():void {
			if(_console)console.text = "";
		}
		
		private var _tfFilter:GlowFilter = new GlowFilter(BLACK, 1, 3, 3, 12, 1);
		private var _consoleProperties:SharedObject;
		private var _time:int = 1;

		private function get consoleProperties():SharedObject {
			if(!_consoleProperties) _consoleProperties = SharedObject.getLocal(NAME);
			return _consoleProperties;
		}
		
		public function setProperty(name:String, value:*):void {
			consoleProperties.data[name] = value;
			consoleProperties.flush();
		}
		
		public function getProperty(name:String):* {
			return consoleProperties.data[name];
		}
		
		public function deleteProperty(name:String):void {
			delete consoleProperties.data[name];
			consoleProperties.flush();
		}
		
		public function get time():int {
			return _time;
		}
		
		public function set time(value:int):void {
			_time = value;
		}
	}
}