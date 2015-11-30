package utils.loka.button
{
	import flash.display.*;
	import flash.geom.Matrix;
	import flash.text.*;
	
	import utils.loka.button.btnEffect.BtnEffect;
	
	public class Buttones
	{	
		public static function createRectBtn(x:Number,y:Number,width:Number,Text:String = ""):MovieClip
		{
			
			var btn: MovieClip = new MovieClip();
			var txt: TextField = new TextField();
			txt.text = Text;
			txt.autoSize = TextFieldAutoSize.CENTER;
			
				var matrix:Matrix = new Matrix(); 
				matrix.createGradientBox(50, 10, -Math.PI*0.8, 1.5, 1.5); 
				var colors:Array = [ 0x5263FE , 0x96A0FE]; 
				var alphas:Array = [100, 100]; 
				var ratios:Array = [0x00, 0x83]; 
				btn.graphics.beginGradientFill(GradientType.LINEAR, colors, alphas, ratios, matrix,SpreadMethod.PAD,InterpolationMethod.RGB,0.45); 
				btn.graphics.drawRoundRect(0, 0, 50, 20, (20/100)*40);
				btn.graphics.endFill(); 

			btn.x = x;
			btn.y = y;
			btn.width = width;
			btn.height = width/4;
			txt.y = 20/2-txt.height/2;
			txt.x = 25 - txt.width / 2;
			btn.addChild(txt);
			
			btn.useHandCursor = true;
			btn.buttonMode = true;
			btn.mouseChildren = false;
			
			new BtnEffect(btn);
			
			return btn;
		}
	}
	
}