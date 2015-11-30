package loka.ui.uiManager
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;

	/**
	 * ...
	 * @author loka
	 */
	public class ChildrensInspector {
		
		public function ChildrensInspector() {
			
		}
		
		public static function disposeDO(DO:DisplayObject):void {
			if(DO is DisplayObjectContainer)
			{
				clearChildrens(DisplayObjectContainer(DO));
			}
			removeDO(DO);
		}
		
		public static function removeDO(DO:DisplayObject):void {
            if(DO && DO.parent)
            {
                DO.parent.removeChild(DO);
            }
        }
        
		public static function clearChildrens(DO:DisplayObjectContainer):void {
			if(!(DO is Loader))
			{
				for (var i:uint = 0; i < DO.numChildren; i++ ) {
					var localDO:DisplayObject = DO.removeChildAt(0);
					if(localDO is DisplayObjectContainer)
					{
						clearChildrens(DisplayObjectContainer(localDO));
					}
				}
			}
		}
	}

}