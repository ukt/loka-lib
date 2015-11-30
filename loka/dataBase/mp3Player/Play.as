package utils.loka.dataBase.mp3Player {
	import flash.display.*;
	import flash.events.*;
	
	import utils.loka.dataBase.Data;
	//import gs.TweenMax;
	//import gs.events.TweenEvent;
	//import fl.motion.easing.Sine;
	/**
	 * ...
	 * @author Gleb.Savenko@Gmail.com
	 */
	public class Play extends Data {
		public static const PLAY:String = "STATUS_PLAY";
		public static const PAUSE:String = "STATUS_PAUSE";
		private var arrowPlay: Sprite;// btnPlay
		private var arrowPause: Sprite;// btnPlay
		private var fon: Sprite;// btnPlay
		private var Status:Boolean;
		//private var tweenDot:TweenMax;
		private var obj:Object = new Object();
		public function Play(statusPlay:Boolean = false) {
			this.Status = statusPlay;
			this.arrowPlay = new Sprite();
			this.arrowPause = new Sprite();
			this.fon = new Sprite();
			this.addChild(this.arrowPlay);
			this.addChild(this.arrowPause);
			this.addChild(this.fon);
			
		}
		public function create():void {
			if (issetData("play") && issetData("pause")) {
				this.arrowPlay.addChild(this.getDataByName("play").data);
				this.arrowPause.addChild(this.getDataByName("pause").data);
			}else {
				this.createBtn();
			}
			
		}
		public function set btnPlay(value:DisplayObject):void { this.addNewData("play", value); }
		public function set btnPause(value:DisplayObject):void { this.addNewData("pause", value); }
		private function createBtn():void {
			this.fon.graphics.beginFill(0xffffff, 0.0);
			this.fon.graphics.lineStyle(1, 0xcecece, 0.0, false, LineScaleMode.NONE, CapsStyle.SQUARE, JointStyle.MITER, 10);
			this.fon.graphics.moveTo(0, 0);
			this.fon.graphics.lineTo(3,0);
			this.fon.graphics.lineTo(3,4);
			this.fon.graphics.lineTo(0, 4);
			this.fon.graphics.lineTo(0, 0);
			this.fon.graphics.endFill();
			this.fon.useHandCursor = true;
			this.fon.buttonMode = true;
			this.fon.mouseChildren = false;
			
			this.arrowPlay.graphics.beginFill(0xffffff, 0.1);
			this.arrowPlay.graphics.lineStyle(1, 0xcecece, 1, false, LineScaleMode.NONE, CapsStyle.SQUARE, JointStyle.MITER, 10);
			this.arrowPlay.graphics.moveTo(0, 0);
			this.arrowPlay.graphics.lineTo(3, 2);
			this.arrowPlay.graphics.lineTo(0, 4);
			this.arrowPlay.graphics.lineTo(0, 0);
			
			this.arrowPlay.graphics.endFill();
			/*this.arrowPlay.width = 15;
			this.arrowPlay.height = 15;*/
			this.arrowPlay.useHandCursor = true;
			this.arrowPlay.buttonMode = true;
			this.arrowPlay.mouseChildren = false;
			this.arrowPlay.name= "play";
			
			this.arrowPause.graphics.beginFill(0xffffff, 0.1);
			this.arrowPause.graphics.lineStyle(1, 0xcecece, 1,true);
			this.arrowPause.graphics.lineStyle(1, 0xcecece, 1, false, LineScaleMode.NONE, CapsStyle.SQUARE, JointStyle.MITER, 10);
			this.arrowPause.graphics.moveTo(0, 0);
			this.arrowPause.graphics.lineTo(1,0);
			this.arrowPause.graphics.lineTo(1,4);
			this.arrowPause.graphics.lineTo(0,4);
			this.arrowPause.graphics.lineTo(0, 0);
			this.arrowPause.graphics.endFill();
			this.arrowPause.graphics.beginFill(0xffffff, 0.1);
			//this.arrowPause.graphics.lineStyle(1, 0xcecece, 1);
			this.arrowPause.graphics.moveTo(2, 0);
			this.arrowPause.graphics.lineTo(3,0);
			this.arrowPause.graphics.lineTo(3,4);
			this.arrowPause.graphics.lineTo(2,4);
			this.arrowPause.graphics.lineTo(2, 0);
			this.arrowPause.graphics.endFill();
			/*this.arrowPause.width = 15;
			this.arrowPause.height = 15;*/
			
			this.arrowPause.useHandCursor = true;
			this.arrowPause.buttonMode = true;
			this.arrowPause.mouseChildren = false;
			this.arrowPause.name= "Pause";
			
			this.width = 15;
			this.height = 15;
			
			if (!this.Status) {
				//this.Status = true;
				this.arrowPause.visible = true;
				this.arrowPlay.visible = false;
			}else {
				//this.Status = false;
				this.arrowPause.visible = false;
				this.arrowPlay.visible = true;
			}
			this.addEventListener(MouseEvent.MOUSE_OVER, navMouseOver);
			this.addEventListener(MouseEvent.MOUSE_OUT, navMouseOut);
			this.addEventListener(MouseEvent.CLICK, navMouseClick);
			this.obj.x = this.x;
			this.obj.y = this.y;
			this.obj.w = this.width;
			this.obj.h = this.height;
			this.obj.scaleY = this.height/20;
			this.obj.scaleX = this.width/20;
			this.obj.scaleY = 0;
			this.obj.scaleX = 0;
			
		}
		private function navMouseOver(e:Event):void {
			//tweenDot = TweenMax.to(this, .2, { x:(this.obj.x - this.obj.scaleX), ease:Sine.easeOut } );
			//tweenDot.addEventListener(TweenEvent.COMPLETE, OverFinished);
			//TweenMax.to(this,.2,{y:(this.obj.y-this.obj.scaleY),ease:Sine.easeOut});
			//TweenMax.to(this,.2,{width:(this.obj.w+2*this.obj.scaleX),ease:Sine.easeOut});
			//TweenMax.to(this,.2,{height:(this.obj.h+2*this.obj.scaleY),ease:Sine.easeOut});
		}
		private function navMouseOut(e:Event):void {
			//TweenMax.to(this,.2,{x:(this.obj.x),ease:Sine.easeOut});
			//TweenMax.to(this,.2,{y:(this.obj.y),ease:Sine.easeOut});
			//TweenMax.to(this,.2,{width:(this.obj.w),ease:Sine.easeOut});
			//TweenMax.to(this,.2,{height:(this.obj.h),ease:Sine.easeOut});
		}
		private function OverFinished(e:Event):void {
			
		}
		private function navMouseClick(e:Event):void {
			this.x = this.obj.x;
			this.x = this.obj.y;
			this.width = this.obj.w;
			this.height = this.obj.h;
			if (this.Status) {
				this.Status = false;
				this.arrowPause.visible = true;
				this.arrowPlay.visible = false;
				
				this.dispatchEvent(new Event(Play.PAUSE, true));
			}else {
				this.Status = true;
				this.arrowPause.visible = false;
				this.arrowPlay.visible = true;
				
				this.dispatchEvent(new Event(Play.PLAY, true));
			}
			
		}
		public function get status():Boolean {
			return this.Status;
		}
		public function set status(val:Boolean):void {
			this.x = this.obj.x;
			this.x = this.obj.y;
			this.width = this.obj.w;
			this.height = this.obj.h;
			this.Status = val;
			if (!this.Status) {
				//this.Status = false;
				this.arrowPause.visible = true;
				this.arrowPlay.visible = false;
				this.dispatchEvent(new Event(Play.PAUSE, true));
				
			}else {
				//this.Status = true;
				this.arrowPause.visible = false;
				this.arrowPlay.visible = true;
				this.dispatchEvent(new Event(Play.PLAY, true));
				
			}
		}
		
	}

}