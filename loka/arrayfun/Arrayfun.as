package loka.arrayfun {
	
	/**
	 * ...
	 * @author loka
	 */
	public class Arrayfun extends Array{
		
		public function Arrayfun() {
			
		}
		
		public static function max(arr:Array):Number {
			var aCopy:Array = arr.concat();
			 aCopy.sort(Array.NUMERIC);
			 var nMaximum:Number = Number(aCopy.pop());
			 return nMaximum;
		}
		
		public static function sum(arr:Array):Number {
			var sum:Number = 0;
			for (var i:uint = 0; i <= arr.length - 1; i++ ) {
				sum += arr[i];
			}
			return sum;
		}
		
		public static function arrToStr(arr:Array, enter:Boolean=false):String {
			var str:String = '';
			for (var i:uint = 0; i <= arr.length - 1; i++ ) {
				str += arr[i].toString();
				if (enter) str += "\n";
			}
			return str;
		}
		
	}
	
}