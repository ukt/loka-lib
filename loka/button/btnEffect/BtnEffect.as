package loka.button.btnEffect {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.filters.ConvolutionFilter;
	
	/**
	 * ...
	 * @author loka
	 */
	public class BtnEffect 
	{
		
		protected var _el:DisplayObject;
		public var OldFilter:Array;
		private static var DISPOSE:String 	= "DISPOSE";
		private static var ENABLE:String 	= "ENABLE";
		private static var DISABLE:String 	= "DISABLE";
		
		public function BtnEffect(el:DisplayObject, mouseChildren:Boolean=false) 
		{
			
			if(el){
				this._el = el;
				this._el.addEventListener(MouseEvent.MOUSE_OVER, MOver);
				this._el.addEventListener(MouseEvent.MOUSE_OUT, MOut);
				this._el.addEventListener(MouseEvent.MOUSE_DOWN, MDown);
				this._el.addEventListener(MouseEvent.MOUSE_UP, MUp);
				this._el.addEventListener(DISPOSE, destroy);
				this._el.addEventListener(ENABLE, onEnable);
				this._el.addEventListener(DISABLE, onDisable);
				if(_el is Sprite)
				{
					Sprite(_el).useHandCursor = true;
					Sprite(_el).buttonMode = true;
					Sprite(_el).tabEnabled = false;
					Sprite(_el).mouseChildren = mouseChildren;
				}
				
				this.OldFilter = this._el.filters;
			}
		}
		
		protected function onEnable(event:Event):void
		{
			enableInner = true;
		}
		
		protected function onDisable(event:Event):void
		{
			enableInner = false;
		}
		
		public function set enableInner(value:Boolean):void 
		{
			(_el as Sprite).useHandCursor = value;
			(_el as Sprite).buttonMode = value;
//			(_el as Sprite).mouseChildren = mouseChildren;
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
				MDown(null); 
				this._el.removeEventListener(MouseEvent.MOUSE_OVER, MOver);
				this._el.removeEventListener(MouseEvent.MOUSE_OUT, MOut);
				this._el.removeEventListener(MouseEvent.MOUSE_DOWN, MDown);
				this._el.removeEventListener(MouseEvent.MOUSE_UP, MUp);
			}
		}
		
		public static function enableEl(el:DisplayObject):void
		{
			el.dispatchEvent(new Event(ENABLE));
		}
		
		public static function disableEl(el:DisplayObject):void
		{
			el.dispatchEvent(new Event(DISABLE));
		}
		
		public static function disposeEl(el:DisplayObject):void 
		{
			el.dispatchEvent(new Event(DISPOSE));
		}
		
		public function destroy(e:Event = null):void {
			this._el.removeEventListener(MouseEvent.MOUSE_OVER, MOver);
			this._el.removeEventListener(MouseEvent.MOUSE_OUT, MOut);
			this._el.removeEventListener(MouseEvent.MOUSE_DOWN, MDown);
			this._el.removeEventListener(MouseEvent.MOUSE_UP, MUp);
			this._el.removeEventListener(DISPOSE, destroy);
			this._el.removeEventListener(ENABLE, onDisable);
			this._el.removeEventListener(DISABLE, onEnable);
			this.OldFilter = null;
			this._el = null;
		}
		
		public function update():void {
//			MOut(null);
			this.OldFilter = this._el.filters;
		}
		
		protected function MOver(e:Event):void {
			this._el.filters = DarkedFilter(1.2).concat(this.OldFilter);
		}
		
		protected function MOut(e:Event):void {
			this._el.filters = DarkedFilter(0).concat(this.OldFilter);
		}
		
		protected function MDown(e:Event):void {
			this._el.filters = DarkedFilter(1.6).concat(this.OldFilter);
		}
		
		protected function MUp(e:Event):void {
			this._el.filters = DarkedFilter(1.2).concat(this.OldFilter);
		}
		
		protected static function DarkedFilter(n:Number):Array {
			return [new ConvolutionFilter(1, 1, 
				[1, 1, 1
					, 1, 1, 1
					, 1, 1, 1
				], n)];
		}
		
	}

}