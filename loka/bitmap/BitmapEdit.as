package utils.loka.bitmap {
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.PixelSnapping;
	import flash.geom.Matrix;

	import utils.loka.console.Console;

	/**
	 * ...
	 * @author loka
	 */
	public class BitmapEdit	{
		
		public function BitmapEdit() {
			
		}
		public static var TRANSPARENT:Boolean = true;	
		public static function drawImgNew(el:DisplayObject, smoothing:Boolean = true, x:Number = 0, y:Number = 0, width:Number = 0, height:Number = 0):Bitmap {
			var bitMapDat:BitmapData;
			if (el == null) {
				bitMapDat = new BitmapData(Math.round(2), Math.round(2), false, 0xFF0000);
				return new Bitmap(bitMapDat);
			}
			var matrix:Matrix = new Matrix();
// TO DO need check this;
			/*if (x==0) matrix.tx = -el.x; else */matrix.tx = -x;
			/*if (y==0) matrix.ty = -el.y; else */matrix.ty = -y;
			if (width == 0.0) width = el.width;
			if (height == 0.0) height = el.height;
			if(height < 1)
			{
				height = 1;
			}
			if(width < 1)
			{
				width = 1;
			}
			if (TRANSPARENT) {
				bitMapDat = new BitmapData(Math.round(width), Math.round(height), true, 0x00000000);
			}else{
				bitMapDat = new BitmapData(Math.round(width), Math.round(height), false, 0x000000);
			}
			bitMapDat.unlock();
			bitMapDat.draw(el, matrix, null, null, null, smoothing);
			var bitMap:Bitmap = new Bitmap(bitMapDat);
			bitMap.smoothing = smoothing;
			bitMap.pixelSnapping = PixelSnapping.NEVER;
			TRANSPARENT = true;
			return bitMap;
		}

		public static function drawImg(el:DisplayObject, smoothing:Boolean = true, x:Number = 0, y:Number = 0, width:Number = 0, height:Number = 0):Bitmap {
			var matrix:Matrix = new Matrix();
			if (x == 0) matrix.tx = -x; else matrix.tx = -x;
			if (y == 0) matrix.ty = -y; else matrix.ty = -y;
			if (width == 0) width = el.width;
			if (height == 0) height = el.height;
			if(height < 1)
			{
				height = 1;
			}
			if(width < 1)
			{
				width = 1;
			}
			var bitMapDat:BitmapData = new BitmapData(width, height, true, 0x00000000);
			bitMapDat.unlock();
			bitMapDat.draw(el, matrix);
			var bitMap:Bitmap = new Bitmap(bitMapDat);
			bitMap.smoothing = smoothing;
			return bitMap;
		}
		
		/**
		 * TODO: optimization
		 * 
		 * Alternate method for BitmapData.getColorBoundsRect() 
		 * 
		 * @param DO DisplayObject --should be ONLY Bitmap or BitmapData (raw data)
		 * @return Custom rectangle (x, y, width, height, bottom, right) as RectVO
		 * 
		 */
		public static function getRectColoresPixels(DO:*, colorGround:uint = 0):RectVO {
			
			var bitmapData:BitmapData = null;
			
			if (DO is Bitmap) {
				bitmapData = (DO as Bitmap).bitmapData;
			} else if (DO is DisplayObject) {
				var DOB:Bitmap 	= BitmapEdit.drawImgNew(DO);
				bitmapData = DOB.bitmapData;				
			} else if (DO is BitmapData) {
				bitmapData = DO;
			}
				
			var x:int 		= 0;
			var y:int 		= 0;
			
			var xI:int		= 0;
			var yI:int		= 0;
			
			var bitmapDataWidth:uint	= int(bitmapData.width);
			var bitmapDataHeight:uint	= int(bitmapData.height);
			var width:uint				= bitmapDataWidth;
			var height:uint				= bitmapDataHeight;
			
			var xMax:uint 				= 0;
			var yMax:uint 				= 0;
			
			var xMin:uint 				= 0;
			var yMin:uint 				= 0;
			
			var rect:RectVO = new RectVO();
			var statusDoing:Boolean = true;
			
			if(bitmapData.height<=1||bitmapData.width<=1)
			{
				rect.x = 0;
				rect.y = 0;
				rect.width = 1;
				rect.height = 1;
				return rect;
			}
			while (statusDoing) {
				var pixelColor:uint;
				x = xI;
				while (x <= width) {	
					pixelColor = bitmapData.getPixel32(x, yI);
					if(pixelColor != colorGround){
						width = x;
						if(yMin == 0 ){
							yMin = yI;
						}
					}
					x++
				}
				y = yI;
				while (y <= height) {
					pixelColor = bitmapData.getPixel32(xI, y);
					if(pixelColor != colorGround){
						height = y;
						if(xMin ==0 ){
							xMin = xI;
						}
					}	
					y++;
				}
				if (xMin ==0) {
					xI++;
				}
				if (yMin ==0) {
					yI++;
				}
				if (xMin > 0 && yMin > 0) {
					statusDoing = false;
				}
				if (xI >= width && yI >= height) {
					statusDoing = false;
				}
			}
			statusDoing = true;
			x = bitmapDataWidth;
			y = bitmapDataHeight;
			width = xMin;
			height = yMin;
			xI = bitmapDataWidth;
			yI = bitmapDataHeight;
			while (statusDoing) {
				x = xI;
				while (x >= width) {
					pixelColor = bitmapData.getPixel32(x, yI);
					if(pixelColor != colorGround){
						width = x;
						if(yMax == 0 ){
							yMax = yI;
						}
					}
					x--
				}
				//xI--;
				if (xMax == 0) {
					xI--;
				}
				if (xI < 0) {
					xI = 0;
				}
				y = yI;
				while (y >= height) {
					pixelColor = bitmapData.getPixel32(xI, y);
					if(pixelColor != colorGround){
						height = y;
						if(xMax == 0 ){
							xMax = xI;
						}
					}
					y--;
				}
				
				if (yMax == 0) {
					yI--;
				}
				//yI--;
				if (yI < 0) {
					yI = 0;
				}
				if (xMax > 0 && yMax > 0) {
					statusDoing = false;
				}
				if (xI <= 0 && yI <= 0) {
					statusDoing = false;
				}
			}
			
			rect.x 			= xMin;
			rect.y 			= yMin;
			
			rect.width 		= xMax - xMin;
			rect.height 	= yMax - yMin;
			
			rect.right 		= bitmapDataWidth  - xMax;
			rect.bottom 	= bitmapDataHeight - yMax;
			
			return rect;
		}
		
		public static function getRectColoresPixelsOldTrace(DO:*):RectVO {
			var bitmapData:BitmapData = null;
			
			if (DO is DisplayObject) 
			{
				var DOB:Bitmap 	= BitmapEdit.drawImgNew(DO);
				bitmapData = DOB.bitmapData;				
			}
			else if (DO is BitmapData)
			{
				bitmapData = DO;
			}
				
			var x:uint 		= 0;
			var y:uint 		= 0;
			
			var bitmapDataWidth:uint 	= int(bitmapData.width);
			var bitmapDataHeight:uint 	= int(bitmapData.height);
			
			var xMax:uint 	= int(bitmapData.width);
			var yMax:uint 	= int(bitmapData.height);
			
			var xMin:uint 	= 0;
			var yMin:uint 	= 0;
			var rect:RectVO = new RectVO();
			for (y = 0; y <= bitmapDataWidth; ++y) {
				if(y.toString().length<=1){
					write(" ", 0x00FF00, false);
				}else {
					write(y.toString().substr(0, 1), 0x00FF00, false);
				}
			}
			write(" ");
			for (y = 0; y <= bitmapDataWidth; ++y) {
				write(y.toString().substr(y.toString().length - 1, 1), 0x00FF00, false);
			}
			for (y = 0; y <= bitmapDataHeight; ++y) {
				for (x = 0; x <= bitmapDataWidth; ++x) {
					var pixelColor:uint = bitmapData.getPixel32(x, y);
					if(pixelColor > 0){
						if (xMax > x) {
							xMax = x;
						}
						if (yMax > y) {
							yMax = y;
						}
						if (xMin < x) {
							xMin = x;
						}
						if (yMin < y) {
							yMin = y;
						}
					}
					write("•", pixelColor, false);
				}
				write(" ");
			}
			rect.x 			= xMax;
			rect.y 			= yMax;
			
			rect.width 		= xMin - rect.x;
			rect.height 	= yMin - rect.y;
			
			rect.right 		= bitmapDataWidth - xMin;
			rect.bottom 	= bitmapDataHeight - yMin;
			return rect;
		}
		
		private static var _strTrace:String = "";
		private static function write(value:Object, color:uint = 0xFFFFFF, wrap:Boolean = true):void {
			Console.write(value, color, wrap);
		}
	}

}