package loka.console {
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import loka.button.btnEffect.BtnEffect;
	import loka.drags.Drags;

	public class BackgroundConsole extends Sprite {
		private var _headerHeight:Number = 10;
		private var _width:Number = 0;
		private var _height:Number = 0;
		private var _xOfsset:Number = 0;
		private var _yOfsset:Number = 0;
		private var _header:Sprite;
		private var _headerExitBtn:Sprite;
		private var _body:Sprite;
		private var _alpha:Number = 0;
		private var _drager:Drags;
		private var _resizingArrow:Sprite;
		private var _dragerForresizing:Drags;
		protected static var _backGround: Shape;
		
		public function BackgroundConsole() {
			if(!stage){
				addEventListener(Event.ADDED_TO_STAGE, initialize);
			} else {
				initialize();
			}
		}
		
		public function get backGround():Shape {
			return _backGround;
		}

		private function initialize(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, initialize);
			addEventListener(Event.ADDED_TO_STAGE, updatePosition);
			addEventListener(Event.ADDED, updatePosition);
			_header = new Sprite();
			_header.addEventListener(MouseEvent.MOUSE_OVER, onHeaderOver);
			_header.addEventListener(MouseEvent.MOUSE_OUT, onHeaderOut);
			_header.addEventListener(MouseEvent.MOUSE_DOWN, onHeaderDown);
			_header.addEventListener(MouseEvent.MOUSE_UP, onHeaderUp);
			_header.buttonMode = true;
			_header.tabEnabled = false;
			_body = new Sprite();
			_body.y += _headerHeight;
			
			_headerExitBtn = new Sprite();
			_headerExitBtn.addEventListener(MouseEvent.CLICK, closeConsole)
				
			_header.addChild(_headerExitBtn);
			
			new BtnEffect(_headerExitBtn);
			
			_drager = new Drags(this, false);
			_drager.hide(true);
			_drager.addEventListener(Drags.DRAGED_STOP, onStopDrag);
			_resizingArrow = new Sprite();
			_resizingArrow.buttonMode = true;
			_resizingArrow.tabEnabled = false;
			_dragerForresizing = new Drags(_resizingArrow);
			_dragerForresizing.addEventListener(Drags.DRAGED, updatePosition);
			
			_backGround = new Shape();
			_backGround.graphics.beginFill(0x000000, .6);
			_backGround.graphics.drawRect(0, 0, 1, 1);
			_backGround.graphics.endFill();
			_backGround.visible				= false;
			addChild(_backGround);
			update();
			
			_width = stage.stageWidth;
			_height = stage.stageHeight - _headerHeight;
			
			_resizingArrow.x = _width;
			_resizingArrow.y = _height;
			
		}
		
		protected function onStopDrag(event:Event):void {
			xOfsset = x;
			yOfsset = y;
		}
		
		protected function closeConsole(event:Event):void {
			Console.instance.openConsole();
		}
		
		protected function updatePosition(event:Event):void {
			_width = _resizingArrow.x;
			_height = _resizingArrow.y;
			Console.instance.update();
		}
		
		protected function onHeaderUp(event:MouseEvent):void {
			_drager.stop();	
			xOfsset = x;
			yOfsset = y;
		}
		
		protected function onHeaderDown(event:MouseEvent):void {
			if(event.target === _header) {
				_drager.start();
			}
		}
		
		protected function onHeaderOut(event:MouseEvent):void {
			if(event.target === _header){
				_alpha = 0;
				update();
			}
		}
		
		protected function onHeaderOver(event:MouseEvent):void {
			if(event.target === _header || event.target === _headerExitBtn){
				_alpha = .5;
				update();
			}
		}
		
		public function update():void{
			draw();
			
			addChild(_body);
			addChild(_header);
			addChild(_resizingArrow);
			
			_headerExitBtn.x = _width - 7;
			_headerExitBtn.y = 3;
			
			_backGround.width 	= _width;
			_backGround.height 	= _height;
		}
		
		private function draw():void {
			_header.graphics.clear();
			_header.graphics.beginFill(Console.GREEY_LIGHT, _alpha);
			_header.graphics.drawRect(0,0, _width, _headerHeight);
			_header.graphics.endFill();
			
			_headerExitBtn.graphics.clear();
			_headerExitBtn.graphics.beginFill(Console.RED, _alpha * 1.7);
			_headerExitBtn.graphics.lineStyle(1);
			_headerExitBtn.graphics.drawRect(0, 0, 5, 5);
			_headerExitBtn.graphics.endFill();
			
			_resizingArrow.graphics.clear();
			_resizingArrow.graphics.beginFill(Console.GREEY_LIGHT, .5);
			_resizingArrow.graphics.lineStyle(1);
			_resizingArrow.graphics.moveTo(0, -_headerHeight);
			_resizingArrow.graphics.lineTo(0, -_headerHeight * 2);
			_resizingArrow.graphics.lineTo(0 - _headerHeight, -_headerHeight);
			_resizingArrow.graphics.lineTo(0, -_headerHeight);
			_resizingArrow.graphics.endFill();
			
		}
		
		public function hideAllButThis(displayObject:DisplayObject):void {
			for(var index:uint = 0;index<_body.numChildren;index++){
				var childAt:DisplayObject = _body.getChildAt(index);
				if(displayObject !== childAt) {
					childAt.visible = false;
				}
			}
		}

		override public function get width():Number {
			return _width;
		}
		
		override public function set width(value:Number):void {
			_width = value;
			update();
		}
		
		override public function get height():Number {
			return _height;
		}
		
		override public function set height(value:Number):void {
			_height = value;
			update();
		}
		
		override public function set visible(value:Boolean):void {
			super.visible = value;
			_backGround.visible = value;
		}
		
		override public function addChild(child:DisplayObject):DisplayObject {
			if(
				child === _header || 
				child === _body || 
				child === _resizingArrow
			){
				
			} else {
				_body.addChild(child);
				return child;
			}
			return super.addChild(child);
		}
		
		public function get headerHeight():Number {
			return _headerHeight;
		}
		
		public function set headerHeight(value:Number):void {
			_headerHeight = value;
			update();
		}
		
		public function get headerWidth():Number {
			return _width;
		}
		
		public function set headerWidth(value:Number):void {
			_width = value;
			update();
		}

		public function get xOfsset():Number {
			return _xOfsset;
		}

		public function set xOfsset(value:Number):void {
			_xOfsset = value;
		}

		public function get yOfsset():Number {
			return _yOfsset;
		}

		public function set yOfsset(value:Number):void {
			_yOfsset = value;
		}
	}
}