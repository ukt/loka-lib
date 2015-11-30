package utils.loka.navigator {
	import flash.display.*;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author loka
	 */
	public class Volume extends Sprite {
		public static const REVOLUME:String = "REVOLUME";
		private var arrStick:Array;// = new Array();
		private var color:uint = 0xcecece;
		private var backColor:uint = 0xcecece;
		private var backBar:Sprite;// = 0xcecece;
		private var bar:Sprite;
		private var stick:Stick;
		private var tmpStick:Stick;
		private var volume:Number=1;
		private var _coefficient:Number=1;
		
		public function Volume() {
			this.useHandCursor = true;
			this.buttonMode = true;
			/*this.mouseChildren = false;*/
			this.backBar = new Sprite();
			this.bar = new Sprite();
			this.addChild(this.backBar);
			this.addChild(this.bar);
		}
		public function create():void {
			this.createBar();
			//this.createBackBar();
		}
		private function createBar(count:Number = 15 ):void {
			this.arrStick = new Array();
			var tmp:Sprite;
			//var coefficient = 1;
			for (var i:Number = 1; i < count; i++ ) {
				this.stick = new Stick(this.color,3);
				this.stick.addProperty("i", i);
				this.stick.addEventListener(MouseEvent.MOUSE_OVER, stickOver);
				//this.stick.addEventListener(Event.ENTER_FRAME, enter);
				tmp = this.stick;
				this.arrStick.push(tmp);
				this.bar.addChild(tmp);
				tmp.width = 2;
				tmp.height *= this._coefficient * i - 1 ;
				tmp.x = this.bar.width + 1;
				tmp.y = (this._coefficient * count - 1) - (this._coefficient * i - 1);
				
			}
		}
		private function createBackBar(count:Number = 15 ):void {
			var tmp:Sprite;
			for (var i:Number = 1; i < count; i++ ) {
				this.stick = new Stick(this.backColor);
				this.stick.addProperty("i", i);
				tmp = this.stick;
				this.backBar.addChild(tmp);
				tmp.width = 2;
				tmp.height *= 2 * i - 1 ;
				tmp.x = this.backBar.width + 1;
				tmp.y = (2 * count - 1) - (2 * i - 1);
				tmp.alpha /= 2;
				
				
			}
		}
		private function enter(e:Event):void {
			//this.tmpStick = e.currentTarget;
			e.currentTarget.x++;
			trace("ok");
			
		}
		private function stickOver(e:Event):void {
			//this.tmpStick = e.currentTarget;
			//trace("ok");
			var num:Number = e.currentTarget.getProperty("i");
			//trace("num="+num);
			for (var i:Number = 0; i < this.arrStick.length; i++) {
				if(i<num){
					this.arrStick[i].alpha = 1;
				}else {
					this.arrStick[i].alpha = 0.1;
				}
			}
			this.volume = (1/this.arrStick.length /*/ 100*/) * num;
			this.dispatchEvent(new Event(Volume.REVOLUME, true));
		}
		public function get volumes():Number {
			return this.volume;
		}
		public function set volumes(val:Number):void{
			//return this.volume;
			for (var i:Number = 0; i < this.arrStick.length; i++) {
				if(i<(this.arrStick.length ) * val){
					this.arrStick[i].alpha = 1;
				}else {
					this.arrStick[i].alpha = 0.1;
				}
			}
		}
		public function set coefficient(val:int):void {
			this._coefficient = val;
		}
		
		/*private function createStick(Color):Sprite {
			var stick:Sprite = new Sprite();
			with(stick.graphics){
				beginFill(0xffffff, 0.05);
				lineStyle(1, Color, 1, false, LineScaleMode.NONE, CapsStyle.SQUARE, JointStyle.MITER, 10);
				moveTo(0, 0);
				lineTo(1,0);
				lineTo(1,1);
				lineTo(0, 1);
				lineTo(0, 0);
				endFill();
				
			}
			return stick;
		}*/
		
	}

}