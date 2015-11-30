package loka.text
{
	import flash.display.DisplayObjectContainer;
	import flash.geom.Rectangle;
	import flash.text.AntiAliasType;
	import flash.text.GridFitType;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFormat;

	public class TextUtils
	{
		public function TextUtils()
		{
			
		}
		
		public static function changeLeading (tf:TextField, value:int = 1):void 
		{
			var format:TextFormat = tf.getTextFormat();
			format.leading = value;
			tf.setTextFormat(format);
			tf.defaultTextFormat = format;
		}
		
		public static function addTextWithColor(tf:TextField, text:String, color:uint = 0xffffff):void{
			if(text){
				tf.appendText(text);
				changeColor(tf, color, tf.text.length - text.length, tf.text.length);
			}
		}
		
		public static function addHtmlTextWithColor(tf:TextField, text:String, color:uint = 0xffffff):void {
			var styleSheet:StyleSheet = tf.styleSheet;
			if(!styleSheet){
				styleSheet = new StyleSheet();
			}
			var className:String = "color_" + color;
			styleSheet.setStyle("." + className,  {color:'#'+color.toString(16).toUpperCase()});
			tf.htmlText = tf.htmlText + "<span class='"+className+"'>" + text + "</span>";
			tf.styleSheet = styleSheet;
		}
		
		public static function changeColor(tf:TextField, color:uint = 0xffffff, startPosition:int = -1, endPosition:int = -1):void 
		{
			var format:TextFormat = tf.getTextFormat();
			format.color = color;
			tf.setTextFormat(format, startPosition, endPosition);
			tf.defaultTextFormat = format;
		}
		
		public static function changeSize(tf:TextField, size:uint):void{
			var format:TextFormat = tf.getTextFormat();
			format.size = size;	
			tf.setTextFormat(format);
			tf.defaultTextFormat = format;
		}
		
        public static function setBold(tf:TextField, value:Boolean):void{
			var format:TextFormat = tf.getTextFormat();
            format.bold = value;	
			tf.setTextFormat(format);
			tf.defaultTextFormat = format;
		}
		
		public static function setAlign(tf:TextField, align:String):TextField{
			var format:TextFormat = tf.getTextFormat();
			format.align = align;
			tf.setTextFormat(format);
//			tf.border = true;
			tf.defaultTextFormat = format;
			return tf;
		}
			
		public static function updateTextField(tf:TextField, embedFonts:Boolean = false):TextField{
			var txtFormat:TextFormat = tf.getTextFormat(); 
			var newTf:TextField = new TextField();
			newTf.text = tf.text;
			newTf.x = tf.x;
			newTf.y = tf.y;
			newTf.width = tf.width;
			newTf.height = tf.height;
			newTf.border = tf.border;// = true;
//			newTf.setTextFormat(new TextFormat());
			newTf.defaultTextFormat = txtFormat;
			newTf.setTextFormat(txtFormat);
			newTf.embedFonts = tf.embedFonts;
			newTf.embedFonts = embedFonts;
			newTf.name = tf.name;
			newTf.selectable = tf.selectable;
			var tfParent:DisplayObjectContainer = tf.parent; 
			if(tfParent){
				tfParent.addChild(newTf);
				tfParent.removeChild(tf)
			}
			return newTf;
		}
		
		public static function setStyle(tf:TextField, fontSize:Number = -1, bold:Boolean = false, font:String = ""):TextField
		{			
			if(tf == null){
				return null;
			}
			
			var origX:Number = tf.x;
			var origY:Number = tf.y;
			var origW:Number = tf.width;
			var origH:Number = tf.height;
			var origTextH:Number = tf.textHeight;
			var origChar:Rectangle = tf.getCharBoundaries(0);
			
			if(font == "")
				font = "Verdana";//FontsEnum.MAIN;
			
			var textFormat:TextFormat = tf.getTextFormat();
			textFormat.font = font;
			textFormat.bold = bold;
			
			if(fontSize > -1)
				textFormat.size = fontSize;
			
			tf.setTextFormat(textFormat);			
			tf.defaultTextFormat = textFormat;
			tf.antiAliasType = AntiAliasType.ADVANCED;
			tf.embedFonts = true;
			tf.gridFitType = GridFitType.SUBPIXEL;
			tf.multiline = false;
			
			tf.y = int(origY + (origTextH - tf.textHeight)) + 1;
			
			if (textFormat.color >= 0xfffffe) 
			{
				tf.thickness = -150;
				tf.sharpness = 10;
			}
			return tf; 
		}
	}
}