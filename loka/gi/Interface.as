package loka.gi{
	//import filter.FilterConteiner;
	import flash.display.Graphics;
	import flash.display.LineScaleMode;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.text.TextField;
	
	import loka.ui.text.GlobalTextFormat;

	/**
	 * ...
	 * @author AeroHills
	 */

	public class Interface {
	

		public function Interface() {
			
		}
		
		public static function btnRowsLeft():Shape {
			var rows:Shape = new Shape();
			var gr:Graphics = rows.graphics;
			gr.beginFill(0xfcb57d);
			gr.lineStyle(2, 0xbd7611);
			gr.moveTo(0, 15);
			gr.lineTo(15,0);
			gr.lineTo(20,0);
			gr.lineTo(20,35);
			gr.lineTo(15,35);
			gr.lineTo(0,20);
			gr.lineTo(0,15);
			gr.endFill();
			return rows;
		}
		public static function btnRowsRight():Shape {
			var rows:Shape = new Shape();
			var gr:Graphics = rows.graphics;
			gr.beginFill(0xfcb57d);
			gr.lineStyle(2, 0xbd7611);
			gr.moveTo(0, 0);
			gr.lineTo(5,0);
			gr.lineTo(20,15);
			gr.lineTo(20,20);
			gr.lineTo(5,35);
			gr.lineTo(0,35);
			gr.lineTo(0,0);
			gr.endFill();
			return rows;
		}
		
		public static function btnRowsLeftTo():Shape {
			var rows:Shape = new Shape();
			var gr:Graphics = rows.graphics;
			gr.beginFill(0xfcb57d);
			gr.lineStyle(2, 0xbd7611);
			gr.moveTo(0, 15);
			gr.lineTo(15,0);
			gr.lineTo(20,0);
			gr.lineTo(20,35);
			gr.lineTo(15,35);
			gr.lineTo(0,20);
			gr.lineTo(0,15);
			gr.endFill();
			
			gr.beginFill(0xfcb57d);
			gr.lineStyle(2, 0xbd7611);
			gr.drawRect(25, 0, 5, 35);
			gr.endFill();
			return rows;
		}
		public static function btnRowsRightTo():Shape {
			var rows:Shape = new Shape();
			var gr:Graphics = rows.graphics;
			gr.beginFill(0xfcb57d);
			gr.lineStyle(2, 0xbd7611);
			gr.drawRect(0, 0, 5, 35);
			gr.endFill();
			
			gr.beginFill(0xfcb57d);
			gr.lineStyle(2, 0xbd7611);
			gr.moveTo(10, 0);
			gr.lineTo(15,0);
			gr.lineTo(30,15);
			gr.lineTo(30,20);
			gr.lineTo(15,35);
			gr.lineTo(10,35);
			gr.lineTo(10,0);
			gr.endFill();
			return rows;
		}
		
		public static function btnRowsLeftToEnd():Shape {
			var rows:Shape = new Shape();
			var gr:Graphics = rows.graphics;
			gr.beginFill(0xfcb57d);
			gr.lineStyle(2, 0xbd7611);
			gr.drawRect(0, 0, 5, 35);
			gr.endFill();
			
			gr.beginFill(0xfcb57d);
			gr.lineStyle(2, 0xbd7611);
			gr.moveTo(10, 15);
			gr.lineTo(25,0);
			gr.lineTo(30,0);
			gr.lineTo(30,35);
			gr.lineTo(25,35);
			gr.lineTo(10,20);
			gr.lineTo(10,15);
			gr.endFill();
			
			
			return rows;
		}
		
		public static function btnRowsRightToEnd():Shape {
			var rows:Shape = new Shape();
			var gr:Graphics = rows.graphics;
			
			gr.beginFill(0xfcb57d);gr.lineStyle(2, 0xbd7611);gr.moveTo(0, 0);gr.lineTo(5,0);gr.lineTo(20,15);gr.lineTo(20,20);gr.lineTo(5,35);gr.lineTo(0,35);gr.lineTo(0,0);gr.endFill();
			
			gr.beginFill(0xfcb57d);gr.lineStyle(2, 0xbd7611);gr.drawRect(25, 0, 5, 35);gr.endFill();
			return rows;
		}
		
		
		public static function preloader():Sprite {
			var VO:Sprite = new Sprite();
			var gr:Graphics = VO.graphics;
			
			gr.beginFill(0x828FDF,.5);
			gr.drawRect( -25, -25, 50, 50);
			gr.endFill();
			
			return VO;
		}
		public static function CirclePreloader(r:Number, color:uint = 0x23D11F):Sprite {
			var VO:Sprite = new Sprite();
			var gr:Graphics = VO.graphics;
			
			gr.beginFill(color, 1);
			gr.drawCircle( 20, 0, r);
			gr.endFill();
			
			return VO;
		}
		public static function getRectVo(width:Number = 1, height:Number = 1, x:Number = 0, y:Number = 0 ):Shape {
			var VO:Shape = new Shape();
			var gr:Graphics = VO.graphics;
			
			gr.beginFill(0x828FDF,.5);
			gr.drawRect( x, y, width, height);
			gr.endFill();
			
			return VO;
		}
		public static function DrawLineRectRoundGradientVo(VO:Sprite, GO:GradientObject, x:Number = 0, y:Number = 0, width:Number = 1, height:Number = 1, radius:Number = 1, color:uint = 0xffffff, alpha:Number = 1):void {
			var gr:Graphics = VO.graphics;
			gr.lineStyle(2, color, alpha, true, LineScaleMode.NORMAL );
			gr.beginGradientFill(GO.fillType, GO.colors, GO.alphas, GO.ratios, GO.matr, GO.spreadMethod);
			gr.drawRoundRect( x, y, width, height, radius, radius);
			gr.endFill();
		}
		public static function DrawLineRectRoundVo(VO:Sprite, x:Number = 0, y:Number = 0, width:Number = 1, height:Number = 1, radius:Number = 1, color:uint = 0xffffff, alpha:Number = 1):void {
			//var VO:Sprite = new ClassDeffine();
			var gr:Graphics = VO.graphics;
			//gr.beginGradientFill
			gr.lineStyle(2, color, alpha);
			gr.drawRoundRect( x, y, width, height, radius, radius);
			gr.endFill();
			
			//return VO;
		}
		public static function getEaseTextField(texts:String = "", x:Number = 0, y:Number = 0, width:Number = 100, height:Number = 50, selectable:Boolean = false, TFType:uint = 0, addStroke:Boolean = true, border:Boolean = false):TextField {
			var text:TextField = new TextField();
			switch(TFType) {
				case GlobalTextFormat.BIG_LABEL: text.defaultTextFormat = GlobalTextFormat.Instance().StandartBigLabel();
				case GlobalTextFormat.LABEL: text.defaultTextFormat = GlobalTextFormat.Instance().StandartLabel();
				case GlobalTextFormat.LITTLE_LABEL: text.defaultTextFormat = GlobalTextFormat.Instance().StandartLittleLabel();
				case GlobalTextFormat.VERY_LITTLE_LABEL: text.defaultTextFormat = GlobalTextFormat.Instance().StandartVeryLittleLabel();
				default : text.defaultTextFormat = GlobalTextFormat.Instance().StandartLittleLabel();
			}
			
			//text.embedFonts = true;
			text.x = x;
			text.y = y;
			text.width = width;
			text.height = height;
			text.selectable = selectable;
			text.text = texts;
			text.border = border;
			if (addStroke) {
				//text.filters = FilterConteiner.AddStroke();
			}
			return text;
		}
		public static function drawCircle(instace:Object, nameSpace:Class, x:Number = 0, y:Number = 0, radius:Number = 1, color:uint = 0xffffff, alpha:Number = 1, alphaLine:Number = 0):Object {
			//var VO:Shape = new Shape();
			var gr:Graphics = (instace as nameSpace).graphics;
			gr.lineStyle(1, color, alphaLine);
			gr.beginFill(color, alpha);
			gr.drawCircle( x, y, radius);
			gr.endFill();
			
			return instace;
		}
		public static function getCircle(x:Number = 0, y:Number = 0, radius:Number = 1, color:uint = 0xffffff, alpha:Number = 1):Shape {
			var VO:Shape = new Shape();
			var gr:Graphics = VO.graphics;
			
			gr.beginFill(color, alpha);
			gr.drawCircle( x, y, radius);
			gr.endFill();
			
			return VO;
		}
		public static function getRectRoundVo(x:Number = 0, y:Number = 0, width:Number=1, height:Number = 1, radius:Number = 1,color:uint=0xffffff,alpha:Number = 1):Shape {
			var VO:Shape = new Shape();
			var gr:Graphics = VO.graphics;
			
			gr.beginFill(color,alpha);
			gr.drawRoundRect( x, y, width, height, radius, radius);
			gr.endFill();
			
			return VO;
		}
	}
}