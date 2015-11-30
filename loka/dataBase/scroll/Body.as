package utils.loka.dataBase.scroll  {
	import flash.display.Sprite;
	import flash.events.*;
	
	import utils.loka.bitmap.BitmapEdit;
	public class Body extends ScrollBase{
		
		public function Body(data:Array) {
			this.updateData(data);
			this._h = parseFloat(this.getDataByName("h").data);
			this._w = parseFloat(this.getDataByName("w").data);
			this._x = parseFloat(this.getDataByName("x").data);
			this._y = parseFloat(this.getDataByName("y").data);
			this._bckgColor = this.getDataByName("bckgColor").data;
			this._lineColor = this.getDataByName("lineColor").data;
		}
		public function create(w:Number = 10, h:Number = 10, x:Number = 0, y:Number = 90):void {
			//if(this.issetData())
			//trace("height="+y);
			if (this.issetData("scrollBody")) {
				//this.addChild(this.getDataByName("scrollBody").data);
				this.createBody(h);
			}else {
				this.graphics.beginFill(this._bckgColor,0.1);
				this.graphics.lineStyle(2, this._lineColor,0.2);
				this.graphics.drawRect(0, 0, w, h);
			this.graphics.endFill();
			}
			
			this.x = x;
			this.y = y;
			this.addEventListener(MouseEvent.CLICK,clicked);
		}
		private function clicked(e:Event):void {
			//this.startDrag();
		}
		private function createBody(h:Number):void {
			var body:Sprite = new Sprite();
			var dataBody:Sprite = new Sprite();
			dataBody.addChild(BitmapEdit.drawImg(this.getDataByName("scrollBody").data));
			var countBody:uint = Math.round(h / dataBody.height);
			//trace("count"+countBody);
			for (var c:uint = 0; c < countBody; c++ ) {
				var tmpBody:Sprite = new Sprite();
				tmpBody.addChild(BitmapEdit.drawImg(dataBody))
				tmpBody.y = body.height;
				body.addChild(tmpBody);
				
			}
			//this._grammarBody = new Sprite();
			//this._grammarBody.addChild(BitmapEdit.drawImg(body))
			this.addChild(body);
		}
	}
	
}