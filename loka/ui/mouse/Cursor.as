/**
 * Created by hsavenko on 10/15/2014.
 */
package loka.ui.mouse {
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.display.Stage;

public class Cursor extends Sprite {
	private var _arrowCursor:DisplayObject;
	private var _fingerCursor:DisplayObject;

	public function Cursor(stage:Stage, arrowCursor:DisplayObject = null, fingerCursor:DisplayObject = null) {
		stage.addChild(this);
		_arrowCursor = arrowCursor;
		_fingerCursor = fingerCursor;
		addChild(_arrowCursor);
		addChild(_fingerCursor);
	}

	public function set cursor(cursorType:CursorType){
		switch(cursorType) {
			case CursorType.ARROW:
				_fingerCursor.visible = false;
				_arrowCursor.visible = true;
				break;
			case CursorType.FINGER:
				_fingerCursor.visible = true;
				_arrowCursor.visible = false;
				break;
		}
		stage.addChild(this);
	}
}
}
