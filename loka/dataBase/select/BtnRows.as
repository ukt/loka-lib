package utils.loka.dataBase.select {
	import flash.display.Sprite;
	
	import utils.loka.button.btnEffect.BtnEffect;
	import utils.loka.dataBase.Data;
	
	/**
	 * ...
	 * @author loka
	 */
	public class BtnRows extends Data	{
		private var _btn:Sprite = new Sprite();
		public function BtnRows(base:Array) {
			this.updateData(base);
			//this.mouseEnabled = false;
			
		}
		public function create(w:Number=20,h:Number=20):void {
			this._btn.graphics.beginFill(this.getDataByName("bgColor").data);
			this._btn.graphics.lineStyle(1, this.getDataByName("color").data);
			this._btn.graphics.drawRect(0, 0, w, h);
			this._btn.graphics.endFill();
			if (this.getDataByName("make").data == Select.MAKE_DOWN) {
				this._btn.graphics.beginFill(this.getDataByName("bgColor").data);
				this._btn.graphics.lineStyle(1, this.getDataByName("color").data);
				this._btn.graphics.moveTo(w / 10, h / 10);
				this._btn.graphics.lineTo(w - w / 10, h / 10);
				this._btn.graphics.lineTo(w / 2, h - h / 10);
				this._btn.graphics.lineTo(w / 10, h / 10);
				this._btn.graphics.endFill();
			}
			this.addChild(this._btn);
			this._btn.name = this.name;
			new BtnEffect(this._btn);
		}
		
	}

}