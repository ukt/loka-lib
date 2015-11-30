package loka.asUtils {

	/**
	 * ...
	 * @author Loka
	 */
	public class Rotation {
	
		
		public function Rotation() {

		}
		
		public static function getTheDifferenceOfDegrees(degrees1:Number, degrees2:Number):Number {
			return (degrees1+180)-(degrees2+180)
		}
		public static function getDegreesBetween(degrees1:Number, degrees2:Number):Number {
			var result:Number = Math.abs(degrees1 - degrees2);
			if(result<=180){
				return result*(degrees2>degrees1?1:-1);
			} else {
				return ((180-Math.abs(degrees1)) + (180-Math.abs(degrees2)))*(degrees1>0?1:-1);
			}
		}
		
	}

}