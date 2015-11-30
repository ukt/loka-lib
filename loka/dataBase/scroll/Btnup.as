package utils.loka.dataBase.scroll  {
	import flash.events.*;
	
	import utils.loka.bitmap.BitmapEdit;
	import utils.loka.button.btnEffect.BtnEffect;
	public class Btnup extends ScrollBase {
		
		public function Btnup(data:Array) {
			this.updateData(data);
			this._h = parseFloat(this.getDataByName("h").data);
			this._w = parseFloat(this.getDataByName("w").data);
			this._x = parseFloat(this.getDataByName("x").data);
			this._y = parseFloat(this.getDataByName("y").data);
			this._bckgColor = this.getDataByName("bckgColor").data;
			this._lineColor = this.getDataByName("lineColor").data;
		}
		public function create(w:Number = 10, h:Number = 10, x:Number = 0, y:Number = 0):void {
			if (this.issetData("btnUp")) {
				this.addChild(BitmapEdit.drawImg(this.getDataByName("btnUp").data));
			}else{
				this.graphics.beginFill(this._bckgColor,0.1);
					this.graphics.lineStyle(2, this._lineColor,0.2);
					this.graphics.drawRect(0, 0, w, h);
					this.graphics.lineStyle(2, this._lineColor,0.4);
					this.graphics.beginFill(this._bckgColor, 0.2);
						
						this.graphics.moveTo(w / 2, h / 10);
						this.graphics.lineTo(w - w / 10, h - h / 10);
						this.graphics.lineTo(w / 10, h - h / 10);
						this.graphics.lineTo(w / 2, h / 10);
					this.graphics.endFill();
					//this.graphics.moveTo(w / 2,100+ h / 10);
				this.graphics.endFill();
			}
			this.x = x;
			this.y = y;
			//return this;
			this.addEventListener(MouseEvent.CLICK, clicked);
			this._btnEffect = new BtnEffect(this);
		}
		private function clicked(e:Event):void {
			//this.startDrag();
			dispatchEvent(new Event(MyscrollEvent.BTN_UP_CLICKED,true));
		}
		
	}
	
}