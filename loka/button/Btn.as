package loka.button {
//	import Math.*;
	
	import flash.display.*;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.text.*;
	
	import loka.button.btnEffect.BtnEffect;
	import loka.console.Console;
	import loka.filters.*;
	import loka.text.TextUtils;

	/**
	 * ...
	 * @author loka
	 */
	public class Btn extends Sprite{
        protected var _btn: Sprite = new Sprite();// = new MovieClip();
        protected var _txt: TextField = new TextField();
        protected var _color1:uint = 0x5263FE; 
        protected var _color2:uint = 0x96A0FE; 
        protected var _textColor:uint = 0x000000; 
        
        protected var _btnEffect:BtnEffect;
		public function Btn() {
			
		}
		public function createBtnRect(w:Number, Text:String=''):Sprite {
			//var btn: MovieClip = new MovieClip();
			//var 
			if (Text == null) Text = "Error text!";
			_txt.text = Text;
			_txt.autoSize = TextFieldAutoSize.CENTER;
			
				var matrix:Matrix = new Matrix(); 
				matrix.createGradientBox( 50, 10, -Math.PI * 0.8, 1.5, 1.5); 
				var colors:Array = [ this._color1 , this._color2]; 
				var alphas:Array = [100, 100]; 
				var ratios:Array = [0x00, 0x83]; 
				//btn.graphics.lineStyle(1,0xA0A0A0,1,false,LineScaleMode.NONE); 
				_btn.graphics.beginGradientFill(GradientType.LINEAR, colors, alphas, ratios, matrix,SpreadMethod.PAD,InterpolationMethod.RGB,0.45); 
				//btn.graphics.drawCircle(5, 5,10); 
                if(_txt.width + 10> w)
                {
				_btn.graphics.drawRoundRect(0, 0, _txt.width + 10, _txt.height + 5, (20 / 100) * 40);
                }else{
                    _btn.graphics.drawRoundRect(0, 0, w, _txt.height + 5, (20 / 100) * 40);
                }
				_btn.graphics.endFill(); 

//			_btn.x = x;
//			_btn.y = y;
			//_btn.scaleX = w / 100;
			//_btn.scaleY = w / 100;
			//btn.
			_txt.y = _btn.height / 2 - _txt.height / 2;
			_txt.x = _btn.width / 2 - _txt.width / 2;
			_btn.addChild(_txt);
			
			_btn.useHandCursor = true;
			_btn.buttonMode = true;
			_btn.mouseChildren = false;
			//addEventListener();
			//return btn;
			this.addChild(this._btn);
			/*this._btn.addEventListener(MouseEvent.MOUSE_OVER, MOver);
			this._btn.addEventListener(MouseEvent.MOUSE_OUT, MOut);
			this._btn.addEventListener(MouseEvent.MOUSE_DOWN, MDown);
			this._btn.addEventListener(MouseEvent.MOUSE_UP, MUp);
			this._btn.filters = SampleFilters.DarkedFilter(1.2);*/
			this._btnEffect = new BtnEffect(this._btn);
			TextUtils.changeColor(_txt, _textColor);
			return this;
		}
        
		public function set enable(value:Boolean):void 
        {
            this._btnEffect.enableInner = value;
            if(!value)
            {
                TextUtils.changeColor(_txt, Console.GREEY);
            } else {
                TextUtils.changeColor(_txt, _textColor);
            }
        }
        
		public function set caption(val:String):void {
			this._txt.text = val;
		}
		public function get caption():String {
			return this._txt.text;
		}
		public function set color1(value:uint):void { this._color1 = value; }
		public function set color2(value:uint):void { this._color2 = value; }
		public function set textColor(value:uint):void { this._textColor = value; }
		
		private function MOver(e:Event):void {
			this._btn.filters = SampleFilters.DarkedFilter(0);
		}
		private function MOut(e:Event):void {
			this._btn.filters = SampleFilters.DarkedFilter(1.2);
		}
		private function MDown(e:Event):void {
			this._btn.filters = SampleFilters.DarkedFilter(1.6);
		}
		private function MUp(e:Event):void {
			this._btn.filters = SampleFilters.DarkedFilter(0);
		}
	}
	
}