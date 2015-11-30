package loka.autotesting.ui {
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.SimpleButton;
import flash.display.Sprite;
import flash.display.Stage;
import flash.geom.Rectangle;

public class DisplayObjectUtils {
	public static function isHandCursor(DO:DisplayObject):Boolean {
		if(DO) {
			if(DO is DisplayObjectContainer) {
				if(DO["hit"] && DO["hit"] is SimpleButton) {
					DO = DO["hit"];
				}
			}
			if(DO is SimpleButton) {
				return true;
			} else if(DO is Sprite) {
				var spriteObject:Sprite = Sprite(DO);
				var isHandMode:Boolean = (spriteObject.buttonMode && spriteObject.useHandCursor);
				return isHandMode;
			} else {
				return false;
			}
		}
		return false;
	}

	public static function getRootBoundsAtDO(DO: DisplayObject):Rectangle {
		if(!DO || !DO.parent) return null;
		var displayObjectFab:DisplayObjectFab = new DisplayObjectFab();
		var displayObject:* = displayObjectFab.getDisplayObject(DO);
		if(displayObject.className == "SimpleButton") {
			displayObject = displayObjectFab.getDisplayObject(DO.parent);
		}
		return displayObject.rootBounds;
	}

	public function getVisibleOnStage(DO:DisplayObject):Boolean {
		if(!DO.stage) {
			return false;
		}
		if(!DO.visible) {
			return false;
		}
		var parent:DisplayObjectContainer = DO.parent;
		while(parent.parent) {
			if(!parent.visible) {
				return false;
			}
			parent = parent.parent;
		}
		return true;
	}

	public function getPath(DO:DisplayObject):String {
		var child:DisplayObject = DO;
		var parent:DisplayObjectContainer = child.parent;
		var result:Array = [];
		var prevName:String = DO.name;

		while(parent && !(parent is Stage) && parent.parent) {
			var countChildsWithName:uint = getCountChildsWithName(parent, child.name);
			if(countChildsWithName > 1) {
				for(var i:uint = 0; i < parent.numChildren; i++) {
					if((child === parent.getChildAt(i))) {
						prevName = prevName + ",index:" + i;
						break;
					}
				}
			}
			result.push(prevName);
			prevName = parent.name;
			child = parent;
			parent = parent.parent;

		}
		result.push(prevName);
		result = result.reverse();
		return result.join("/");
	}

	private function getCountChildsWithName(parent:DisplayObjectContainer, name:String):uint {
		var result:uint = 0;
		for(var i:uint = 0; i < parent.numChildren; i++) {
			result += int(parent.getChildAt(i).name == name);
		}
		return result
	}

}
}