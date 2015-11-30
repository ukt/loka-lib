package loka.graph {
	import flash.display.GradientType;
	import flash.display.Shape;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;

	//import ascb.util.ArrayUtilities;
	/**
	 * ...
	 * @author loka
	 */
	public class Graph extends Sprite	{
		private var pen:Canvas = new Canvas();
		//private var _txt:TextImage = new TextImage(100, 40);
		private var _rect:Rectangle;
		private var _h:Number = 0;
		private var _i:Number = 0;
		private var _Nnull:Number = 0;//kolvo nullelement
		private var _rad:Number = 0;
		private var _graphHat:Sprite = new Sprite();
		private var _graphBody:Sprite = new Sprite();
		private var _graph:Sprite = new Sprite();
		private var _line:Sprite = new Sprite();
		private var _graphObj:Shape = new Shape();
		private var _graphKnife:Sprite = new Sprite();
		private var _arrEl:Array = new Array();
		private var _arrElTxt:Array = new Array();
		private var _arrObj:Object = new Object();
		private var _notNull:Boolean = false;//povrka na vse elementu ili NULL true-vse != null
		private var _Line:LineMoved; 
		
		public function Graph(rad:Number=12) {
			this.pen.bckColor = 0xffff00;
			this.pen.lineColor = 0x000000;
			this._rad = rad;
			this.pen._Radian = this._rad;
			
		}
		
		public static function getFullRectangle(x:Number,y:Number,w:Number=10, h:Number=10, color:uint=0x000000, alpha:Number = 1, borderColor:uint = 0x000000, borderWidth:Number = 0, borderAlpha:Number = 0):Sprite 
		{
			var rects:Sprite = new Sprite();
			rects.graphics.beginFill(color, alpha);
			rects.graphics.lineStyle(borderWidth, borderColor, borderAlpha);
			rects.graphics.drawRect(x, y, w, h);
			return rects;
		}
		
		public static function getRectangle(x:Number,y:Number,w:Number=10, h:Number=10,color:uint=0x000000):Sprite 
		{
			var rects:Sprite = new Sprite();
			rects.graphics.beginFill(color);
			rects.graphics.lineStyle(2,0x000000, .51);
			rects.graphics.drawRect(x,y,w,h);
			return rects;
		}
		public static function getRect(w:Number=10, h:Number=10,color:uint=0x000000):Sprite {
			var rects:Sprite = new Sprite();
			rects.graphics.beginFill(color, 1);
			
			rects.graphics.drawRect(0,0,w,h);
			return rects;
		}
		
		public static function getRectColor(color:uint=0x000000):Sprite {
			return Graph.getRect(10,10,color);
		}
		
		public static function drawCircle(x:Number, y:Number, r:Number, start:Number=1, stop:Number=1, lineColor:uint = 0xcecece, gradientColor1:uint = 0x000000, gradientColor2:uint = 0x000000, rad:Number = 0):Sprite {
			var paddingRad:Number = 1;
			var rects:Sprite = new Sprite();
			//var rad:Number= 0;//Math.PI / 2;
//				this.proporties();
			var fillType:String = GradientType.LINEAR;
//			var colors:Array = [color2, color2  - 0xaaaaaa];
			var colors:Array = [gradientColor1, gradientColor2];
			var alphas:Array = [1, 1];
			var ratios:Array = [0x00, 0xFF];
			var matr:Matrix = new Matrix();
			matr.createGradientBox(r * 2, r * 2,(Math.PI) / 2, 0, 0);
//			matr.rotate((3 * Math.PI) / 2);
			var spreadMethod:String = SpreadMethod.PAD;
			rects.graphics.beginGradientFill(fillType, colors, alphas, ratios, matr, spreadMethod);        
//			this.graphics.drawRect(0,0,100,100);
			
			rects.graphics.lineStyle(2.5, lineColor, 1);
			
//			rects.graphics.beginFill(color2, 1); 
//			rects.graphics.beginGradientFill(color2, 1); 
			
//			rects.graphics.moveTo(x, y);
//			var 
			start	= start	* 2 * Math.PI;
			stop	= stop	* 2 * Math.PI;
			rects.graphics.moveTo(		x + paddingRad * -Math.cos(start + Math.PI + rad), y + (paddingRad) * Math.sin(start + Math.PI + rad));
			rects.graphics.lineTo(		x + r * -Math.cos(start + Math.PI + rad), y + (r) * Math.sin(start + Math.PI + rad));
			while(start <= stop){
				rects.graphics.lineTo(	x + r * -Math.cos(start + Math.PI + rad), y + (r) * Math.sin(start + Math.PI + rad));
				start += 0.005;
			}
//			rects.graphics.lineTo(		x + r * -Math.cos(start + Math.PI + _Rad), y + (r) * Math.sin(start + Math.PI + _Rad));
//			rects.graphics.lineTo(		x + paddingRad * -Math.cos(stop - .50 + Math.PI + _Rad), y + (paddingRad) * Math.sin(stop - .50 + Math.PI + _Rad));
			rects.graphics.lineTo(		x + paddingRad * -Math.cos(stop + Math.PI + rad), y + (paddingRad) * Math.sin(stop + Math.PI + rad));
//			rects.graphics.lineTo(x, y);
			rects.graphics.endFill();
			return rects;
		}
        
		public static function getCircle(x:Number=10, y:Number=10,r:Number=5,color:uint=0x000000):Sprite {
			var rects:Sprite = new Sprite();
			rects.graphics.beginFill(color);
			rects.graphics.drawCircle(x,y,r);
			return rects;
		}
		
	}
	
}