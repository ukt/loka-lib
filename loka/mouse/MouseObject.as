package utils.loka.mouse{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.net.URLRequest;
	import flash.ui.Mouse;
	import flash.utils.Timer;
	
	import utils.loka.loaders.LoaderConstans;
	import utils.loka.loaders.loaderList.LoaderList;

	/**
	 * ...
	 * @author ...
	 */
	public class MouseObject {
		public static const CREATE:String = "CREATE";
		private var _callbackFMouseCreate:Function;
		private var _link:URLRequest;
		private var _parent:DisplayObjectContainer;
		private var _loader:LoaderList;
		private var _mouse:Sprite;
		private var _status:Boolean = false;
		private var _statusResize:Boolean = false;
		private var _w:Number=0;
		private var _h:Number=0;
		
		private var _timer:Timer;
		//private var _mouseObj:Mouse = new Mouse();
		public function MouseObject() {
			
//			this._parentaddChild(this._mouse);
		}
		
		public function init(parent:DisplayObjectContainer, link:String, callbackFMouseCreate:Function = null):void {
			this._callbackFMouseCreate = callbackFMouseCreate;
//			this._link = new URLRequest(link);
			this._loader = new LoaderList();
			this._loader.addAssets("cursore", link, false);
			this._loader.addEventListener(LoaderConstans.LOAD_DATA_ITTER_COMPLETED, addMouse);
			this._loader.load(true);
			this._mouse = new Sprite();
			this._parent = parent;
			
			this._timer = new Timer(1000 * .5);
			this._timer.addEventListener(TimerEvent.TIMER, go);
		}
		
		private function addMouse(e:Event):void {
			this._mouse.addChild(this._loader.getAssetsByName("cursore").data as DisplayObject);
			this._mouse.visible = this._status;
			this._mouse.mouseEnabled = false;
			this._mouse.useHandCursor = false;
			this._mouse.mouseChildren = false;
			this._mouse.cacheAsBitmap = true;
			if (this._statusResize) {
				this._mouse.width = this._w;
				this._mouse.height = this._h;
			}
			if(this._callbackFMouseCreate != null){
				this._callbackFMouseCreate();
				this._callbackFMouseCreate = null;
			}
//			dispatchEvent(new Event(MouseObject.CREATE, true));
		}
		/**
		 * @param val:Boolean 
		 * if(val) mouse=show else hide
		 */
		public function get show():Boolean {
			return this._status;
		}
		public function set show(val:Boolean):void {
			if(!this._parent){
				return;
			}
			this._status = val;
			//this._mouseObj.
			if(this._status){
				if(!this._parent.contains(this._mouse)){
					this._parent.addChild(this._mouse);
				}
//				Mouse.hide();
				this._mouse.visible = true;
				this._parent.setChildIndex(this._mouse, this._parent.numChildren - 1 );
				
				this._mouse.x = this._parent.mouseX + 1;
				this._mouse.y = this._parent.mouseY + 1;
				this._mouse.startDrag();
				this._timer.start();
			}else {
				if(this._parent.contains(this._mouse)){
					this._parent.removeChild(this._mouse);
				}
				Mouse.show();
				this._mouse.visible = false;
				this._mouse.stopDrag();
				this._timer.stop();
				//this.removeEventListener(Event.ENTER_FRAME, go);
			}
		}
		
		public function get width():Number { return this._mouse.width;} 
		public function set width(value:Number):void {
			this._w = value;
			this._mouse.width = value;
			if (this._h != 0) {
				this._statusResize = true;
			}
		}
		
		public function get height():Number { return this._mouse.height;}
		public function set height(value:Number):void{
			this._h = value;
			this._mouse.height = value;
			if (this._w != 0) {
				this._statusResize = true;
			}
		}
		
		private function go(e:Event):void {
			this.show = this._status;
//			this._parent.setChildIndex(this._mouse, this._parent.numChildren - 1 );
//			this._mouse.x = this._parent.mouseX+5;
//			this._mouse.y = this._parent.mouseY + 5;
			//updateAfterEvent();
		}
	}

}