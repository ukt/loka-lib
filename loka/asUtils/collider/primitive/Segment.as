package loka.asUtils.collider.primitive {
	import flash.geom.Point;

	/**
	 * ...
	 * @author Loka
	 */
	public class Segment{
		protected var _p1:Point;
		protected var _p2:Point;
	
		
		public function Segment(p1:Point, p2:Point) {
			this._p2 = p2?p2.clone():new Point();
			this._p1 = p1?p1.clone():new Point();
		}
		
		public function get point1():Point {
			return _p1;
		}
		
		public function set point1(value:Point):void {
			_p1 = value;
		}
		
		public function get point2():Point {
			return _p2;
		}
		
		public function set point2(value:Point):void {		
			_p2 = value;
		}
	}

}