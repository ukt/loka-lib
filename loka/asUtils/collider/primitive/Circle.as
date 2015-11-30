package loka.asUtils.collider.primitive {
	import flash.geom.Point;

	/**
	 * ...
	 * @author Loka
	 */
	public class Circle {
		protected var _r:Number;
		protected var _p:Point;
	
		public function Circle(p:Point, r:uint = 0) {
			this._p = p?p.clone():new Point();
			this._r = r?r:0;
		}
		public function get radius():Number {
			return _r;
		}
		
		public function get point():Point {
		
			return _p;
		}
		
		public function set radius(value:Number):void {
			if(value>=0){
				_r = value;
			}
		}
		
	}

}