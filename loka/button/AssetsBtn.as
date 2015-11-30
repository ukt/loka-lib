package utils.loka.button 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author loka
	 */
	public class AssetsBtn extends Sprite {
		private var _assets:DisplayObject;
		private var _assetsOver:DisplayObject;
		private var _assetsDown:DisplayObject;
		public function AssetsBtn(){
			super();
			
		}
		public function create(assets:DisplayObject, assetsOver:DisplayObject, assetsDown:DisplayObject):void {
			this._assets = assets;
			this._assetsOver = assetsOver;
			this._assetsDown = assetsDown;
			
			this.addChild(this._assets);
			this.addChild(this._assetsOver);
			this.addChild(this._assetsDown);
			
			this._assets.visible = true;
			this._assetsOver.visible = false;
			this._assetsDown.visible = false;
			
			this.addEventListener(MouseEvent.MOUSE_OVER, mOver);
			this.addEventListener(MouseEvent.MOUSE_MOVE, mOver);
			this.addEventListener(MouseEvent.MOUSE_DOWN, mDown);
			this.addEventListener(MouseEvent.MOUSE_UP, mUp);
			this.addEventListener(MouseEvent.MOUSE_OUT, mUp);
			
			
			this.buttonMode = true;
			this.mouseChildren = mouseChildren;
		}
		private function mDown(e:MouseEvent):void {
			this._assets.visible = false;
			this._assetsOver.visible = false;
			this._assetsDown.visible = true;
		}
		private function mOver(e:MouseEvent):void {
			this._assets.visible = false;
			this._assetsOver.visible = true;
			this._assetsDown.visible = false;
		}
		private function mUp(e:MouseEvent):void {
			this._assets.visible = true;
			this._assetsOver.visible = false;
			this._assetsDown.visible = false;
		}
		
	}

}