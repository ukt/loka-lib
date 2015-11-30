package utils.loka.filters {
	import flash.filters.ColorMatrixFilter;
	/**
	 * ...
	 * @author loka
	 */
	public class BlendFillter{
		
		public function BlendFillter(){
			
		}
		public static function getFilter(color:String):Array {
			var str:String = color.toString();
			var col1:uint = parseInt("0x" + str.substr(2, 2));
			var col2:uint = parseInt("0x" + str.substr(4, 2));
			var col3:uint = parseInt("0x" + str.substr(6, 2));
			//trace("[" + col1 + " - " + col2 + " - " + col3 + "]");
			var matrix:Array = new Array();
			matrix = matrix.concat([(1/255)*col1, 0, 0, 0, 0]); // red
			matrix = matrix.concat([0, (1/255)*col2, 0, 0, 0]); // green
			matrix = matrix.concat([0, 0, (1/255)*col3, 0, 0]); // blue
			matrix = matrix.concat([0, 0, 0, 1, 0]); // alpha
			var filter:ColorMatrixFilter = new ColorMatrixFilter(matrix);
			//var filters:Array = new Array();
			//filters[0]=filter;
			return [filter];
		}
		
	}

}