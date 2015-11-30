package loka.console.utils.ui {
	import flash.display.DisplayObject;
	import flash.display.LoaderInfo;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.events.Event;

	public class DisplaObjectAutoAlign {
		
		private var stage:Stage; 
		private var displayObject:DisplayObject;
		private var _previousAlign:String = null;
		
		public function DisplaObjectAutoAlign(stage:Stage, displayObject:DisplayObject) {
			this.stage = stage;
			this.displayObject = displayObject;
			stage.addEventListener(Event.RESIZE, reposCanvas, false, 2);
			_previousAlign = stage.align == null ? StageAlign.TOP : stage.align;
		}
		
		protected function reposCanvas(event:Event):void {
			if(_previousAlign !== stage.align) {
				var _align:String = stage.align;
				var isNewAlignTorB: Boolean 		= _align == StageAlign.TOP || _align == StageAlign.BOTTOM; 
				var isNewAlignIsTops: Boolean 		= _align.split("T").length > 1; 
				var isNewAlignIsBottoms: Boolean	= _align.split("B").length > 1; 
				var isNewAlignIsR: Boolean 			= _align.split("R").length > 1; 
				var isNewAlignIsL: Boolean 			= _align.split("L").length > 1;
				var isNewAlignIsVCenter: Boolean 	= _align == StageAlign.LEFT || _align == StageAlign.RIGHT;
				var isPrevAlignIsVCenter: Boolean 	= _previousAlign == StageAlign.LEFT || _previousAlign == StageAlign.RIGHT;
				var isPrevAlignIsBottoms: Boolean 	= _previousAlign.split("B").length > 1; 
				var isPrevAlignIsTops: Boolean 		= _previousAlign.split("T").length > 1; 
				var isPrevAlignTorB: Boolean 		= _previousAlign == StageAlign.TOP || _previousAlign == StageAlign.BOTTOM; 
				var isPrevAlignIsR: Boolean 		= _previousAlign.split("R").length > 1; 
				var isPrevAlignIsL: Boolean 		= _previousAlign.split("L").length > 1;
				
				var isLeftToCenter	: Boolean 	= isPrevAlignIsL  && isNewAlignTorB;
				var isRightToCenter	: Boolean 	= isPrevAlignIsR  && isNewAlignTorB;
				var isRightToLeft	: Boolean 	= isPrevAlignIsR  && isNewAlignIsL;
				var isLeftToRight	: Boolean 	= isPrevAlignIsL  && isNewAlignIsR;
				var isCenterToLeft	: Boolean 	= isPrevAlignTorB && isNewAlignIsL;
				var isCenterToRight	: Boolean 	= isPrevAlignTorB && isNewAlignIsR;
				
				var isBottomToTop	: Boolean 	= isPrevAlignIsBottoms && isNewAlignIsTops;
				var isTopToBottom	: Boolean 	= isPrevAlignIsTops    && isNewAlignIsBottoms;
				var isTopToVCenter	: Boolean 	= isPrevAlignIsTops    && isNewAlignIsVCenter;
				var isBottomToVCenter: Boolean 	= isPrevAlignIsBottoms && isNewAlignIsVCenter;
				var isVCenterToTop	: Boolean 	= isPrevAlignIsVCenter && isNewAlignIsTops;
				var isVCenterToBottom: Boolean 	= isPrevAlignIsVCenter && isNewAlignIsBottoms;
				var rootLoaderInfo:LoaderInfo = stage.loaderInfo.content.root.loaderInfo
				switch(true){
					case isLeftToCenter:
					case isCenterToRight:
						displayObject.x += (rootLoaderInfo.width - stage.stageWidth) / 2;
						break;
					case isRightToCenter:
					case isCenterToLeft:
						displayObject.x -= (rootLoaderInfo.width - stage.stageWidth) / 2;
						break;
					case isLeftToRight:
						displayObject.x += (rootLoaderInfo.width - stage.stageWidth);
						break;
					case isRightToLeft:
						displayObject.x -= (rootLoaderInfo.width - stage.stageWidth);
						break;
				}
				
				switch(true){
					case isBottomToTop:
						displayObject.y -= (rootLoaderInfo.height - stage.stageHeight);
						break;
					case isTopToBottom:
						displayObject.y += (rootLoaderInfo.height - stage.stageHeight);
						break;
					case isVCenterToBottom:
					case isTopToVCenter:
						displayObject.y += (rootLoaderInfo.height - stage.stageHeight) / 2;
						break;
					case isVCenterToTop:
					case isBottomToVCenter:
						displayObject.y -= (rootLoaderInfo.height - stage.stageHeight) / 2;
						break;
				}
				
				_previousAlign = stage.align;
			}
		}
		
		public function destroy():void {
			if(stage) {
				stage.removeEventListener(Event.RESIZE, reposCanvas);
				stage = null;
				displayObject = null;
			}
		}
	}
}