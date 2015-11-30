package utils.loka.console {
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.TextEvent;
	import flash.geom.Rectangle;
	import flash.net.SharedObject;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	
	public class CommandLine extends Sprite {
		private var _commmandLineBox:TextField;
		private var _tf:TextFormat;
		private static const NAME:String = "CommandLine14785236987456321456987456321598753";
		
		public function CommandLine() {
			super();
			this.init();
			this.initUI();
		}
		
		private function init():void {
			try {
				this.name = NAME;
				this._commmandLineBox = new TextField();
				this._commmandLineBox.type 				= TextFieldType.INPUT;
				this._commmandLineBox.border 			= true;
				this._commmandLineBox.borderColor 		= Console.WHITE;
				this._commmandLineBox.background 		= true;
				this._commmandLineBox.backgroundColor 	= Console.GREEY_BLACK;
				this._commmandLineBox.multiline 		= false;
				this._commmandLineBox.wordWrap 			= false;
				this._commmandLineBox.name 				= "commmandLineBox"; 
				
				this._commmandLineBox.addEventListener(TextEvent.TEXT_INPUT, commmandLineBoxEnterKey);
				this._commmandLineBox.addEventListener(FocusEvent.FOCUS_OUT, commmandLineBoxFocusOut);
				ConsoleConfig.globalInstance.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyListner)
				ConsoleConfig.globalInstance.stage.addEventListener(KeyboardEvent.KEY_UP, keyListnerUp)
				
				this._tf = new TextFormat("Courier New", 12, Console.WHITE);
				
				this._commmandLineBox.defaultTextFormat = this._tf;
				
				if(Console.instance.getProperty("CommandLine.historyList")) {
					this.historyList = Console.instance.getProperty("CommandLine.historyList");
				}
				
			} catch(e:Error) {
				ConsoleCommand.CallLater(this, init);
			}
		}
		
		private function keyListnerUp(e:KeyboardEvent):void {
			if (this._commmandLineBox.text == "`") {
				this._commmandLineBox.text = "";
			}
			
			if (e.keyCode == 9) {
				if (ConsoleConfig.globalInstance.contains(this)) {
					this.focus(true);
				}
			}
		}
		
		private function keyListner(e:KeyboardEvent):void {
			trace("altKey: " + e.altKey + "altKey: " + e.shiftKey + " ctrlKey: " + e.ctrlKey + " keyCode: " + e.keyCode);
			//if user key pressed Down
			if (!ConsoleConfig.enabled) {
				return;
			}
			
			if (e.keyCode == 40) {
				this.historyDownShow();
			}
			//if user key pressed Up
			if (e.keyCode == 38) {
				this.historyUpShow();
			}
			//if user key pressed TAB
			if (e.keyCode == 9) {
				this.autoComplete();
			}
			//if user key pressed ENTER
			if (e.keyCode == 13) {
				this.commmandLineBoxHandler();
			}
			this.listenningHotKey(e.keyCode, e.ctrlKey, e.shiftKey, e.altKey);
		}
		
		private function initUI():void {
			this.addChild(this._commmandLineBox);
		}
		
		public function set(value:String = ""):void {
			this._commmandLineBox.text = value;
		}
		
		public function focus(value:Boolean = false):void {
			var _stage:Stage = ConsoleConfig.globalInstance.stage;
			if (_stage && value) {
				if(ConsoleConfig.globalInstance.stage.contains(this) && this._commmandLineBox.visible) {
					if(_stage.focus !== this._commmandLineBox){
						_stage.focus = this._commmandLineBox;
					}
				} else {
					_stage.focus = ConsoleConfig.globalInstance.stage;
				}
			} else if (_stage) {
				_stage.focus = ConsoleConfig.globalInstance.stage;
			}
		}
		
		protected function commmandLineBoxFocusOut(event:FocusEvent):void {
			var _stage:Stage = ConsoleConfig.globalInstance.stage;
			if(event.relatedObject === _stage) {
				focus(true);
			}
		}
		
		
		public function set position(value:Rectangle):void {
			this.x = value.x;
			this.y = value.y;
			this._commmandLineBox.width = value.width;
			this._commmandLineBox.height = value.height;
		}
		
		public function commmandLineBoxEnterKey(event:TextEvent):void {
			this.userKeyEnter = true;
			if (event.text == '`') {
				this.set();
			}
		}
		
		public function commmandLineBoxHandler():void {
			if (this._commmandLineBox.text == "") {
				return;
			}
//			trace("enter");
			var str:String = this._commmandLineBox.text;
			var firstChar:String = str.charAt(0); 
			if(firstChar == "\n" || firstChar == "\r") {
				str = str.substr(1, str.length - 1);
			}
			Console.write(str, Console.WHITE, true, Console.instance.getCurrentStream());
			var arrStr:Array = str.split(" ", 2)
			var args:Array = []; 
			if(arrStr.length > 1) {
				var paramsStr:String = str.substr(arrStr[0].toString().length)
				args = Utils.getParamsWithStrings(paramsStr);
				str = arrStr[0].toString();
			}
			
			this.addHistoryCommandString(this._commmandLineBox.text);
			ConsoleCommand.commandDo(str, args);
			this._commmandLineBox.text = "";
			
		}
		
		
		private function historyUpShow():void {
			this._commmandLineBox.text = this.getHistoryUpCommandString();
		}
		
		private function historyDownShow():void {
			this._commmandLineBox.text = this.getHistoryDownCommandString();
		}
		
		private function autoComplete():void {
			if (this._commmandLineBox.text == "") {
				return;
			}
			//var str:String = 
			this._commmandLineBox.text = this.getAutoComleteTextByKey(this._commmandLineBox.text);
			this.focus(true);
			this._commmandLineBox.setSelection(this._commmandLineBox.length, this._commmandLineBox.length )
		}
		
		/*-=-=-=-=-=-=-=-=-=-=-=-=CommandLine autoComplete-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
		protected var userKeyEnter:Boolean = false;
		private var keyListener:uint = 0;
		private var keySaved:String = "";
		
		protected function getAutoComleteTextByKey(key:String):String {
			var subKey:String = key.substr(0, keySaved.length);
			if (this.keySaved != "" && this.keySaved == subKey && !this.userKeyEnter) {
				key	= keySaved;
			} else {
				keyListener			= 0;
				this.keySaved		= key;
				this.userKeyEnter	= false;
			}
			if (this.getListForCommandsByKey(key)[keyListener]) {
				var result:String	= this.getListForCommandsByKey(key)[keyListener];
				keyListener ++;
				return result;
			} else {
				keyListener	= 0;
				return key;
			}
		}
		/*-=-=-=-=-=-=-=-=-=-=-=-=CommandLine historyShow End=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
		
		
		
		private function getListForCommandsByKey(key:String = ""):Array {
			var keyLength:uint = key.length;
			var arrResult:Array = [];
			for (var c:String in ConsoleCommand.commands) {
				var subCommandName:String = c.substr(0, keyLength);
				if (subCommandName == key) {
					arrResult.push(c);
				}
			}
			return arrResult;
		}
		
		/*-=-=-=-=-=-=-=-=-=-=-=-=CommandLine autoComplete end-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
		
		/*-=-=-=-=-=-=-=-=-=-=-=-=CommandLine hot key do End-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
		
		/*-=-=-=-=-=-=-=-=-=-=-=-=CommandLine historyShow=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
		private var historyList:Array = [];
		private var historyKey:uint = 0;
		private var _sharedObjectProperties:SharedObject;
		protected function addHistoryCommandString(command:String):void {
			 
			var addCommand:Boolean = true;
			var commandIndex:uint = 0;
			for (var c:String in this.historyList) {
				if (this.historyList[c] == command) {
					addCommand = false;
					commandIndex = int(c);
				}
			}
			if (addCommand) {
				// !?!?!?!?
			} 
			else {
				this.historyList.splice(commandIndex, 1);
			}
			this.historyList.push(command);
			historyKey = this.historyList.length - 1;
			
			Console.instance.setProperty("CommandLine.historyList", this.historyList);
		}
		
		protected function getHistoryDownCommandString():String {
			var result:String = "";
			if (this.historyList[this.historyKey]) {
				result = String(this.historyList[this.historyKey ++]);
			} else {
				result = "";
				historyKey = 0;
			}
			return result;
		}
		
		protected function getHistoryUpCommandString():String {
			var result:String = "";
			if (this.historyList[this.historyKey]) {
				result = String(this.historyList[this.historyKey --]);
			} else {
				result = "";
				historyKey = this.historyList.length - 1;
			}
			return result;
		}
		
		/*-=-=-=-=-=-=-=-=-=-=-=-=CommandLine hot key do-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
		protected function listenningHotKey(key:uint, ctrl:Boolean = false, shift:Boolean = false, alt:Boolean = false):void {
			for each (var command:Command in ConsoleCommand.commands) {
				if (command.hotKey) {
					if (
						command.hotKey[ConsoleConfig.KEY] == key 
						&& 
						command.hotKey[ConsoleConfig.CTRL] == ctrl 
						&& 
						command.hotKey[ConsoleConfig.SHIFT] == shift
						&& 
						command.hotKey[ConsoleConfig.ALT] == alt
					) {
						ConsoleCommand.commandDo(command.name, [command.hotKey]);
					}
				}
			}
		}
	}
}