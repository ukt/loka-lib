package utils.loka.bitmap 
{
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author LoKa
	 */
	public class RectVO
	{
		
		public function RectVO(x:Number = 0, y:Number = 0, width:Number = 0, height:Number = 0, bottom:Number = 0, right:Number = 0)
		{
			this.x = x;
			this.y = y;
			this.width = width;
			this.height = height;
			this.bottom = bottom;
			this.right = right;
		}

		public var x : Number;
		public var y : Number;
		public var height : Number;
		public var width : Number;
		private var _bottom:Number = 0
		public function get bottom():Number { return this._bottom; }
		
		public function set bottom(value:Number):void {
			
			this._bottom = value;
		}
		
		private var _right:Number = 0
		public function get right():Number { return this._right; }
		
		public function set right(value:Number):void  {
			this._right = value;
		}
		
		public function get rect():Rectangle
		{
			return new Rectangle(x, y, width, height);
		}
		
	}

}