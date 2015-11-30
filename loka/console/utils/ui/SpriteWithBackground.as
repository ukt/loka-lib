/**
 * Created by hsavenko on 10/15/2014.
 */
package utils.loka.console.utils.ui {
import flash.display.DisplayObject;
import flash.display.Graphics;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

public class SpriteWithBackground extends Sprite {
	private const _defaultAlpha:Number = .5;
	private var _alpha:Number = _defaultAlpha;
	public function SpriteWithBackground() {
		addEventListener(Event.ADDED_TO_STAGE, init);
	}

	private function init(event:Event):void {
		removeEventListener(Event.ADDED_TO_STAGE, init);
//		addEventListener(Event.ENTER_FRAME, update);
		addEventListener(MouseEvent.MOUSE_OVER, onOver);
		addEventListener(MouseEvent.MOUSE_OUT, onOut);
	}

	private function onOut(event:MouseEvent):void {
		if(numChildren) {
			var childAt:DisplayObject = getChildAt(0);
			childAt.alpha = _alpha;
		}
	}

	private function onOver(event:MouseEvent):void {
		if(numChildren) {
			var childAt:DisplayObject = getChildAt(0);
			childAt.alpha = 1;
		}
	}

	public function clear():void {
		while(numChildren) {
			removeChildAt(0);
		}
	}

	override public function addChild(child:DisplayObject):DisplayObject {
		child.alpha = _alpha;
		return super.addChild(child);
	}

	override public function addChildAt(child:DisplayObject, index:int):DisplayObject {
		child.alpha = _alpha;
		return super.addChildAt(child, index);
	}
}
}
