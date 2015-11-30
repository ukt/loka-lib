package loka.button {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author loka
	 */
	public class BtnScale extends Sprite{
		public var config:Config = new Config();
		private var _vo:DisplayObject;
		private var Conteiner:Sprite = new Sprite();
		
		public var padding:Number = 0;
		public function BtnScale() {
			super();
			this.addChild(Conteiner);
			
		}
		public function create(VO:DisplayObject):void {
			this._vo = VO;
			this.config.create(VO);
			
			this.addChild(config.TL);
			this.addChild(config.T);
			this.addChild(config.TR);
			this.addChild(config.L);
			this.addChild(config.BODY);
			this.addChild(config.R);
			this.addChild(config.BL);
			this.addChild(config.B);
			this.addChild(config.BR);
			
			this.render();
			
		}
		private function render():void {
			config.T.x = config.TL.x+config.TL.width+padding;// config.PADDING_LEFT + padding;
			config.TR.x = config.T.x + config.T.width + padding;// this._vo.width - config.PADDING_RIGHT + 2;
			
			config.BODY.x = config.L.x+config.L.width+padding;
			config.R.x = config.BODY.x + config.BODY.width + padding;// this._vo.width - config.PADDING_RIGHT + 2;// 
			
			config.L.y =  config.TL.y + config.TL.height + padding;// config.PADDING_TOP + padding;
			config.BODY.y = config.T.y + config.T.height + padding;//config.PADDING_TOP+padding;
			config.R.y = config.TR.y + config.TR.height + padding;//config.PADDING_TOP+padding;
			
			config.B.x = config.PADDING_LEFT+padding;
			config.BR.x = config.B.x + config.B.width + padding;// this._vo.width - config.PADDING_RIGHT + 2;// config.B.x + config.B.width + padding;
			
			config.BL.y =   config.L.y + config.L.height + padding;// this._vo.height - config.PADDING_BOTTOM + 2;
			config.B.y =  config.BODY.y + config.BODY.height + padding;// this._vo.height - config.PADDING_BOTTOM + 2;
			config.BR.y =  config.R.y + config.R.height + padding;// this._vo.height - config.PADDING_BOTTOM + 2;
		}
		override public function get width():Number { return super.width; }
		
		override public function set width(value:Number):void 
		{
			config.T.width = value-(config.PADDING_RIGHT + config.PADDING_LEFT);
			config.BODY.width = value-(config.PADDING_RIGHT + config.PADDING_LEFT);
			config.B.width = value-(config.PADDING_RIGHT + config.PADDING_LEFT);
			this.render();
			//super.width = value;
		}
		override public function get height():Number { return super.height; }
		
		override public function set height(value:Number):void 
		{
			config.L.height = value - (config.PADDING_TOP + config.PADDING_BOTTOM);
			config.BODY.height= value - (config.PADDING_TOP + config.PADDING_BOTTOM);
			config.R.height = value - (config.PADDING_TOP + config.PADDING_BOTTOM);
			this.render();
			//super.height = value;
		}
		
	}
	

}