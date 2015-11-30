package loka.dataBase.radio {
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import loka.dataBase.Data;
	
	/**
	 * ...
	 * @author loka
	 */
	public class RadioGroup extends Data{
		private var _arrRadio:Array = new Array();
		private var _arrRadioVO:Array = new Array();
		private var _rad:RadioBtn;
		private var _currentRadio:RadioBtn;
		public static const HORIZONTAL:String = "horizontal";
		public static const CHANGE:String = "change";
		public function RadioGroup(){
			this.init();
			this.addNewData("bkgCol", 0xcecece);
			this.addNewData("lineCol", 0xaeaeae);
			this.addNewData("groundW", 15);
			this.addNewData("pointW", 12);
			this.addNewData("radioPadX", 50);
			this.addNewData("radioPadY", 0);
			
		}
		public function addRadio(name:String):void {
			this._rad = new RadioBtn(this.data);
			this._rad.create();
			this.addChild(this._rad);
			this._arrRadio.push(this._rad);
			this._arrRadioVO.push(null);
			if(this._arrRadio.length > 1){
				this._rad.x = this._arrRadio[this._arrRadio.length - 2].x + parseFloat(this.getDataByName("radioPadX").data) + this._arrRadio[this._arrRadio.length - 2].width;
				this._rad.y = this._arrRadio[this._arrRadio.length - 2].y + parseFloat(this.getDataByName("radioPadY").data);
			}else {
				//this._rad.x = parseFloat(this.getDataByName("radioPadX").data);
				//this._rad.y = parseFloat(this.getDataByName("radioPadY").data);
			}
			this._rad.addEventListener(RadioBtn.REMAKE, remake);
			this._rad.name = name;
			for (var c:String in this._arrRadio) {
				(this._arrRadio[c] as RadioBtn).radio = false;
			}
			this._rad.radio = true;
			this._currentRadio = this._rad;
			//new BtnEffect(this._rad);
		}
		/**
		 * 
		 * @param	nameRBtn
		 * @param	VO 
		 * @param	typeAdd = horizontal || vertical
		 */
		public function addVOtoRadioByName(nameRBtn:String, VO:DisplayObject, typeAdd:String="horizontal"):void {
			if(VO!=null)
			this.addChild(VO);
			for (var c:String in this._arrRadio) {
				if (this._arrRadio[c].name == nameRBtn) {
					this._arrRadioVO[c] = VO;
					VO.name = nameRBtn;
					VO.addEventListener(MouseEvent.CLICK, VOclick);
					VO.addEventListener(RadioBtn.REMAKE, remake);
				}
			}
			//this.rePosition(typeAdd);
			if (typeAdd == "horizontal") {
				VO.x = this.getRadioByName(nameRBtn).x + this.getRadioByName(nameRBtn).width;
				VO.y = this.getRadioByName(nameRBtn).y - VO.height / 2;
			}else {
				VO.x = this.getRadioByName(nameRBtn).x ;
				VO.y = this.getRadioByName(nameRBtn).y + this.getRadioByName(nameRBtn).height;
			}
			
		}
		
		public function alignmentVO(type:String = RadioGroup.HORIZONTAL, padX:Number=0, padY:Number=0):void {
			for (var c:String in this._arrRadio) {
				if(this._arrRadioVO[c] != null)
				if (type == RadioGroup.HORIZONTAL) {
					this._arrRadioVO[c].x = this._arrRadio[c].x + this._arrRadio[c].width + padX ;
					this._arrRadioVO[c].y = this._arrRadio[c].y + padY;// + this._arrRadio[c].width + 5;
				}else {
					this._arrRadioVO[c].x = this._arrRadio[c].x + padX;// + this._arrRadio[c].width + 5;
					this._arrRadioVO[c].y = this._arrRadio[c].y + this._arrRadio[c].height + padY;
				}
				
			}
		}
        
		private function VOclick(e:Event):void {
			e.currentTarget.dispatchEvent(new Event(RadioBtn.REMAKE, true));
		}
        
		private function remake(e:Event):void {
			for (var c:String in this._arrRadio) {
				if((this._arrRadio[c] as RadioBtn).name != e.currentTarget.name){
					(this._arrRadio[c] as RadioBtn).radio = false;
				}else {
					(this._arrRadio[c] as RadioBtn).radio = true;
				}
			}//trace((e.currentTarget as DisplayObject).name);
			//trace((e.target as DisplayObject).name);
			this._currentRadio = this.getRadioByName((e.currentTarget as DisplayObject).name);
            this._currentRadio.dispatchEvent(new Event(RadioGroup.CHANGE, true));
		}
		public function get currentRadio():RadioBtn {
			//if (this._currentRadio = null) return null;
			//trace("asd"+this._currentRadio.name)
			return this._currentRadio;
		}
		public function getRadioByName(name:String):RadioBtn {
			for (var c:String in this._arrRadio) {
				if(this._arrRadio[c].name==name)
				return this._arrRadio[c];
			}
			trace("notChangeCurrentRadio");
			return this._currentRadio;
		}
        
        /*public function update(type:String = RadioGroup.HORIZONTAL):void
        {
            for (var c:String in this._arrRadio) {
                if(this._arrRadioVO[c] != null)
                    if (type == RadioGroup.HORIZONTAL) {
                        this._arrRadioVO[c].x = this._arrRadio[c].x + this._arrRadio[c].width + padX ;
                        this._arrRadioVO[c].y = this._arrRadio[c].y + padY;// + this._arrRadio[c].width + 5;
                    }else {
                        this._arrRadioVO[c].x = this._arrRadio[c].x + padX;// + this._arrRadio[c].width + 5;
                        this._arrRadioVO[c].y = this._arrRadio[c].y + this._arrRadio[c].height + padY;
                    }
                
            }
        }*/
        public function setRadio(name:String, val:Boolean):void 
        {
            for (var c:String in this._arrRadio) {
                if((this._arrRadio[c] as RadioBtn).name != name){
                    (this._arrRadio[c] as RadioBtn).radio = false;
                }else {
                    (this._arrRadio[c] as RadioBtn).radio = true;
                }
            }//trace((e.currentTarget as DisplayObject).name);
            //trace((e.target as DisplayObject).name);
            this._currentRadio = this.getRadioByName(name);
//            this._currentRadio.dispatchEvent(new Event(RadioGroup.CHANGE, true));
        }
        
		public function set radioPadX(val:Number):void {    this.addNewData("radioPadX",    val,    true); }
		public function set radioPadY(val:Number):void {    this.addNewData("radioPadY",    val,    true); }
		public function set groundW(val:Number):void {      this.addNewData("groundW",      val,    true); }
		public function set pointW(val:Number):void {       this.addNewData("pointW",       val,    true); }
		public function set bkgCol(val:Object):void {       this.addNewData("bkgCol",       val,    true); }
		public function set lineCol(val:Object):void {      this.addNewData("lineCol",      val,    true); }
	}

}