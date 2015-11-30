package utils.loka.dataBase.scroll  {
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	import utils.loka.button.btnEffect.BtnEffect;
	import utils.loka.dataBase.Data;
	
	/**
	 * ...
	 * @author loka
	 */
	public class ScrollBase extends Data{
		protected var _bckgColor:uint;
		protected var _lineColor:uint;
		protected var _mc:Sprite;
		protected var _w:Number;
		protected var _h:Number;
		protected var _x:Number;
		protected var _y:Number;
		protected var _btnEffect:BtnEffect;
		protected var _rect:Rectangle = new Rectangle();
		public function ScrollBase(){
			
		}
		
	}

}