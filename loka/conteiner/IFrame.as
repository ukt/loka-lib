package loka.conteiner
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import loka.dataBase.scroll.Scroll;
	import loka.graph.Graph;

	public class IFrame extends Sprite
	{
		private var _box:Sprite;
		private var _iframe:Sprite;
		
		private var _width:Number = 100;
		private var _height:Number = 100;
		/**
		 * 
		 */
		private var _scrollVerticale:Scroll;
		private var _scrollHorizontal:Scroll;
		
		public function IFrame()
		{
			super();
			this._iframe = new Sprite();
			this._box = new Sprite();
			this._box = Graph.getRectangle(0,0,1,1);
			this._box.width = this._width;
			this._box.height = this._height;
			this.addChild(this._box);
			this.addChild(this._iframe);
			this._box.alpha = .5;
			this.mask = this._box;
			this.addEventListener(MouseEvent.MOUSE_WHEEL, wheel);
		}
		
		private function wheel(e:MouseEvent):void {
			if (this._scrollVerticale != null) {
				this._scrollVerticale.Percent -= e.delta;
			}
		}
		
		override public function removeChild(child:DisplayObject):DisplayObject 
		{
			return this._iframe.removeChild(child);
		} 
		override public function addChild(child:DisplayObject):DisplayObject 
		{
			var DO:DisplayObject 
			if(!(child is Scroll)&&!(child == this._iframe)&&!(child == this._box	)){
				DO = this._iframe.addChild(child);
			}else {
				DO = super.addChild(child);
			}
			
			trace(super.width , this._width);
			if (super.height > this._height) {
				if (this._scrollVerticale == null) {
					this._scrollVerticale = new Scroll();
					this._scrollVerticale.addNewData("root", this);
					super.addChild(this._scrollVerticale);
					this._scrollVerticale.height = this._height;
					this._scrollVerticale.width = 20;
					this._scrollVerticale.x = this._width - this._scrollVerticale.width;
					this._scrollVerticale.y = this.y;
					this._scrollVerticale.addEventListener(Scroll.SCROLLS, MoveVertical);
					trace("Width= " + this.width);
				}else {
					super.removeChild(this._scrollVerticale);
					super.addChild(this._scrollVerticale);
				}
			}
			//super.removeChild(this._box);
			//super.addChild(this._box);
			return DO;
		}
		
		private function MoveVertical(e:Event):void {
			this._iframe.y = -((this._iframe.height - this._height) / 100) * this._scrollVerticale.Percent -this._scrollVerticale.getDataByName("btnUp").data.height;
		}
		
		private function resizeIframe():void {
			trace("RESIZE");
			if (this._scrollHorizontal != null) {
				
			}
			if (this._scrollVerticale != null) {
				this._scrollVerticale.height = this._height;
				this._scrollVerticale.x = this._width - this._scrollVerticale.width;
				this._scrollVerticale.y = this.y;
			}
		}
		
		override public function get width():Number { return this._width; }
		
		override public function set width(value:Number):void 
		{	
			this._width = value;
			this._box.width = value;
			this.resizeIframe();
		}
		
		override public function get height():Number { return this._height; }
		
		override public function set height(value:Number):void 
		{	
			this._height = value;
			this._box.height = value;
			this.resizeIframe();
		}
		
		public function get scrollVerticale():Scroll {
			if (this._scrollVerticale == null) {
				this._scrollVerticale = new Scroll();
				this._scrollVerticale.addNewData("root", this);
				super.addChild(this._scrollVerticale);
				this._scrollVerticale.height = this._height;
				this._scrollVerticale.width = 20;
				this._scrollVerticale.x = this._width - this._scrollVerticale.width;
				this._scrollVerticale.y = this.y;
				this._scrollVerticale.addEventListener(Scroll.SCROLLS, MoveVertical);
			}
			return this._scrollVerticale;
		}
		
		
	}
}