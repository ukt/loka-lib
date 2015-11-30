package utils.loka.console.utils.ui {
	
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;

	public class HighLightElements {
		
		private var stage:Stage;
		private var currentHighLightElement:HighLightElement;

		private var _DOTtree:DOTtree;
		
		public function HighLightElements(stage:Stage) {
			this.stage = stage;
		}
		
		public function removeHightLight():void {
			removeEventListeners();
			stage.removeChild(_DOTtree);
			onOut(null);
		}
		
		public function initHightLight():void {
			if(!_DOTtree){
				_DOTtree = new DOTtree();
			}
			stage.addChild(_DOTtree);
			
			initEventListeners();
			_DOTtree.startDraw();
			onOver(null);
		}
		
		private function removeEventListeners():void {
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onOver, true);
			stage.removeEventListener(MouseEvent.MOUSE_OUT, onOut, true);
			stage.removeEventListener(MouseEvent.CLICK, onClick, true);
		}
		
		private function initEventListeners():void {
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onOver, true);
			stage.addEventListener(MouseEvent.MOUSE_OUT, onOut, true);
			stage.addEventListener(MouseEvent.CLICK, onClick, true);
		}
		
		protected function onClick(event:MouseEvent):void {
			event.stopPropagation();
			if(!(event.target is Stage) && !(DisplayObject(event.target) is DOTtree)) {
				if(_DOTtree.isDraw){
					removeEventListeners();
					_DOTtree.stopDraw();
				}else{
					initEventListeners();
					_DOTtree.startDraw();
				}
				onOut();
			}
		}
		private var _idCaller:uint = 0;
		protected function onOver(event:MouseEvent = null):void {
			onOut();
			if(
				event && 
				!(DisplayObject(event.target) is DOTtree) 
				&& 
				!(DisplayObject(event.target) is HighLightElement) 
				&& 
				!(DisplayObject(event.target) is Stage)
				&& 
				!(DisplayObject(event.target) is Loader)
			){
				var arr:Array = stage.getObjectsUnderPoint(new Point(stage.mouseX, stage.mouseY));
				var DO:DisplayObject = DisplayObject(arr[arr.length-1]);
				currentHighLightElement = new HighLightElement(DO);
				currentHighLightElement.highLight();
				clearTimeout(_idCaller);
				_idCaller = setTimeout(_DOTtree.draws, 100, arr);
			}
		}
		
		protected function onOut(event:MouseEvent = null):void {
			if(currentHighLightElement) {
				currentHighLightElement.shutDown();
				currentHighLightElement = null;
			}
		}
		
	}
}
import flash.display.Bitmap;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.Graphics;
import flash.display.Shape;
import flash.display.SimpleButton;
import flash.display.Sprite;
import flash.display.Stage;
import flash.events.Event;
import flash.events.TextEvent;
import flash.filters.GlowFilter;
import flash.system.System;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.utils.ByteArray;
import flash.utils.Dictionary;

import utils.loka.autotesting.ui.DisplayObjectFab;

import utils.loka.console.Console;
import utils.loka.drags.Drags;
import utils.loka.text.TextUtils;


internal class HighLightElement {
	private var _DO:DisplayObject;
	
	private static var _filter:GlowFilter;
	
	public function HighLightElement(DO:DisplayObject) {
		if(!_filter) {
			_filter = new GlowFilter(Console.BLUE_LIGHT, 1, 4, 4, 2, 2);
		}
		while((DO is Bitmap || DO is SimpleButton || DO is TextField) && !(DO.parent is Stage)){
			DO = DO.parent;
		}
		this._DO = DO;
	}
	
	public function highLight():void {
		if(getIndexOfFilter()==-1) {
			var filters:Array = _DO.filters;
			filters.push(_filter);
			_DO.filters = filters;
		}
	}
	
	private function getIndexOfFilter():int {
		for(var i:int = 0; i<_DO.filters.length; i++){
			var filter:GlowFilter = _DO.filters[i] as GlowFilter;
			if(
				filter &&
				filter.alpha == _filter.alpha &&
				filter.blurX == _filter.blurX &&
				filter.blurY == _filter.blurY &&
				filter.color == _filter.color &&
				filter.inner == _filter.inner &&
				filter.knockout == _filter.knockout &&
				filter.quality == _filter.quality &&
				filter.strength == _filter.strength 
			) {
				return i;
			}
		}
		return -1;
	}
	
	public function shutDown():void {
		var index:int = getIndexOfFilter();
		var filters:Array = _DO.filters;
		filters.splice(index, 1);
		_DO.filters = filters;
		_DO 	= null;
	}
}

