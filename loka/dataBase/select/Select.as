package utils.loka.dataBase.select {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import utils.loka.dataBase.Data;
	import utils.loka.dataBase.scroll.Scroll;

	/**
	 * ...
	 * @author loka
	 */
	public class Select	extends Data {
		private var _box:Sprite;
		private var _btn:BtnRows;
		private var _boxMask:Sprite;
		private var _items:Items;//= new Items();
		private var _scroll:Scroll = new Scroll();
		private var _color: uint = 0xcecece;
		private var _bgColor: uint = 0xffffff;
		private var _width: Number = 200;
		private var _height: Number = 20;
		private var _itemsH: Number = 20;
		private var _itemsW: Number = 190;
		private var _maxHeight: Number = 20;
		private var _arrItems: Number = 20;
		private var _text:TextField;
		
		private var _arrItemsData:Array = new Array();
		
		private var _scrollMake:String = Select.MAKE_DOWN;
		private var _scrollOpen:Boolean= false;
		public static const MAKE_UP:String = "MAKE_UP";
		public static const MAKE_DOWN:String = "MAKE_DOWN";
		public static const ON_CHANGE:String = "ON_CHANGE";
		public function Select() {
			this.init();
			
		}
		public function create():void {
			this._box = new Sprite();
			this.addChild(this._box);
			this._boxMask = new Sprite();
			
			this._text = new TextField();
			this._text.htmlText = "";
			this._text.selectable = false;
			
			this._items = new Items(this.data);
			
			this.addNewData("box", this._box);
			this.addNewData("boxMask", this._boxMask);
			this.addNewData("bgColor", this._bgColor);
			this.addNewData("color", this._color);
			this.addNewData("itemsH", this._itemsH);
			this.addNewData("itemsW", this._itemsW);//0958634141
			this.addNewData("make", this._scrollMake);
			this.tabEnabled = false;
			//this._box.this._text = new TextImage();
			//this._text.appendHTMLText(name);
			this._box.graphics.beginFill(this.getDataByName("bgColor").data);
			this._box.graphics.lineStyle(1, this.getDataByName("color").data);
			this._box.graphics.drawRoundRect(0, 0, this._width, this._height, 2, 2); 
			this._box.graphics.endFill();
			this._items.y = this._box.height;
			//this.addChild(this._items);
			this.addChild(this._text);
			
			this._btn = new BtnRows(this.data);
			this._btn.create(this._itemsH, this._itemsH);
			this._btn.x = this._box.width - this._btn.width - 1;
			//new BtnEffect(this._btn);
			this.addChild(this._btn);
			this._btn.addEventListener(MouseEvent.CLICK, openBtn);
			
			this._items.addEventListener(Select.ON_CHANGE, onChange);
			//this.root.addEventListener(MouseEvent.MOUSE_UP, focuseChange);
		}
		private function focuseChange(e:Event):void {
			//if (e.target == this) trace("hello") else trace("bye");
			//
			/*trace(e.target.name);
			trace(e.currentTarget.name);
			trace(this.name);
			trace(this._btn.name);
			trace("======================");*/
			
			if (e.target.name != this._btn.name )// trace("hello world" + this.name)
			this.open(false);
		}
		private function onChange(e:Event):void {
			//trace("CHANGE");
			//this.dispatchEvent(new Event(Select.ON_CHANGE, true));
			this._text.htmlText = this._items.currentItems.name;
			//trace(this._items.currentItems.name)
			if(!issetData("root"))this.open(false);
		}
		public function openBtn(e:Event):void {
			//trace("btn="+this._scrollOpen);
			if (this._scrollOpen) {
				this.open(false);
				
				//this._scrollOpen = false;
			}else {
				this.open(true);
				//this._scrollOpen = true;
				
			}
			
			
		}
		/**
		 * if(val==true) itemes->open else itemes->close
		 * @param	val 
		 */
		
		public function open(val:Boolean):void {
			//trace("btn="+val);
			if (val) {
				this.addChild(this._items);
				this._items.open(true);
				//this.parent.stage.focus = this;
				
			}else if (this._items.parent == this) {
				this._items.open(false);
				this.removeChild(this._items);
				
			}
			//trace("FOCUSE")
			
			this._scrollOpen = val;
		}
		public function addItems(val:String,data:Object):void {
			//trace("hello"+val);
			if (this._text.text == "") this._text.htmlText = val;
			this._items.addItem(val, data);
			var obj:Object = new Object()
			obj.val = val;
			obj.data = data;
			this._arrItemsData.push(obj);
			if(this._items.width > this.getDataByName("itemsW").data){
				
				this.reCreateItems(this._arrItemsData);
			}
		}
		private function reCreateItems(data:Array ):void {
			this.addNewData("itemsW", this._items.width, true);
			this._items.reCreate();
			this._items.removeEventListener(Select.ON_CHANGE, onChange);
			this._items = new Items(this.data);
			for (var c:String in data) {
				this._items.addItem(data[c].val,data[c].data);
			}
			this._items.addEventListener(Select.ON_CHANGE, onChange);
		}
		public function set widthScroll(val:Number):void {
			this._width = val;
		}
		public function get widthScroll(): Number {
			return this._width;
		}
		
		public function set maxHeightScroll(val:Number):void {
			this._maxHeight = val;
		}
		public function set heightScroll(val:Number):void {
			this._height = val;
		}
		public function get heightScroll(): Number {
			return this._height;
		}
		public function set setRoot(val:Sprite):void {
			this.addNewData("root", val, true);
			val.addEventListener(MouseEvent.MOUSE_UP, focuseChange);
			//super.root
		}
		/**
		 * @param val has set a constant whith this Class //val = (MAKE_UP || MAKE_DOWN)
		 * @return void
		 */
		public function set make(val:String):void {
			if(val == Select.MAKE_DOWN||val == Select.MAKE_UP)
			this._scrollMake = val;
			this.getDataByName("make").data=val;
		}
		public function get currentItems():Object {
			return this._items.currentItems.data;
		}
		
	}

}