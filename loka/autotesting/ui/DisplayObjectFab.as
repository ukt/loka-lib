package loka.autotesting.ui {
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.MovieClip;
import flash.display.Shape;
import flash.display.SimpleButton;
import flash.display.StageAlign;
import flash.geom.Point;
import flash.text.StaticText;
import flash.text.TextField;

public class DisplayObjectFab {
	public function DisplayObjectFab() {

	}

	public function getDisplayObject(DO:DisplayObject):Object {
		var DOcopy:Object = { };
		DOcopy = collectBaseProperties(DOcopy, DO);
		DOcopy = collectTextProperties(DOcopy, DO);
		DOcopy = collectGlobalProperties(DOcopy, DO);
		DOcopy = collectDisplayObjectContainerProperties(DOcopy, DO, true);
		DOcopy = collectShapeProperties(DOcopy, DO);
		return DOcopy;
	}

	public function getDisplayObjectContainer(DO:DisplayObject):Object {
		var DOcopy:Object = { };
		DOcopy = collectBaseProperties(DOcopy, DO);
		DOcopy = collectTextProperties(DOcopy, DO);
		DOcopy = collectGlobalProperties(DOcopy, DO);
		DOcopy = collectDisplayObjectContainerProperties(DOcopy, DO, false);
		DOcopy = collectShapeProperties(DOcopy, DO);
		return DOcopy;
	}

	private function isWithin($obj:DisplayObject, $container:DisplayObject):Boolean {
		while($obj) {
			if($obj === $container) {
				return true;
			} else {
				$obj = $obj.parent;
			}
		}
		return false;
	}

	static private function collectTextProperties(DOcopy:*, DO:DisplayObject):* {
		if(DO is StaticText) {
			DOcopy.text = StaticText(DO).text;
		}

		if(DO is TextField) {
			DOcopy.text = TextField(DO).text;//["text"]
		}
		return DOcopy;
	}

	static private function collectBaseProperties(DOcopy:*, DO:DisplayObject):* {
		var displayObjectUtils:DisplayObjectUtils = new DisplayObjectUtils();
		DOcopy.x = DO.x;
		DOcopy.y = DO.y;
		DOcopy.width = DO.width;
		DOcopy.height = DO.height;
		DOcopy.rotation = DO.rotation;
		DOcopy.name = DO.name;
		DOcopy.visible = DO.visible;
		DOcopy.alpha = DO.alpha;
		DOcopy.parent = DO.parent ? true : false;
		DOcopy.parentName = DO.parent ? DO.parent.name : null;
		DOcopy.visibleOnStage = displayObjectUtils.getVisibleOnStage(DO);//DO.stage ? true : false;
		DOcopy["path"] = displayObjectUtils.getPath(DO);
		DOcopy.index = DO.parent.getChildIndex(DO);
		DOcopy.className = String(DO.toString().split(" ")[1]).split("]")[0].toString();

		DOcopy.bounds = DO.getBounds(DO.parent);
		DOcopy.rootBounds = DO.stage?DO.getBounds(DO.stage):null;
		return DOcopy;
	}


	static private function collectGlobalProperties(DOcopy:*, DO:DisplayObject):* {
		DOcopy.globalX = DO.x;
		DOcopy.globalY = DO.y;
		if(DO.parent && DO.stage) {
			var globalPosition:Point = DO.localToGlobal(new Point(0, 0));

			var offsetX:Number = 0;
			var offsetY:Number = 0;
			if(DO.stage.align == StageAlign.TOP || !DO.stage.align) {
				offsetX = (DO.stage.stageWidth - DO.stage.loaderInfo.content.root.loaderInfo.width) / 2;
				//				offsetY= (DO.stage.stageHeight - DO.stage.loaderInfo.content.root.loaderInfo.height) / 2;
			}

			DOcopy.globalX = globalPosition.x + offsetX;
			DOcopy.globalY = globalPosition.y + offsetY;

			DOcopy.localX = globalPosition.x;
			DOcopy.localY = globalPosition.y;
		}
		return DOcopy;
	}

	private function collectDisplayObjectContainerProperties(DOcopy:*, DO:DisplayObject, isSimple:Boolean):* {
		if(DO is DisplayObjectContainer) {
			var DOC:DisplayObjectContainer = DO as DisplayObjectContainer;

			DOcopy.mouseEnabled = DOC.mouseEnabled;
			DOcopy.mouseChildren = DOC.mouseChildren;
			DOcopy.numChildren = DOC.numChildren;


			if(isSimple) {
				DOcopy = collectSimpleChildrens(DOcopy, DOC);
			} else {
				DOcopy = collectFullChildrens(DOcopy, DOC);
			}

			if(DO is MovieClip) {
				var mc:MovieClip = MovieClip(DO);
				DOcopy.currentFrame = mc.currentFrame;
				DOcopy.totalFrames = mc.totalFrames;
				DOcopy.currentLabel = mc.currentLabel;
			}
		}
		return DOcopy;
	}

	static private function collectShapeProperties(DOcopy:*, DO:DisplayObject):* {
		if(DO is Shape) {
			DOcopy.mouseEnabled = false;
		}
		return DOcopy;
	}

	static private function collectSimpleButtonProperties(DOcopy:*, DO:DisplayObject):* {
		if(DO is SimpleButton) {
			var buttonDO:SimpleButton = SimpleButton(DO);
			DOcopy.mouseEnabled = buttonDO.mouseEnabled;
			DOcopy.useHandCursor = buttonDO.useHandCursor;
		}
		return DOcopy;
	}

	static private function collectSimpleChildrens(DOcopy:*, DO:DisplayObjectContainer):* {
		var childrens:Object = {};

		for(var i:uint = 0; i < DO.numChildren; i++) {
			childrens[i] = DO.getChildAt(i).name;
		}
		DOcopy.childrens = childrens;
		return DOcopy;
	}

	private function collectFullChildrens(DOcopy:*, DO:DisplayObjectContainer):* {
		var childrens:Array = [];
		for(var i:uint = 0; i < DO.numChildren; i++) {
			childrens.push(getDisplayObjectContainer(DO.getChildAt(i)));
		}
		DOcopy.childrens = childrens;
		return DOcopy;
	}
}
}