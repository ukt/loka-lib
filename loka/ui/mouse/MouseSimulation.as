package utils.loka.ui.mouse {
import utils.loka.ui.*;

import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.display.Stage;
import flash.events.Event;
import flash.geom.Point;
import flash.geom.Rectangle;

import utils.loka.autotesting.ui.DisplayObjectUtils;
import utils.loka.ui.mouse.CursorType;

public class MouseSimulation {
	[Embed(source="../cursor_hand.png")]
	public static var cursor_hand:Class;
	[Embed(source="../cursor_arrow.png")]
	public static var cursor_arrow:Class;
	private var currentCursor:Cursor;
	private var arrowCursor:DisplayObject;
	private var fingerCursor:DisplayObject;
	private var _enable:Boolean = false;

	private var point:Point;

	private var _stage:Stage;

	private var _pointsQueue:Vector.<GoalDO> = new <GoalDO>[];
	public function MouseSimulation(stage:Stage, arrowCursor:DisplayObject = null, fingerCursor:DisplayObject = null) {
		this.arrowCursor = arrowCursor ? arrowCursor : getDefaultArrowCursor();
		this.fingerCursor = fingerCursor ? fingerCursor : getDefaultFingerCursor();
		this._stage = stage;
		currentCursor = new Cursor(stage, this.arrowCursor, this.fingerCursor)
	}

	public function set enable(enable:Boolean):void {
		this._enable = enable;
	}

//	public function moveTo(bounds:Rectangle):void {
	public function moveTo(DO:DisplayObject):void {
		if(!_enable) return;
		var bounds:Rectangle = DisplayObjectUtils.getRootBoundsAtDO(DO);
		_pointsQueue.push(new GoalDO(new Point(bounds.x + bounds.width/2, bounds.y + bounds.height/2), DisplayObjectUtils.isHandCursor(DO)));
		startMoving();
	}

	private function startMoving():void {
		if(!point){
			_stage.addEventListener(Event.ENTER_FRAME, move)
		}
	}

	private function move(event:Event):void {
		if(!point) {
			initializeNextPoint();
		}
		if(!point) {
			dispose();
			return;
		}
		var duration:Number = .75;
		var xOffset:Number = (point.x - currentCursor.x) * duration;
		var yOffset:Number = (point.y - currentCursor.y) * duration;
		currentCursor.x += xOffset;
		currentCursor.y += yOffset;
		if(Math.abs(xOffset) < .1 && Math.abs(yOffset) < .1) {
			initializeNextPoint();
		}
	}

	private function initializeNextPoint():void {
		if(_pointsQueue.length > 0) {
			var goalDO:GoalDO = _pointsQueue.shift();
			point = goalDO.point;
			currentCursor.cursor = goalDO.isHandCursor ? CursorType.FINGER: CursorType.ARROW;
//			currentCursor.cursor = new CursorType(key);
		} else {
			dispose();
		}
	}

	private static function getDefaultFingerCursor():DisplayObject {
		var cursorHand:* = new cursor_hand();
		var cursorCont:Sprite = new Sprite();
		cursorCont.addChild(cursorHand);
		cursorHand.x = -5;
		return cursorCont;
	}

	private static function getDefaultArrowCursor():DisplayObject {
		var cursorArrow:* = new cursor_arrow();
		var cursorCont:Sprite = new Sprite();
		cursorCont.addChild(cursorArrow);
		cursorArrow.x = -1;
		return cursorCont;
	}

	private function dispose():void {
		_stage.removeEventListener(Event.ENTER_FRAME, move);
		point = null;
	}
}
}
