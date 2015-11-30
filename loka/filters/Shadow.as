package loka.filters {
	import flash.display.*;
	import flash.filters.BevelFilter;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BitmapFilterType;
	/**
	 * ...
	 * @author loka
	 */
	
	public class Shadow {
		
		public function Shadow() {
			
		}
		public static function get Filter():Array {
			var bevel:BevelFilter = new BevelFilter();

			bevel.distance = 5;
			bevel.angle = 150;
			bevel.highlightColor = 0xFFFF00;
			bevel.highlightAlpha = 0.2;
			bevel.shadowColor = 0x666666;
			bevel.shadowAlpha = 0.8;
			bevel.blurX = 5;
			bevel.blurY = 5;
			bevel.strength = 5;
			bevel.quality = BitmapFilterQuality.HIGH;
			bevel.type = BitmapFilterType.INNER;
			bevel.knockout = false;
			return [bevel];
		}
		
		public static function FilterColor(highlightColor:uint,shadowColor:uint):Array {
			var bevel:BevelFilter = new BevelFilter();

			bevel.distance = 5;
			bevel.angle = 270;
			bevel.highlightColor = highlightColor;
			bevel.highlightAlpha = 0.8;
			bevel.shadowColor = shadowColor;
			bevel.shadowAlpha = 0.8;
			bevel.blurX = 0;
			bevel.blurY = 5;
			bevel.strength = 15;
			bevel.quality = BitmapFilterQuality.HIGH;
			bevel.type = BitmapFilterType.INNER;
			bevel.knockout = false;
			return [bevel];
		}
		
	}
	
}