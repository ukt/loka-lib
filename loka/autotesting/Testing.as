package utils.loka.autotesting {
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.InteractiveObject;
import flash.display.Loader;
import flash.display.LoaderInfo;
import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.display.Sprite;
import flash.display.Stage;
import flash.display.StageAlign;
import flash.events.ErrorEvent;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.events.UncaughtErrorEvent;
import flash.external.ExternalInterface;
import flash.filters.GlowFilter;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.system.Security;
import flash.utils.ByteArray;
import flash.utils.Dictionary;
import flash.utils.clearTimeout;
import flash.utils.getTimer;
import flash.utils.setInterval;
import flash.utils.setTimeout;

import mx.graphics.codec.JPEGEncoder;
import mx.graphics.codec.PNGEncoder;
import mx.utils.Base64Encoder;

import utils.loka.autotesting.actions.Action;
import utils.loka.autotesting.actions.data.parser.JsonActionDataParser;
import utils.loka.autotesting.ui.DisplayObjectFab;
import utils.loka.autotesting.utils.searcher.AS3PathSearch;
import utils.loka.console.Console;
import utils.loka.console.ConsoleCommand;
import utils.loka.console.utils.ui.SpriteWithBackground;
import utils.loka.drags.Drags;
import utils.loka.ui.mouse.MouseSimulation;

public class Testing {
	private var root:DisplayObjectContainer;

	private var searcher:AS3PathSearch;

	private var scaleMode:String;
	private var stableFrameRate:int = -1;

	private var align:String;
	private var pathsToDisplayObjectsForAutoClickOnIt:Array = [];
	private var pathsToDisplayObjectsForDoNotAutoClickOnIt:Array = [];

	public function initTesting(root:DisplayObjectContainer):void {
		this.root = root;
		this.root.addEventListener(Event.ADDED, onAdded);
		this.root.loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, onError);

		scaleMode = root.stage.scaleMode;
		align = root.stage.align;

		searcher = new AS3PathSearch(root.stage);

		if(root.stage.loaderInfo.url.split("http").length > 1) {
			Security.allowDomain("*");
			Security.allowInsecureDomain("*");
		}
		root.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
		root.addEventListener(Event.ENTER_FRAME, onEnterFrame);

		Console.write("Auto Testing init", Console.GREEN, false);
		Console.write(" 1.0.11: ", Console.YELLOW, true);
		Console.instance.time = 10;

		initializeCommands();
	}

	public function initializeCommands():void {
		registerCommand("getScreen", getScreen,
				"return screen");
		registerCommand("getScreenAtElement", getScreenAtElement,
				"return screen");
		registerCommand("clearPathToDisplayObjectForAutoClickOnIt", clearPathToDisplayObjectForAutoClickOnIt,
				"on display object added on stage, plugin search it and dispatch click on it");
		registerCommand("addPathToDisplayObjectForAutoClickOnIt", addPathToDisplayObjectForAutoClickOnIt,
				"on display object added on stage, plugin search it and dispatch click on it");
		registerCommand("removePathToDisplayObjectForAutoClickOnIt", removePathToDisplayObjectForAutoClickOnIt,
				"on display object added on stage, plugin search it and dispatch click on it");
		registerCommand("addPathToDisplayObjectForDoNotAutoClickOnIt", addPathToDisplayObjectForDoNotAutoClickOnIt,
				"on display object added on stage, plugin search it and dispatch click on it");
		registerCommand("removePathToDisplayObjectForDoNotAutoClickOnIt", removePathToDisplayObjectForDoNotAutoClickOnIt,
				"on display object added on stage, plugin search it and dispatch click on it");
		registerCommand("clearPathToDisplayObjectForDoNotAutoClickOnIt", clearPathToDisplayObjectForDoNotAutoClickOnIt,
				"on display object added on stage, plugin search it and dispatch click on it");

		registerCommand("getSwfInfo", getSwfInfo,
				"return swf info");
		registerCommand("initializeTraceClick", initializeTraceClick,
				"initialise click hight light ");
		registerCommand("pressKey", pressKey,
				"can dispatch KeyBoardEvent on stage with keyNumber    [pressKey keyNumber]");
		registerCommand("gotoAndPlay", gotoAndPlay,
				"return MovieClip and move it to frame                 [gotoAndPlay 'DOname', 'frame']");
		registerCommand("getDisplayObject", getDisplayObject,
				"return information of DisplayObject                   [getDisplayObject 'DOname']");
		registerCommand("getDisplayObjects", getDisplayObjects,
				"return information of DisplayObject                   [getDisplayObject 'DOname']");
		registerCommand("getDisplayObjectContainer", getDisplayObjectContainer,
				"return information of DisplayObjectConteiner          [getDisplayObjectContainer 'DOname']");
		registerCommand("getDisplayObjectPropertyValue", getDisplayObjectPropertyValue,
				"return value at proprty                               [getDisplayObjectPropertyValue 'DOname', 'DOproperty']");
		registerCommand("setDisplayObjectPropertyValue", setDisplayObjectPropertyValue,
				"set value to proprty                                  [setDisplayObjectPropertyValue 'DOname', 'DOproperty', 'value']");
		registerCommand("click", click,
				"can dispatch mouseEvent with click on element         [click 'DOname']");
		registerCommand("clickNTimes", clickNTimes,
				"can dispatch mouseEvent with click on element N times [clickNTimes 'DOname', 2]");
		registerCommand("getClickStatus", getClickStatus,
				"can return status of click                            [getClickStatus 'id']");
		registerCommand("getMousePosition", getMousePosition,
				"can return mouse position                             [getMousePosition]");
		registerCommand("dispatchMouseEvent", dispatchMouseEvent,
						"can dispatch mouseEvent with event type on element    [dispathMouseEvent 'DOname' '" +
						MouseEvent.CLICK + ", " +
						MouseEvent.MOUSE_DOWN + ", " +
						MouseEvent.MOUSE_MOVE + ", " +
						MouseEvent.MOUSE_OUT + ", " +
						MouseEvent.MOUSE_OVER + ", " +
						MouseEvent.MOUSE_UP + ", " +
						MouseEvent.MOUSE_WHEEL + " " +
						"']");
		registerCommand("issetElement", issetElement,
				"if isset element then return true else false          [issetElement 'DOname']");
		registerCommand("setScaleMode", setScaleMode,
				"need to set stage scale mode; see StageScaleMode      [setScaleMode ScaleMode...]");
		registerCommand("getScaleMode", getScaleMode,
				"need to get stage scale mode; see StageScaleMode");
		registerCommand("setQuality", setQuality,
				"need to set stage quality; see StageAlign             [setScaleMode StageAlign...]");
		registerCommand("setAlign", setAlign,
				"need to set stage align; see StageAlign               [setScaleMode StageAlign...]");
		registerCommand("getAlign", getAlign,
				"need to get stage align; see StageAlign");
		registerCommand("setStableFrameRate", setStableFrameRate,
				"need to set stable frame rate in flash container      [setStableFrameRate [0..160]]");
		registerCommand("setFrameRate", setFrameRate,
				"need to set frame rate in flash container             [setFrameRate [0..160]]");
		registerCommand("getFrameRate", getFrameRate,
				"need to get FrameRate");
		registerCommand("getAverageFrameRate", getAverageFrameRate,
				"need to get Average getFrameRate");
		registerCommand("getErrors", getErrors,
				"need to get error list");
		registerCommand("setIsDebug", setIsDebug,
				"need to opent debug mode");

		registerCommand("getDisplayState", getDisplayState,
				"can returned StageDisplayState ");
		registerCommand("getMouseOverElement", getMouseOverElement,
				"return latest mouse over element");
		registerCommand("isClearedConsole", isClearedConsole,
				"set status cleared for console if need show all information");
		registerCommand("addActions", addActions,
				"[do not completed] add actions and return uniq action id");
		//			registerCommand("getScreenShotJPG",					getScreenShotJPG, 				"returns screenShot of Stage (BitmapData)");
	}

	private function getRootBounds(swfSelector: String=""):Rectangle {
		if(!swfSelector) return null;
		var displayObject:* = getDisplayObject(swfSelector);
		if(displayObject.className=="SimpleButton"){
			displayObject = getDisplayObject(swfSelector+"/..");
		}
		return displayObject.rootBounds;
	}


	private function getScreenAtElement(swfSelector: String=""):* {
		var rootBounds:* = getRootBounds(swfSelector);
		if(!rootBounds) return null;
		return getScreen(rootBounds.x,
				rootBounds.y,
				rootBounds.width,
				rootBounds.height,
				false
		);
	}

	private function getScreen(x: String="0", y:String="0", width:String="-1", height:String="-1", isNeedGlobalOrientation:Boolean=true):* {
		var _width:Number = width=="-1"?root.stage.stageWidth:Number(width);
		var _height:Number = height=="-1"?root.stage.stageHeight:Number(height);
		var _x:Number = Number(x) - (isNeedGlobalOrientation?getSwfInfo().globalX:0);
		var _y:Number = Number(y) - (isNeedGlobalOrientation?getSwfInfo().globalY:0);
		var matrix:Matrix = new Matrix();

		matrix.tx = -_x;
		matrix.ty = -_y;
		var time:Number = new Date().getTime();
		if(_width<=0 || _height<=0){
			return null;
		}
		var bitmapData:BitmapData = new BitmapData(_width, _height, false);
		try {
			bitmapData.draw(root, matrix);
		} catch(e:Error){
			onError(new UncaughtErrorEvent(UncaughtErrorEvent.UNCAUGHT_ERROR, true, true, e));
			return null;
		}
		//for debug mode;
//		_spriteWithBackground.clear();
//		_spriteWithBackground.addChild(new Bitmap(bitmapData.clone()));
		var byteArray:ByteArray = new PNGEncoder().encode(bitmapData);
		Console.write("exec time: " + (new Date().getTime()-time));
		var b64:Base64Encoder = new Base64Encoder();
		b64.encodeBytes(byteArray);
		var res:*={"pixels": b64.toString()};
		bitmapData.dispose();
		b64.reset();
		return res;

	}


	private var mouseOverElement:String = "";

	protected function onMouseOver(event:MouseEvent):void {
		mouseOverElement = event.target.name;
	}

	private function getMouseOverElement():String {
		Console.write("mouseOverElement: ", Console.GREEN, false);
		Console.write(mouseOverElement, Console.YELLOW, true);
		return mouseOverElement;
	}

	private var _currentFPS:Number = 0;
	private var _lastTime:int;

	protected function onEnterFrame(event:Event):void {
		var curTime:int = getTimer();
		var dt:int = curTime - _lastTime;
		_lastTime = curTime;
		if(dt) {
			var fps:Number = 1000 / dt;
			var k:Number = 0.3;
			if(fps > _currentFPS) {
				k = 0.1;
			}
			_currentFPS = (fps - _currentFPS) * k + _currentFPS;
		}
		if(stableFrameRate != -1 && root.stage.frameRate != stableFrameRate) {
			root.stage.frameRate = stableFrameRate;
		}
	}

	private function getErrors():Array {
		var result:Array = errorList;
		errorList = [];
		Console.write("getErrors: ", Console.GREEN, false);
		Console.write(result, Console.RED);
		return result;
	}

	private var _prevCallOnAutoClickProcess:int = 0;

	protected function onAdded(event:Event):void {
		if(event.target is Loader) {
			root.stage.scaleMode = scaleMode;
			root.stage.align = align;
			Loader(event.target).contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaded);
			Loader(event.target).contentLoaderInfo.addEventListener(Event.INIT, onLoaded);
			Loader(event.target).contentLoaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, onError);
			Loader(event.target).uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, onError);
		}
		if((event.target is Sprite || event.target is MovieClip || event.target is SimpleButton || event.target is DisplayObjectContainer) && (event.target.name != "HighLightElementDO")) {
			//dispathClickOnDisplayObjectList(pathsToDisplayObjectsForAutoClickOnIt, DisplayObjectContainer(event.target));
			//clearTimeout(_prevCallOnAutoClickProcess);
			var contWhereNeedSearchElements:DisplayObjectContainer;
			if(event.target is DisplayObjectContainer) {
				contWhereNeedSearchElements = DisplayObjectContainer(event.target)
			} else {
				contWhereNeedSearchElements = DisplayObject(event.target).parent;
			}
			contWhereNeedSearchElements = contWhereNeedSearchElements ? contWhereNeedSearchElements : root.stage;
			dispathClickOnDisplayObjectList(pathsToDisplayObjectsForAutoClickOnIt, contWhereNeedSearchElements);
			//_prevCallOnAutoClickProcess = setTimeout(dispathClickOnDisplayObjectList, 500, pathsToDisplayObjectsForAutoClickOnIt, DisplayObjectContainer(event.target))
		}
	}

	private function dispathClickOnDisplayObjectList(displayObjectList:Array, container:DisplayObjectContainer):void {
		container = container ? container : root.stage;
		var isFouned:Boolean = false;
		var time:int = getTimer();
		for each (var displayObjectPath:String in displayObjectList.reverse()) {
			for each (var displayObject:DisplayObject in searcher.getInstancesByContainer(displayObjectPath, container, 1)) {
				if(isDOisNotInListWhenNotNeedToClick(container, displayObject)) {
					isFouned = true;
					if(displayObject.hasEventListener(MouseEvent.CLICK) || displayObject.hasEventListener(MouseEvent.MOUSE_DOWN) || displayObject.hasEventListener(MouseEvent.MOUSE_UP)) {
						clickOn(displayObject, 1);
					} else {
						setTimeout(clickOn, 1000, displayObject, 1);
					}
					break;
				}
			}
			if(isFouned) {
				break;
			}
		}
		clearTimeout(_prevCallOnAutoClickProcess);
		var isShortlyUpdate:Boolean = (container is Stage || !isFouned);
		_prevCallOnAutoClickProcess = setTimeout(dispathClickOnDisplayObjectList, isShortlyUpdate ? 1000 : 500, displayObjectList, root.stage);
		if(isFouned) {
			Console.write("autoclick execution time: " + (getTimer() - time));
			Console.write("status: " + isFouned, Console.GREEN);
			Console.write("found in: " + container, Console.YELLOW);
		}
//			Console.write("found in: " + container, Console.RED);
//			Console.write("path: " + DisplayObjectUtils.getPath(container), Console.GREEN);
//			Console.write("found what: ", Console.YELLOW);
//			Console.write(displayObjectList, Console.GREEY_WHITE);
	}

	protected function isDOisNotInListWhenNotNeedToClick(container:DisplayObjectContainer, checkedDO:DisplayObject):Boolean {
		for each (var displayObjectPath:String in pathsToDisplayObjectsForDoNotAutoClickOnIt) {
			for each (var displayObject:DisplayObject in searcher.getInstancesByContainer(displayObjectPath, container, 1)) {
				if(displayObject == checkedDO || displayObject === checkedDO) {
					return false;
				}
			}
		}
		return true;
	}

	protected function onLoaded(event:Event):void {
		LoaderInfo(event.target).removeEventListener(Event.COMPLETE, onLoaded);
		LoaderInfo(event.target).removeEventListener(Event.INIT, onLoaded);
	}

	private var errorList:Array = [];

	protected function onError(event:UncaughtErrorEvent):void {
		event.preventDefault();
		event.stopImmediatePropagation();

		var errorMessage:String;
		var errorObj:Object;
		var errorObjString:String = "";
		var stackTrace:String;
		if(event.error is Error) {
			var error:Error = event.error as Error;
			if(error) {
				if((error.message is String) && error.message.hasOwnProperty("name")) {
					errorObjString += "name: " + error.name + "; ";
					errorObjString += "message.name: " + (error.message.hasOwnProperty("name") ? error.message.name : "") + "; ";
					errorObjString += "message.message: " + (error.hasOwnProperty("message:") ? error.message.message : "") + "; ";
					errorObjString += "message: " + ((error.message is String) ? error.message : "") + "; ";
					errorMessage = error.message ? Error(event.error).message : "empty";
				} else if(error.message is String) {
					errorObjString += "message: " + ((error.message is String) ? error.message : "") + "; ";
					errorMessage = error.name;
				}
				try {
					stackTrace = error.getStackTrace().replace("\n", "; ");
				} catch(e:Error) {
					stackTrace = "something when wrong when need get stack trace: " + e.errorID + " " + e.message + " " + e.name;
				}
			} else {
				errorMessage = event.error.toString();
				errorObjString = event.error.toString();
				try {
					stackTrace = error.getStackTrace().replace("\n", "; ");
				} catch(e:Error) {
					stackTrace = "something when wrong when need get stack trace: " + e.errorID + " " + e.message + " " + e.name;
				}
			}
		} else if(event.error is ErrorEvent) {
			errorObj = ErrorEvent(event.error);
			if(errorObj) {
				var errorE:ErrorEvent = ErrorEvent(event.error);
				errorObjString = errorE.toString() + errorE.type;
				errorMessage = errorE.text;
				stackTrace = new Error().getStackTrace();
			}
		} else {
			errorMessage = event.error.toString();
			errorObjString = event.error.toString();
			stackTrace = new Error().getStackTrace();
		}
		stackTrace = escape(stackTrace);
		errorList.push({"error": errorObjString, "errorMessage": errorMessage, "stackTrace": stackTrace});
		Console.write("onError", Console.GREEN);
		Console.write(errorList, Console.RED);
	}

	public function removeCommand(commnandName:String):Testing {
		ConsoleCommand.deleteCommand(commnandName);
		if(ExternalInterface.available) {
			ExternalInterface.addCallback(commnandName, null);
		}
		return this;
	}

	public function registerCommand(commnandName:String, command:Function, comment:String = "", hotKey:Object = null):Testing {
		ConsoleCommand.registerCommand(commnandName, command, comment, hotKey);
		if(ExternalInterface.available) {
			Security.allowDomain("*");
			ExternalInterface.addCallback(commnandName, command);
		}
		commnandName += "New";
		ConsoleCommand.registerCommand(commnandName, command, comment, hotKey);
		if(ExternalInterface.available) {
			Security.allowDomain("*");
			ExternalInterface.addCallback(commnandName, command);
		}
		return this;
	}

	public function getDisplayState():String {
		Console.write("displayState: ", Console.GREEN, false);
		Console.write(root.stage.displayState, Console.YELLOW, true);
		return root.stage.displayState;
	}

	public function initializeTraceClick(init:Boolean = true):void {
		mouseSimulation.enable = init;
	}

	public function setIsDebug(isDebug:Boolean = true):void {
		Console.instance.enabled = isDebug;
	}

	public function getMousePosition():* {
		Console.write("getMousePosition: ", Console.GREEN, false);
		Console.write({x: root.stage.mouseX, y: root.stage.mouseY});
		return {x: root.stage.mouseX, y: root.stage.mouseY};
	}

	public function getSwfInfo(instancePath:String = null):Object {
		var result:Object = {};

		if(root.stage) {
			var offsetX:Number = 0;
			var offsetY:Number = 0;

			result.width = root.stage.loaderInfo.content.root.loaderInfo.width;
			result.height = root.stage.loaderInfo.content.root.loaderInfo.height;
			result.stageWidth = root.stage.stageWidth;
			result.stageHeight = root.stage.stageHeight;

			if(root.stage.align == StageAlign.TOP || !root.stage.align) {
				offsetX = (result.stageWidth - result.width) / 2;
//					offsetY= (DO.stage.stageHeight - DO.stage.loaderInfo.content.root.loaderInfo.height) / 2;
			}

			result.globalX = offsetX;
			result.globalY = offsetY;

			Console.write("swfInfo: ", Console.GREEN);
			Console.write(result);
		}
		return result;
	}

	private var _clearedConsole:Boolean = true;

	public function isClearedConsole(command:String = "true"):void {
		_clearedConsole = command == "true";
	}

	public function pressKey(pressKey:int):* { //b - 66,  s-83, e - 69, space 32
		root.dispatchEvent(new KeyboardEvent(KeyboardEvent.KEY_DOWN, true, true, 115, pressKey, 0));
		root.dispatchEvent(new KeyboardEvent(KeyboardEvent.KEY_UP, true, true, 115, pressKey, 0));
	}

	public function getAverageFrameRate():int {
		Console.write("getAverageFrameRate: " + _currentFPS, Console.GREEN);
		return _currentFPS;
	}

	public function getFrameRate():int {
		Console.write("getFrameRate: " + root.stage.frameRate, Console.GREEN);
		return root.stage.frameRate;
	}

	public function setFrameRate(frameRate:int):* {
		Console.write("setFrameRate: " + frameRate, Console.GREEN);
		root.stage.frameRate = frameRate;
	}

	public function setStableFrameRate(frameRate:int):* {
		Console.write("setStableFrameRate: " + frameRate, Console.GREEN);
		root.stage.frameRate = frameRate;
		stableFrameRate = frameRate
	}

	public function setScaleMode(scaleMode:String):void {
		Console.write("setScaleMode: " + scaleMode, Console.GREEN);
		this.scaleMode = scaleMode;

		root.stage.scaleMode = scaleMode;
	}

	public function setAlign(align:String):void {
		Console.write("setAlign: " + align, Console.GREEN);
		this.align = align;
		root.stage.align = align;
	}

	private function setQuality(quality:String):void {
		root.stage.quality = quality;
	}

	public function getScaleMode():String {
		Console.write("getScaleMode: " + root.stage.scaleMode, Console.GREEN);
		return root.stage.scaleMode;
	}

	public function getAlign():String {
		Console.write("getAlign: " + root.stage.align, Console.GREEN);
		return root.stage.align;
	}

	public function gotoAndPlay(command:String, frame:String):* {
		var instance:MovieClip = searcher.getInstances(command)[0] as MovieClip;
		if(instance) {
			instance.filters = [new GlowFilter(Console.GREEN, 1)];
			instance.gotoAndStop(int(frame));
		}
	}

	public function setDisplayObjectPropertyValue(command:String, property:String, value:*):Boolean {
		var instance:DisplayObject = searcher.getInstances(command, 1)[0] as DisplayObject;
		if(instance && instance.hasOwnProperty(property)) {
			instance[property] = value;
			instance.dispatchEvent(new Event(Event.CHANGE, true, false));
			return true;
		}
		return false;
	}

	public function getDisplayObjectPropertyValue(command:String, property:String):* {
		Console.write("getDisplayObjectPropertyValue " + command, Console.GREEN);
		var instance:DisplayObject = searcher.getInstances(command, 1)[0] as DisplayObject; //getDisplayObject(command);
		var result:Object;
		if(instance) {
			result = getPropertyAtObject(instance, property);
			if(result == null) {
				result = getPropertyAtObject(new DisplayObjectFab().getDisplayObject(instance), property);
			}

		}
		Console.write("result: ", Console.GREEN, false);
		Console.write(result, Console.YELLOW);
		return result;

	}

	public function getPropertyAtObject(instance:Object, property:String):* {
		var data:Object = instance;
		var properties:Array = property.split(".");
		for each (var c:String in properties) {
			if(data.hasOwnProperty(c)) {
				data = data[c];
			}
		}
		return data == instance ? null : data;
	}

	public function getDisplayObjectContainer(command:String):* {
		try {
			var instance:DisplayObject = searcher.getInstances(command, 1)[0] as DisplayObject;
			if(instance) {
				var copyObj:Object;
				copyObj = new DisplayObjectFab().getDisplayObjectContainer(instance);
				Console.write("copyObj: ", Console.GREEN);
				Console.write(copyObj);
				return copyObj;
			}
			return null;
		} catch(e:Error) {
			onError(new UncaughtErrorEvent(UncaughtErrorEvent.UNCAUGHT_ERROR, true, true, e));
		}

		return null;
	}

	public function addPathToDisplayObjectForDoNotAutoClickOnIt(pathToDisplayObject:String):void {
		var index:int = pathsToDisplayObjectsForDoNotAutoClickOnIt.indexOf(pathToDisplayObject);
		if(index == -1) {
			pathsToDisplayObjectsForDoNotAutoClickOnIt.push(pathToDisplayObject);
		}
		//dispathClickOnDisplayObjectList(pathsToDisplayObjectsForDoNotAutoClickOnIt, root);
	}

	public function removePathToDisplayObjectForDoNotAutoClickOnIt(pathToDisplayObject:String):void {
		var index:int = pathsToDisplayObjectsForDoNotAutoClickOnIt.indexOf(pathToDisplayObject);
		pathsToDisplayObjectsForDoNotAutoClickOnIt.splice(index, 1);
	}

	public function clearPathToDisplayObjectForDoNotAutoClickOnIt(pathToDisplayObject:String):void {
		pathsToDisplayObjectsForDoNotAutoClickOnIt = [];
	}

	public function removePathToDisplayObjectForAutoClickOnIt(pathToDisplayObject:String):void {
		var index:int = pathsToDisplayObjectsForAutoClickOnIt.indexOf(pathToDisplayObject);
		pathsToDisplayObjectsForAutoClickOnIt.splice(index, 1);
	}

	public function addPathToDisplayObjectForAutoClickOnIt(pathToDisplayObject:String):void {
		var index:int = pathsToDisplayObjectsForAutoClickOnIt.indexOf(pathToDisplayObject);
		if(index == -1) {
			pathsToDisplayObjectsForAutoClickOnIt.push(pathToDisplayObject);
		}
		dispathClickOnDisplayObjectList(pathsToDisplayObjectsForAutoClickOnIt, root.stage);
	}

	public function clearPathToDisplayObjectForAutoClickOnIt():void {
		pathsToDisplayObjectsForAutoClickOnIt = [];
	}

	public function getDisplayObject(command:String, easyObject:Boolean = true):* {
		try {
			clear();
			var instance:DisplayObject = searcher.getInstances(command, 1)[0] as DisplayObject; //searcher.getDisplayObjectByPath(instancePath);
			if(instance) {
				if(easyObject) {
					var copyObj:Object;
					copyObj = new DisplayObjectFab().getDisplayObject(instance);
					Console.write("copyObj: ", Console.GREEN);
					Console.write(copyObj);
					return copyObj;
				} else {
					return instance;
				}
			}
			return null;
		} catch(e:Error) {
			onError(new UncaughtErrorEvent(UncaughtErrorEvent.UNCAUGHT_ERROR, true, true, e));
		}
		return null;
	}

	public function clear():void {
		if(_clearedConsole) {
			Console.instance.clear();
		}
	}

	private var _displayObjectFab:DisplayObjectFab;

	public function getDisplayObjects(command:String, limitArg:int = 10000):Array {
		var result:Array = [];
		var time:int = getTimer();
		var split:int = limitArg < 0 ? 1000 : limitArg;
		Console.instance.clear();
		var instances:Array = searcher.getInstances(command, split);
		if(instances) {
			var copyObj:Object;
			for each (var c:Object in instances) {
				if(c is DisplayObject) {
					var displayObject:DisplayObject = DisplayObject(c);
					copyObj = _displayObjectFab.getDisplayObject(displayObject);
				} else {
					copyObj = c;
				}

				result.push(copyObj);
			}

			Console.write("getDisplayObjects " + command, Console.GREEN);
			Console.write(result);
			Console.write("script execution time: ");
			Console.write((getTimer() - time), Console.GREEY_LIGHT);
		}
		return result;
	}

	public function issetElement(command:String):Boolean {
		try {
			var instance:DisplayObject = searcher.getInstances(command, 1)[0] as DisplayObject;
			Console.write("issetElement " + command, Console.GREEN);
			Console.write("issetElement: " + instance, Console.GREEY);
			return instance;
		} catch(e:Error) {
			onError(new UncaughtErrorEvent(UncaughtErrorEvent.UNCAUGHT_ERROR, true, true, e));
		}
		return false;
	}

	public function dispatchMouseEvent(command:String, mouseEvent:String, mouseX:int = 0, mouseY:int = 0):String {
		var instance:DisplayObject = searcher.getInstances(command, 1)[0] as DisplayObject;
		Console.write("dispathMouseEvent " + command + " mouseEvent: " + mouseEvent + " mouseX: " + mouseX + " mouseY: " + mouseY, Console.GREEN);

		Console.write("instance: " + instance, Console.GREEY);
		if(instance != null) {
			Console.write("	instanceName: " + instance.name, Console.GREEY);
			var event:MouseEvent = new MouseEvent(mouseEvent, true, false, mouseX, mouseY);

			if(instance.hasOwnProperty("hit")) {
				Console.write("	Hit instance: " + instance["hit"], Console.GREEY);
				Console.write("	Hit instance name: " + instance["hit"].name, Console.GREEY);
				(instance["hit"] as InteractiveObject).dispatchEvent(event);
			}
			instance.dispatchEvent(event);
		}

		if(!instance) {
			return null;
		}

		return instance.name;
	}

	private static var _incId:int = 0;

	public function addActions(actions:String, count:uint = 1):int {
		return new Action(new JsonActionDataParser(actions), this, _incId++).getId();
	}


	private var _clickIdIcremental:int = 1;
	private var _statusOfClick:Dictionary = new Dictionary();

	public function getClickStatus(id:String):Boolean {
		Console.write("	click status by id: " + id, Console.GREEN);
		var status:Boolean = _statusOfClick.hasOwnProperty(id) ? _statusOfClick[id] == 0 : false;
		Console.write(status, Console.GREEY);
		return  status;
	}

	public function clickNTimes(command:String, count:uint = 1):String {
		if(count <= 0) {
			return null;
		}
		var results:Array = searcher.getInstances(command, 1);
		if(!results.length) {
			return null;
		}
		var instance:DisplayObject = searcher.getInstances(command, 1)[0] as DisplayObject;
		Console.write("onTestingClick: " + command, Console.GREEN);
		Console.write("instance: " + instance, Console.GREEY);
		Console.write("count of clicks: " + count, Console.GREEY);
		var id = null;
		if(instance != null) {
			Console.write("	instanceName: " + instance.name, Console.GREEY);
			id = clickOn(instance, count);
			Console.write("	click id: " + id, Console.GREEY);
		} else {
			return id;
		}
		return String(id);
	}

	public function click(command:String):String {
		return clickNTimes(command, 1);
	}

	protected function clickOn(DO:DisplayObject, countOfClicks:uint = 1):int {

		if(DO.hasOwnProperty("hit")) {
			Console.write("	Hit instance: " + DO["hit"], Console.GREEY);
			Console.write("	Hit instance name: " + DO["hit"].name, Console.GREEY);
			DO = (DO["hit"] as InteractiveObject);
		}
		mouseSimulation.moveTo(DO);

		_clickIdIcremental++;
		_statusOfClick[_clickIdIcremental] = countOfClicks;
		dispatchClick(DO, 50, _clickIdIcremental, countOfClicks);
		return _clickIdIcremental;
	}

	public function dispatchClick(DO:DisplayObject, timeOut:uint = 0, clickId:int = -1, countOfClicks:int = 1):void {
		var clicks:Array = [
			[new MouseEvent(MouseEvent.ROLL_OVER), timeOut],
			[new MouseEvent(MouseEvent.MOUSE_OVER), timeOut]
		];


		while(countOfClicks-- > 0) {
			clicks.push([new MouseEvent(MouseEvent.MOUSE_DOWN), timeOut],
					[new MouseEvent(MouseEvent.MOUSE_UP), 1],
					[new MouseEvent(MouseEvent.CLICK), 1]);
		}

		clicks.push([new MouseEvent(MouseEvent.MOUSE_OUT), timeOut],
				[new MouseEvent(MouseEvent.ROLL_OUT), timeOut]);

		dispatchEventQueue(DO, clicks, null, clickId);
	}

	public function dispatchEventQueue(DO:DisplayObject, eventsQueue:Array, event:Event = null, clickId:int = -1):void {
		if(event) {
			DO.dispatchEvent(event);
			if(event.type == MouseEvent.CLICK) {
				_statusOfClick[clickId] = _statusOfClick[clickId] - 1;
			}
		}
		if(eventsQueue.length) {
			var eventData:* = eventsQueue.shift();
			event = eventData[0];
			setTimeout(dispatchEventQueue, eventData[1], DO, eventsQueue, event, clickId);
		}
	}

	private var mouseSimulation:MouseSimulation;

	private var _spriteWithBackground:SpriteWithBackground = new SpriteWithBackground();

	public function Testing(DO:DisplayObjectContainer) {
		_displayObjectFab = new DisplayObjectFab();
		initTesting(DO);
		mouseSimulation = new MouseSimulation(DO.stage);
		DO.addChild(_spriteWithBackground);
		new Drags(_spriteWithBackground, false, 2);//.start();
	}
}
}