internal class DOTtree extends Sprite {
//	const string cellLeftTop = "┌";
//	const string cellRightTop = "┐";
//	const string cellLeftBottom = "└";
//	const string cellRightBottom = "┘";
//	const string cellHorizontalJointTop = "┬";
//	const string cellHorizontalJointbottom = "┴";
//	const string cellVerticalJointLeft = "├";
//	const string cellTJoint = "┼";
//	const string cellVerticalJointRight = "┤";
//	const string cellHorizontalLine = "─";
//	const string cellVerticalLine = "│";
	
	
	private var DOInstance:DisplayObject;
	private var _textField:TextField;
	private var _bg:Shape;
	private var _isDraw:Boolean = true;
	private var _tree:Dictionary;
	private var _hash:Dictionary;

	private var _drager:Drags;
	
	public function DOTtree() {
		addEventListener(Event.ADDED_TO_STAGE, onInit);
	}
	
	public function get isDraw():Boolean {
		return _isDraw;
	}

	protected function onInit(event:Event):void {
		removeEventListener(Event.ADDED_TO_STAGE, onInit);
		_textField = new TextField();
		_textField.selectable = false;
		_textField.multiline = true;
		_textField.autoSize = TextFieldAutoSize.LEFT;
		_textField.filters = [new GlowFilter(Console.BLACK, 1, 2, 2, 12)];
		_textField.addEventListener(TextEvent.LINK, clickHandler);
		TextUtils.changeLeading(_textField, -3);
		mouseChildren = false;
		_bg = new Shape();
		addChild(_bg);
		
		addChild(_textField);
		_drager = new Drags(this);
		x = Console.instance.getProperty("DOTtree.x");
		y = Console.instance.getProperty("DOTtree.y");
	}
	public function startDraw():void {
		_isDraw = true;
		_textField.selectable = false;
		mouseChildren = false;
		_drager.hide(false);
	}
	
	public function stopDraw():void {
		_isDraw = false;
		_textField.selectable = true;
		mouseChildren = true;
		_drager.hide(true);
		Console.instance.setProperty("DOTtree.x", this.x);
		Console.instance.setProperty("DOTtree.y", this.y);
	}
	
	public function draw(DO:DisplayObject):void {
		if(isDraw){
			_tree = new Dictionary();
			_hash = new Dictionary();
			_textField.text = "";
			collectHash(DO);
			drawTree(_tree);
			
			var gr:Graphics = _bg.graphics;
			gr.clear();
			gr.beginFill(Console.GREEY, .5);
			gr.lineStyle(2, 0, .5);
			gr.drawRect(0, 0, _textField.width, _textField.height);
		}
	}
	public function draws(DOs:Array):void {
		if(isDraw){
			_tree = new Dictionary();
			_hash = new Dictionary();
			_textField.text = "";
			for each(var DO:Object in DOs){
				collectHash(DisplayObject(DO));
			}
			drawTree(_tree);
			drawBG();
		}
	}
	
	private function drawBG():void {
		var gr:Graphics = _bg.graphics;
		gr.clear();
		gr.beginFill(Console.GREEY, .5);
		gr.lineStyle(2, 0, .5);
		gr.drawRect(0, 0, _textField.width, _textField.height);
	}
	
	private function collectHash(DO:DisplayObject, padding:String = ""):void {
		var arr:Vector.<DisplayObject> = new Vector.<DisplayObject>();
		var parent:DisplayObject = DO;
		while(parent && parent.parent) {
			arr.unshift(parent);
			parent = parent.parent;
		}
		
		var tree:Dictionary = _tree;
		for each(var child:DisplayObject in arr){
			var contains:Boolean  = false;
			for (var k:Object in tree) {
				if(k===child){
					contains = true;
					break;
				}
			}
			if(!contains){
				tree[child] = new Dictionary();
			}
			tree = tree[child];
		}
	}
	private function drawTree(hash:Dictionary, padding:String = ""):String {
		var lastPadding:String = padding; 
		var countOfProperties:int = getCountOfProperties(hash);
		for (var k:Object in hash) {
			var value2:Object = hash[k];
			var value:Dictionary = hash[k];
			var key:DisplayObject = DisplayObject(k);
			if(countOfProperties>1){
				addDOtoTF(key, padding, "├");
				lastPadding = padding;
			} else {
				addDOtoTF(key, padding, "└");
				lastPadding = padding;
			}
			if(getCountOfProperties(value) > 1){
				if(countOfProperties>1){
					lastPadding = drawTree(value, padding + "│ ");
				} else {
					lastPadding = drawTree(value, padding + "  ");
				}
			} else {
				if(countOfProperties>1){
					lastPadding = drawTree(value, padding + "│ ");
				} else {
					lastPadding = drawTree(value, padding + "  ");
				}
			}
			countOfProperties--;
		}
		return lastPadding;
	}
	
