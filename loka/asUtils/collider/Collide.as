package loka.asUtils.collider {
	import flash.geom.Point;
	import loka.asUtils.collider.primitive.Circle;
	import loka.asUtils.collider.primitive.Segment;
	
	
	
	/**
	 * ...
	 *
	 * @history create Apr 9, 2012 6:17:50 PM
	 * @author g.savenko
	 */    
	public class Collide {
		
		public static function circleOnCircleIntersection(body1:Circle, body2:Circle):Boolean {
			var distance:Number = body1.point.subtract(body2.point).length;
			var distanceToCollide:Number = body1.radius + body2.radius;
			return distance < distanceToCollide;
		}
		
		public static function segmentOnCircleIntersection(body1:Segment, body2:Circle):Point {
			var b1:Segment = body1;
			var b2:Circle = body2;
			var result:Point = null;
			if (Math.pow(b1.point1.x - b2.point.x, 2) + Math.pow(b1.point1.y - b2.point.y, 2) <= Math.pow(b2.radius, 2)) {
				return new Point(b1.point1.x, b1.point1.y);
			}
			
			if (Math.pow(b1.point2.x - b2.point.x, 2) + Math.pow(b1.point2.y - b2.point.y, 2) <= Math.pow(b2.radius, 2)) {
				return new Point(b1.point2.x, b1.point2.y);
			}
			
			var dx:Number = b1.point2.x-b1.point1.x;
			var dy:Number = b1.point2.y-b1.point1.y;
			
			var dposX:Number = b1.point1.x-b2.point.x;
			var dposY:Number = b1.point1.y-b2.point.y;
			
			var dot:Number = dposX*dx+dposY*dy;
			
			var alen2:Number = dx*dx+dy*dy;
			var dposLen2:Number = dposX*dposX+dposY*dposY;
			
			var d:Number = dot*dot-alen2*(dposLen2-b2.radius*b2.radius);
			
			if(d >= 0 && alen2 > 0) {
				d = Math.sqrt(d);
				
				var t1:Number = (-dot-d)/alen2;

				if(t1 >= 0 && t1 <= 1) {
					result = b1.point1.clone();
					result.offset(dx*t1, dy*t1);
					return result;
				}
				
				if(d > 0) {
					var t2:Number = (-dot+d)/alen2;
					
					if(t2 >= 0 && t2 <= 1) {
						result = b1.point1.clone();
						result.offset(dx*t2, dy*t2);
						return result;
					}
				}
			}

			return null;
		}
		
		public static function segmentsIntersection(b1:Segment, b2:Segment):Point {
			var ta1:Number = b1.point1.x-b1.point2.x;
			var tb1:Number = b2.point2.x-b2.point1.x;
			
			var ta2:Number = b1.point1.y-b1.point2.y;
			var tb2:Number = b2.point2.y-b2.point1.y;
			
			var d:Number = ta1*tb2-ta2*tb1;
			
			if(d) {
				var tc1:Number = b1.point1.x-b2.point1.x;
				var tc2:Number = b1.point1.y-b2.point1.y;
				
				var dx:Number = tc1*tb2-tc2*tb1;
				var dy:Number = ta1*tc2-ta2*tc1;
				
				var t1:Number = dx/d;
				var t2:Number = dy/d;
				
				if(t1 >= 0 && t1 <= 1 && t2 >= 0 && t2 <= 1) {
					return new Point(b1.point1.x-ta1*t1, b1.point1.y-ta2*t1) 
				}
			}
			return null;
		}
	}
}