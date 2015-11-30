package utils.loka.button 
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	
	import utils.loka.bitmap.BitmapEdit;
	/**
	 * ...
	 * @author loka
	 */
	public class Config {
		public var TL:Bitmap;
		public var T:Bitmap;
		public var TR:Bitmap;
		public var L:Bitmap;
		public var BODY:Bitmap;
		public var R:Bitmap;
		public var BL:Bitmap;
		public var B:Bitmap;
		public var BR:Bitmap;
		
		public var PADDING_LEFT:Number = 1;
		public var PADDING_RIGHT:Number = 1;
		public var PADDING_TOP:Number = 1;
		public var PADDING_BOTTOM:Number = 1;
		/*public var BODY_HEIGHT:Number = 1;
		public var BODY_WIDTH:Number = 1;*/
		public var smoothing:Boolean = true;
		
		public function Config() {
			
		}
		
		public function create(VO:DisplayObject):void {
			TL = BitmapEdit.drawImg(VO, this.smoothing, 0, 0, PADDING_LEFT, PADDING_TOP);
			T = BitmapEdit.drawImg(VO, this.smoothing, PADDING_LEFT, 0, VO.width - PADDING_LEFT - PADDING_RIGHT, PADDING_TOP);
			TR = BitmapEdit.drawImg(VO, this.smoothing, VO.width - PADDING_RIGHT, 0, PADDING_RIGHT, PADDING_TOP);
			
			L = BitmapEdit.drawImg(VO, this.smoothing, 0, PADDING_TOP, PADDING_LEFT, VO.height - (PADDING_TOP + PADDING_BOTTOM));
			BODY = BitmapEdit.drawImg(VO, this.smoothing, PADDING_LEFT, PADDING_TOP, VO.width-(PADDING_LEFT+PADDING_RIGHT), VO.height - (PADDING_TOP + PADDING_BOTTOM));
			R = BitmapEdit.drawImg(VO, this.smoothing, VO.width-PADDING_RIGHT, PADDING_TOP, PADDING_RIGHT, VO.height - (PADDING_TOP + PADDING_BOTTOM));
			
			BL = BitmapEdit.drawImg(VO, this.smoothing, 0, VO.height-PADDING_BOTTOM, PADDING_LEFT, PADDING_BOTTOM);
			B = BitmapEdit.drawImg(VO, this.smoothing, PADDING_LEFT, VO.height-PADDING_BOTTOM, VO.width - (PADDING_LEFT+PADDING_RIGHT), PADDING_BOTTOM);
			BR = BitmapEdit.drawImg(VO, this.smoothing, VO.width-PADDING_RIGHT, VO.height-PADDING_BOTTOM, PADDING_RIGHT, PADDING_BOTTOM);
		}
	}

}