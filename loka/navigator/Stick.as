package utils.loka.navigator {
	import flash.display.*;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author loka
	 */
	public class Stick extends Sprite{
		private var obj:Object = new Object();
		public function Stick(_color:uint,w:Number=1) {
			var stick:Sprite = new Sprite();
			with(stick.graphics){
				beginFill(0xffffff, .5);
				lineStyle(0, _color, 1, true, LineScaleMode.NONE, CapsStyle.SQUARE, JointStyle.MITER, 10);
				moveTo(0, 0);
				lineTo(w,0);
				lineTo(w,1);
				lineTo(0, 1);
				lineTo(0, 0);
				endFill();
				
			}
			this.addChild(stick);
			this.addEventListener(MouseEvent.MOUSE_OVER, over);
		}
		public function addProperty(name:String, val:Object):void {
			this.obj[name] = val;
		}
		public function getProperty(name:String):Object {
			return this.obj[name];
		}
		private function over(e:Event):void {
			//this.x++;
			//trace("over");
		}
		
	}

}