package utils.loka.autotesting {
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	import utils.loka.console.Console;
	
	public class LightPoint extends Sprite {
		private var instance:DisplayObject;
		public function LightPoint(instance:DisplayObject, position:Point) {
			super();
			this.instance = instance;
			this.x = position.x;
			this.y = position.y;
			addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		protected function onInit(event:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			
			var point:Point = instance.localToGlobal(new Point(0,0));
			
			var clickPoint:Shape = new Shape();
			
			var gr:Graphics = clickPoint.graphics;
			gr.beginFill(Console.RED);
			gr.drawCircle(0, 0, 3);
			gr.endFill();
			
			addChild(clickPoint);
			stage.addChild(this);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			
			this.mouseChildren 	= false;
			this.mouseEnabled 	= false;
			
		}
		
		protected function onEnterFrame(event:Event):void
		{
			alpha += (0-alpha)/10;
			if(alpha<.01){
				
				removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				if(parent){
					parent.removeChild(this);
				}
			}
		}
	}
}