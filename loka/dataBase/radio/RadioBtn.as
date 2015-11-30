package loka.dataBase.radio {
	import flash.display.Graphics;
	import flash.display.LineScaleMode;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	
	import loka.button.btnEffect.BtnEffect;
	import loka.dataBase.Data;

	/**
	 * ...
	 * @author loka
	 */
	public class RadioBtn extends Data{
		private var _ground:Sprite = new Sprite();
		private var _point:Sprite = new Sprite();
		private var _btn:Sprite = new Sprite();
		private var _set:Boolean = true;
        public static const REMAKE:String = "REMAKE";
		public function RadioBtn(data:Array) {
			this.updateData(data);
		}
		public function create():void {
			var ground:Graphics = this._ground.graphics;
			var groundW:Number=parseFloat(this.getDataByName("groundW").data)
			ground.beginFill(this.getDataByName("bkgCol").data);
			ground.lineStyle(1, this.getDataByName("lineCol").data,1,false, LineScaleMode.NONE);
			ground.drawCircle(0, 0,groundW);
			ground.endFill();
			this.addChild(this._ground);
			
			var point:Graphics = this._point.graphics;
			var pointW:Number=parseFloat(this.getDataByName("pointW").data)
			point.beginFill(this.getDataByName("lineCol").data);
			point.lineStyle(1, this.getDataByName("bkgCol").data,1,false, LineScaleMode.NONE);
			point.drawCircle(0, 0,pointW);
			point.endFill();
			this.addChild(this._point);
			//this._point.visible = false;
			
			var btn:Graphics = this._btn.graphics;
			btn.beginFill(0xffffff,0);
			btn.drawRect(0, 0,groundW*2,groundW*2);
			btn.endFill();
			this._btn.x -=groundW;
			this._btn.y -=groundW;
			this.addChild(this._btn);
			this._btn.addEventListener(MouseEvent.CLICK, remakeRadio);
			this._btn.addEventListener(MouseEvent.MOUSE_OVER, overRadio);
			this._btn.addEventListener(MouseEvent.MOUSE_OUT, outRadio);
			
			new BtnEffect(_btn);
		}
        
        protected function outRadio(event:MouseEvent):void
        {
            // TODO Auto-generated method stub
            _ground.filters = [];
        }
        
        protected function overRadio(event:MouseEvent):void
        {
            // TODO Auto-generated method stub
            _ground.filters = [new GlowFilter(0xffffff, .5, 4, 4, 2, 1, true)];
        }
        private function remakeRadio(e:Event = null):void {
			//this.radio = !this._set;
			//trace("click");
			this.dispatchEvent(new Event(RadioBtn.REMAKE, true));
		}
		public function set radio(val:Boolean):void {
            if(this._set != val)
            {
                this._point.visible = val;
                this._set = val;
//                remakeRadio();
            }
			
            
		}
	}

}