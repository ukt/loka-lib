package utils.loka.dataBase.select {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.text.TextField;
	
	import utils.loka.bitmap.BitmapEdit;
	import utils.loka.button.btnEffect.BtnEffect;
	import utils.loka.dataBase.Data;

	/**
	 * ...
	 * @author loka
	 */
	public class Items extends Data	{
		private var _items:Sprite;
		private var _box:Sprite;
		private var _mask:Sprite;
		private var _text:TextField;
		private var _btnEffect:BtnEffect;
		private var _dataItems:Array = new Array();
		private var _currentData:Object = new Object();
		public static const ITEMS_CLICK:String = "ITEMS_CLICK";
		
		private var _arrItems:Array = new Array();
		public function Items(base:Array) {
			this.updateData(base);
			this._box = new Sprite();
			this._items = new Sprite();
			this._mask = new Sprite();
			this.addChild(this._box);
			this.filters = [new DropShadowFilter()];
			
		}
		public function reCreate():void {
			for (var c:String in this._arrItems) {
				_arrItems[c].removeEventListener(MouseEvent.CLICK, itemsClick);
				_arrItems[c] = null;
			}
		}
		public function addItem(name:String,data:Object):void {
			
			var tmpY:Number = this._items.height + this._items.y;// +.5;
			this._items = new Sprite();
			this._text = new TextField();
			this._text.htmlText = name;
			this._text.selectable = false;
			this._items.graphics.beginFill(this.getDataByName("bgColor").data);
			this._items.graphics.lineStyle(1, this.getDataByName("color").data);
			this._items.graphics.drawRoundRect(0, 0, this.getDataByName("itemsW").data, this.getDataByName("itemsH").data, 0, 0); 
			this._items.graphics.endFill();
			this._items.addChild(this._text);
			this._items.y = tmpY//this._box.height;
			this._box.addChild(this._items);
			this._mask.addChild(BitmapEdit.drawImg(this._box));
			//this._mask.width = this._items.width / 2;
			this._box.graphics.beginFill(this.getDataByName("bgColor").data);
			this._box.graphics.drawRoundRect(0, 0, this._items.width, this._box.height, 0, 0); 
			this._box.graphics.endFill();
			this._box.mask = this._mask;
			this._box.addChild(this._mask);
			this._btnEffect = new BtnEffect(this._items);
			this._items.addEventListener(MouseEvent.CLICK, itemsClick);
			this._arrItems.push(this._items);
			this._items.name = name;
			var obj:Object = new Object();
			obj.name = name;
			obj.data = data;
			this._dataItems.push(obj);
			if(this._currentData.data==null)this._currentData = this.getItemsByName(name);
		}
		
		public function itemsClick(e:Event):void {
			this._currentData = this.getItemsByName(e.currentTarget.name);
			//this._text.setHTMLText = e.currentTarget.name
			
			this.dispatchEvent(new Event(Select.ON_CHANGE, true));
			//this.open(false);
		}
		public function open(val:Boolean=true):void {
			if (this.getDataByName("make").data == Select.MAKE_DOWN) {
				this.y = this.getDataByName("box").data.height;
				//trace("down");
			}else {
				this.y = this.getDataByName("box").data.y - this.height;
				//trace("up");
				
			}
		}
		private function getItemsByName(name:String):Object {
			for (var c:String in this._dataItems) {
				if (this._dataItems[c].name == name) {
					return this._dataItems[c];
				}
			}
			var obj:Object = new Object();
			obj.data = false;
			return obj;
		}
		public function get currentItems():Object {
			return this._currentData;
		}
	}

}