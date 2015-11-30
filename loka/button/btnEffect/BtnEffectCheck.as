package utils.loka.button.btnEffect {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.*;
	
	import utils.loka.filters.*;
	/**
	 * ...
	 * @author loka
	 */
	public class BtnEffectCheck extends BtnEffect{
//		private var _el:DisplayObject;
        private var _check:Boolean = false;
        private var _darkedFilter:Array = SampleFilters.DarkedFilter(1.6);
//		public var OldFilter:Array;
		public function BtnEffectCheck(el:DisplayObject, check:Boolean = false, mouseChildren:Boolean = false) {
            super(el, mouseChildren);
            _check = check;
            if(_check)
            {
                this.OldFilter = this.OldFilter.concat(_darkedFilter);
                this._el.filters = this.OldFilter;
            }
			/*if(el){
				this._el = el;
				this._el.addEventListener(MouseEvent.MOUSE_OVER, MOver);
				this._el.addEventListener(MouseEvent.MOUSE_OUT, MOut);
				this._el.addEventListener(MouseEvent.MOUSE_DOWN, MDown);
				this._el.addEventListener(MouseEvent.MOUSE_UP, MUp);
                if(_el is Sprite)
                {
                    (_el as Sprite).useHandCursor = true;
                    (_el as Sprite).buttonMode = true;
                    (_el as Sprite).mouseChildren = mouseChildren;
                }
				this.OldFilter = this._el.filters;
			}*/
		}
        
        override public function set enableInner(value:Boolean):void 
        {
            (_el as Sprite).useHandCursor = value;
            (_el as Sprite).buttonMode = value;
//            (_el as Sprite).mouseChildren = mouseChildren;
            (_el as Sprite).mouseEnabled = value;
            if(value)
            {
                this._el.addEventListener(MouseEvent.MOUSE_OVER, MOver);
                this._el.addEventListener(MouseEvent.MOUSE_OUT, MOut);
                this._el.addEventListener(MouseEvent.MOUSE_DOWN, MDown);
                this._el.addEventListener(MouseEvent.MOUSE_UP, MUp);
            }
            else
            {
                this._el.removeEventListener(MouseEvent.MOUSE_OVER, MOver);
                this._el.removeEventListener(MouseEvent.MOUSE_OUT, MOut);
                this._el.removeEventListener(MouseEvent.MOUSE_DOWN, MDown);
                this._el.removeEventListener(MouseEvent.MOUSE_UP, MUp);
            }
        }
        
        /*override public function destroy():void {
            this._el.removeEventListener(MouseEvent.MOUSE_OVER, MOver);
            this._el.removeEventListener(MouseEvent.MOUSE_OUT, MOut);
            this._el.removeEventListener(MouseEvent.MOUSE_DOWN, MDown);
            this._el.removeEventListener(MouseEvent.MOUSE_UP, MUp);
            this.OldFilter = null;
            this._el = null;
        }
        override public function update():void {
//            MOut(null);
            this.OldFilter = this._el.filters;
        }
        
		private function MOver(e:Event):void {
			this._el.filters = SampleFilters.DarkedFilter(1.2).concat(this.OldFilter);
		}
		private function MOut(e:Event):void {
			this._el.filters = this.OldFilter;
		}
		private function MDown(e:Event):void {
			this._el.filters = SampleFilters.DarkedFilter(1.6).concat(this.OldFilter);
		}*/
        override protected function MUp(e:Event):void {
            _check = !_check;
            if(_check)
            {
                this.OldFilter = this.OldFilter.concat(_darkedFilter);
            }
            else 
            {
                var index:int = this.OldFilter.indexOf(_darkedFilter[0]);
                if(index != -1)
                {
                    this.OldFilter.splice(index, 1);
                }
            }
			this._el.filters = this.OldFilter;
		}
        
        public function get check():Boolean
        {
            return _check;
        }
        
        public function set check(value:Boolean):void
        {
            _check = value;
        }
	}

}