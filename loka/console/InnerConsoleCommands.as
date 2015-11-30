package loka.console {
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	import flash.geom.Point;
	import flash.system.Capabilities;
	
	import loka.asUtils.FPSGraphic;
	import loka.console.utils.ui.HighLightElements;
	import loka.console.utils.ui.harlemShake.HarlemShake;
	import loka.drags.Drags;
	/**
	 * ...
	 * @author LoKa
	 */
	internal class InnerConsoleCommands {
		private var stage:Stage;
		public function InnerConsoleCommands() {
			super();
			this.stage = ConsoleConfig.globalInstance.stage;
			ConsoleCommand.registerCommand(
				"help",
				help,
				"Has print all command name and it description"
			);
			ConsoleCommand.registerCommand(
				"clear",
				Console.instance.clear,
				"Clear Console window"
			);
			ConsoleCommand.registerCommand(
				"___showConsoleCommandLine",
				___showConsoleCommandLine,
				"show Console CommandLine",
				ConsoleCommand.getHotKey(192)
			);
			ConsoleCommand.registerCommand(
				"___showConsole",
				___showConsole,
				"show Console",
				ConsoleCommand.getHotKey(192, true)
			);

			ConsoleCommand.registerCommand(
				"___openConsoleBySteam1",
				___showConsoleWithNewStream,
				"show Console on 1 steam",
				ConsoleCommand.getHotKey(49, true, false)
			);

			ConsoleCommand.registerCommand(
				"___openConsoleBySteam2",
				___showConsoleWithNewStream,
				"show Console on 2 steam",
				ConsoleCommand.getHotKey(50, true, false)
			);

			ConsoleCommand.registerCommand(
				"___openConsoleBySteam3",
				___showConsoleWithNewStream,
				"show Console on 3 steam",
				ConsoleCommand.getHotKey(51, true, false)
			);

			ConsoleCommand.registerCommand(
				"___openConsoleBySteam4",
				___showConsoleWithNewStream,
				"show Console on 4 steam",
				ConsoleCommand.getHotKey(52, true, false)
			);

			ConsoleCommand.registerCommand(
				"___openConsoleBySteam5",
				___showConsoleWithNewStream,
				"show Console on 5 steam",
				ConsoleCommand.getHotKey(53, true, false)
			);

			ConsoleCommand.registerCommand(
				"___openConsoleBySteam6",
				___showConsoleWithNewStream,
				"show Console on 6 steam",
				ConsoleCommand.getHotKey(54, true, false)
			);

			ConsoleCommand.registerCommand(
				"___openConsoleBySteam7",
				___showConsoleWithNewStream,
				"show Console on 7 steam",
				ConsoleCommand.getHotKey(55, true, false)
			);

			ConsoleCommand.registerCommand(
				"___openConsoleBySteam8",
				___showConsoleWithNewStream,
				"show Console on 8 steam",
				ConsoleCommand.getHotKey(56, true, false)
			);

			ConsoleCommand.registerCommand(
				"showFPSGraph",
				showFPSGraph,
				"show Console on 9 steam",
				ConsoleCommand.getHotKey(68, true, true, true)
			);

			ConsoleCommand.registerCommand(
				"hightLightElements",
				hightLightElements,
				"Hight Light Elements",
//				ConsoleCommand.getHotKey(72, true, true, true)
				ConsoleCommand.getHotKey(72, true)
			);
			ConsoleCommand.registerCommand(
				"harlemShake",
				harlemShake,
				"run harlemShake"
			);
			ConsoleCommand.registerCommand("startDragByClick",
				startDragByClick,
				"by click down with CTRL on DisplayObject then it must draget",
				ConsoleCommand.getHotKey(68, true)
			);
			ConsoleCommand.registerCommand("setFrameRate",
				setFrameRate,
				"set frame rate"
			);
		}

		private static var isStartDragByClick:Boolean = false;
		private function startDragByClick():* {
			isStartDragByClick = !isStartDragByClick;
			if (isStartDragByClick) {
				stage.addEventListener(MouseEvent.MOUSE_DOWN, onStartDrag, true, 1);
				stage.addEventListener(MouseEvent.MOUSE_UP, onStartDragEnd, true, 1);
			} else {
				stage.removeEventListener(MouseEvent.MOUSE_DOWN, onStartDrag, true);
			}
		}
		
		protected function onStartDragEnd(event:MouseEvent):void {
			var arr:Array = stage.getObjectsUnderPoint(new Point(stage.mouseX, stage.mouseY));
			if (arr.length) {
				var DO:DisplayObject = DisplayObject(arr[arr.length - 1]);
				Drags.dieDrag(DO);
			}
			
		}
		
		protected function onStartDrag(event:MouseEvent):void {
			if (event.ctrlKey) {
				var arr:Array = stage.getObjectsUnderPoint(new Point(stage.mouseX, stage.mouseY));
				if (arr.length) {
					var DO:DisplayObject = DisplayObject(arr[arr.length - 1]);
					new Drags(DO).zOrdered(false).start();
				}
			}
		}
		
		private function harlemShake():void {
			new HarlemShake(stage);
		}
		
		private var _hightLightElementsInstance:HighLightElements;
		private var _hightLightElements:Boolean = false;
		private function hightLightElements():void {
			_hightLightElements = !_hightLightElements;
			Console.write("hightLightElements" + _hightLightElements);
			if(!_hightLightElementsInstance){
				_hightLightElementsInstance = new HighLightElements(stage);
			}
			_hightLightElements? _hightLightElementsInstance.initHightLight() : _hightLightElementsInstance.removeHightLight();
			
		}
		private function setFrameRate(arr:Object = 30):void {
			stage.frameRate = Number(arr);
		}

		private static var _graph:FPSGraphic;
		private function showFPSGraph(arr:Object = null):void {
			if(!_graph) {
				_graph = new FPSGraphic();
			}
			
			if(_graph.parent) {
				stage.removeChild(_graph);
			} else {
				stage.addChild(_graph);
			}
		}
		
		private function ___showConsole(arr:Object = null):void {
			Console.instance.openConsole();
		}
		
		private function ___showConsoleWithNewStream(inputData:Object = null):void {
			var stream:uint = 1;
			if(inputData && inputData["KEY"])
			{
				switch(inputData["KEY"]){
					case 49:
						stream = 1;
						break;
					case 50:
						stream = 2;
						break;
					case 51:
						stream = 3;
						break;
					case 52:
						stream = 4;
						break;
					case 53:
						stream = 5;
						break;
					case 54:
						stream = 6;
						break;
					case 55:
						stream = 7;
						break;
					case 56:
						stream = 8;
						break;
				}
			}
			Console.instance.showHidenConsole(stream);
		}
		
		private function ___showConsoleCommandLine(arr:* = null):void {
			Console.instance.openCommandLine()
		}
		
		private function help(arr:Object = null):void {
			this.helpTrace(ConsoleCommand.commands);
		}
		
		private function helpTrace(value:Object):void {
			var paddings:String = Utils.getWhiteSpace(5);
			Console.write("Console version:        ",	Console.GREEN,	false,	Console.instance.getCurrentStream());
			Console.write(Console.VERSION,				Console.YELLOW,	true,	Console.instance.getCurrentStream());
			Console.write("Flash Player version:   ",	Console.RED,	false,	Console.instance.getCurrentStream());
			Console.write(Capabilities.version,			Console.YELLOW,	true,	Console.instance.getCurrentStream());
			if(ExternalInterface.available) {
				Console.write("WebBrouser:             ",	Console.RED,	false,	Console.instance.getCurrentStream());
				var userAgent:String = ExternalInterface.call("window.navigator.userAgent.toString");
				Console.write(userAgent, 	Console.YELLOW,	true,	Console.instance.getCurrentStream());
			}
			
			Console.write("Commands:{",					Console.YELLOW,	true,	Console.instance.getCurrentStream());
			for (var key:String in value) {
				Console.write(paddings + ConsoleConfig.COMMAND_NAME,			Console.GREEY,	false, Console.instance.getCurrentStream());
				Console.write(key + " ", 										Console.GREEN,	true, Console.instance.getCurrentStream());
				
				Console.write(paddings + ConsoleConfig.COMMAND_DESCRITION,		Console.GREEY,	false, Console.instance.getCurrentStream());
                var value2:Command = value[key];
                Console.write(value2.comment + " ",								Console.WHITE,	true, Console.instance.getCurrentStream());
				
				if (value2.hotKey) {
                    var hotKey:Object = value2.hotKey;
					Console.write(paddings + ConsoleConfig.COMMAND_HOT_KEY,			Console.GREEY,	false,	Console.instance.getCurrentStream());
					
					Console.write(ConsoleConfig.KEY + ": ", 						Console.WHITE, 	false,	Console.instance.getCurrentStream());
					Console.write("" + hotKey[ConsoleConfig.KEY], 			Console.YELLOW, false,	Console.instance.getCurrentStream());
					Console.write(", ", 											Console.RED, 	false,	Console.instance.getCurrentStream());
					
					Console.write(ConsoleConfig.CTRL + ": ",						Console.WHITE,	false,	Console.instance.getCurrentStream());
					Console.write("" + hotKey[ConsoleConfig.CTRL],			Console.YELLOW,	false,	Console.instance.getCurrentStream());
					Console.write(", ",												Console.RED,	false,	Console.instance.getCurrentStream());
					
					Console.write(ConsoleConfig.SHIFT + ": ",						Console.WHITE,	false,	Console.instance.getCurrentStream());
					Console.write("" + hotKey[ConsoleConfig.SHIFT],			Console.YELLOW,	false,	Console.instance.getCurrentStream());
					Console.write(", ",												Console.RED,	false,	Console.instance.getCurrentStream());
					
					Console.write(ConsoleConfig.ALT + ": ",							Console.WHITE,	false,	Console.instance.getCurrentStream());
					Console.write("" + hotKey[ConsoleConfig.ALT],			Console.YELLOW,	true,	Console.instance.getCurrentStream());
					
				}
				
				Console.write("     ", Console.GREEY, true, Console.instance.getCurrentStream());
			}
			
			Console.write("}", Console.YELLOW, true, Console.instance.getCurrentStream());
		}
	}

}