	private function getCountOfProperties(hash:Dictionary):int {
		var result:uint = 0;
		for (var k:Object in hash) {
			result++;
		}
		return result;
	}
	
	private function addDOtoTF(child:DisplayObject, padding:String, cellType:String):void {
		_hash[child.name + child.toString()] = child;
		if(padding.length > 1){
			TextUtils.addHtmlTextWithColor(_textField, padding + "<a href='event:"+child.name + child.toString()+":Collapsing"+"'>"+cellType+"</a>", Console.RED);
			TextUtils.addHtmlTextWithColor(_textField, "<a href='event:"+child.name + child.toString()+":ShowProperties"+"'>+</a>", Console.BLUE_LIGHT);
		}
		TextUtils.addHtmlTextWithColor(_textField, child.name + "", Console.YELLOW);
		TextUtils.addHtmlTextWithColor(_textField, " [" + "", Console.ORANGE);
		TextUtils.addHtmlTextWithColor(_textField, child.parent.getChildIndex(child) + "" + "", Console.GREEY_LIGHT);
		TextUtils.addHtmlTextWithColor(_textField, "]" + "", Console.ORANGE);
		TextUtils.addHtmlTextWithColor(_textField, " " + getObjectClassName(child) + " ", Console.GREEN);
		TextUtils.addHtmlTextWithColor(_textField, "<a href='event:"+child.name + child.toString()+":GetPath"+"'> getPath </a>" + "\n", Console.ORANGE);
	}

	private function getObjectClassName(child:DisplayObject):String {
		return String(child).replace("[object ", "").replace("]", "");
	}
	
	private function addObjecttoTF(objName:String, obj:Object, padding:String, cellType:String):void {
		if(obj != null) {
			TextUtils.addHtmlTextWithColor(_textField, padding + "• ", Console.RED);
			TextUtils.addHtmlTextWithColor(_textField, objName, Console.GREEY_WHITE);
			TextUtils.addHtmlTextWithColor(_textField, " [" + "", Console.ORANGE);
			
			TextUtils.addHtmlTextWithColor(_textField, obj.toString(), Console.GREEN);
			TextUtils.addHtmlTextWithColor(_textField, "]" + "\n", Console.ORANGE);
		}
	}
	
	private function clickHandler(e:TextEvent):void {
		var split:Array = e.text.split(":");
		var child:DisplayObject = _hash[ split[0]];
		var padding:String;
		var cellType:String;
		var duplicateChild:Object;
		switch (split[1]){

			case "Collapsing":
				_textField.text = "";
				_tree = new Dictionary();
				collectHash(child);
				padding = drawTree(_tree);
				cellType = "├";
				
				if(child is DisplayObjectContainer){
					var DOC:DisplayObjectContainer = DisplayObjectContainer(child);
					for(var i:uint = 0; i<DOC.numChildren;i++){
						if(i == DOC.numChildren - 1){
							cellType = "└";
						}
						addDOtoTF(DOC.getChildAt(i), padding, cellType);
					}
				} else {
					duplicateChild = duplicate(child);
					for (var param1:String in duplicateChild) {
						addObjecttoTF(param1, duplicateChild[param1], padding + "  ", cellType);
					}
				}
				drawBG();
				break;
			case "ShowProperties":
				_textField.text = "";
				_tree = new Dictionary();
				collectHash(child);
				padding = drawTree(_tree);
				cellType = "├";

				duplicateChild = duplicate(child);
				for (var param2:String in  duplicateChild) {
					addObjecttoTF(param2, duplicateChild[param2], padding + "  ", cellType);
				}
				drawBG();
				break;

			case "GetPath":
				var path:String = new DisplayObjectFab().getDisplayObject(child).path;
				System.setClipboard(path);
				break;
		}

	}
	
	public static function duplicate(data:DisplayObject):Object {
		var copyObj:Object;
		var copyObjByteArray:ByteArray = new ByteArray();
		copyObjByteArray.writeObject(data);
		copyObjByteArray.position = 0;
		
		copyObj = copyObjByteArray.readObject(); 
		if(!copyObj){
			return new DisplayObjectFab().getDisplayObject(data);
		}
		return copyObj;
	}
	
}
