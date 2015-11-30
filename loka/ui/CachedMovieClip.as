package utils.loka.ui
{
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import utils.loka.bitmap.AssetBitmap;
	import utils.loka.bitmap.CashedData;
	import utils.loka.ui.uiI.IEntityComplex;
	import utils.loka.ui.uiI.IModernSprite;
	import utils.loka.ui.vo.TickVO;
	
	
	/**
	 * ...
	 *
	 * @history create Sep 3, 2012 11:05:15 PM
	 * @author g.savenko
	 */    
	public class CachedMovieClip extends MovieClip implements IEntityComplex
	{
		//------------------------------------------------
		//      Class constants
		//------------------------------------------------
		
		//------------------------------------------------
		//      Variables
		//------------------------------------------------
		private var _ani:MovieClip;
		private var _bitmap:Bitmap;
		private var _hitAria:Sprite;
		private var _key:String;
		//---------------------------------------------------------------
		//
		//      CONSTRUCTOR
		//
		//---------------------------------------------------------------
		public function CachedMovieClip(ani:MovieClip, key:String = null)
		{
			super();
			_ani = ani;
			_ani.stop();
			_key = key?key:_ani.name;
			CashedData.cashed(_ani, _key);
			
			if(parent)
			{
				init(null)
			}
			else
			{
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}
		
		//---------------------------------------------------------------
		//
		//      PRIVATE & PROTECTED METHODS
		//
		//---------------------------------------------------------------
		
		private function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			_ani.gotoAndStop(1);
			_bitmap = new Bitmap();
			update();
			
//			_bitmap.smoothing = true;
//			cacheAsBitmap = true;
//			cacheAsBitmapMatrix = new Matrix();
			var padding:Number = 30;
			var rectAria:Rectangle = _ani.getRect(this);
			_hitAria = new Sprite(); 
			_hitAria.graphics.beginFill(0x000000, 0);
//			_hitAria.graphics.drawRect(- _ani.width / 2, - _ani.height, _ani.width, _ani.height); 
			_hitAria.graphics.drawRect(-padding + rectAria.x, -padding+ rectAria.y, padding * 2 + rectAria.width, padding * 2 + rectAria.height); 
			_hitAria.graphics.endFill();
			
			_hitAria.visible = true;
			
			_hitAria.cacheAsBitmap = true;
//			_hitAria.cacheAsBitmapMatrix = new Matrix();
			
			hitArea = _hitAria;
			
			_hitAria.mouseEnabled = false;
			
			addChild(_bitmap);
			addChild(_hitAria);
			_ani.play();
			
			_isTick = true;
		}
		
		private function update():void
		{
			var bm:AssetBitmap = CashedData.aliveBitmap(_key, _ani.currentFrame);
			_bitmap.bitmapData = bm.bitmapData;
			_bitmap.x = bm.x;
			_bitmap.y = bm.y;
			//			_bitmap.bitmapData.lock();
		}
		
		
		//---------------------------------------------------------------
		//
		//      EVENT HANDLERS
		//
		//---------------------------------------------------------------
		
		
		//---------------------------------------------------------------
		//
		//      PUBLIC METHODS
		//
		//---------------------------------------------------------------
		override public function get parent():DisplayObjectContainer
		{
			return super.parent;
		}
		
		override public function get currentLabel():String
		{
			return _ani.currentLabel;
		}
		
		override public function nextFrame():void
		{
			_ani.nextFrame();
		}
		
		override public function get currentFrame():int
		{
			return _ani.currentFrame;
		}
		
		override public function get totalFrames():int
		{
			return _ani.totalFrames;
		}
		
		override public function gotoAndStop(frame:Object, scene:String=null):void
		{
			_ani.gotoAndStop(frame, scene);
		}
		
		override public function stop():void
		{
			_ani.stop();
		}
		
		override public function get currentLabels():Array
		{
			return _ani.currentLabels;
		}

		private var _god:IModernSprite;
		public function initEntity(god:IModernSprite):void
		{
			_god = god;
		}
		
		public function tick(data:TickVO):void
		{
			update();
		}
		
		/**
		 * 
		 * 
		 */
		public function dispose():void
		{
			if(!_isDispose)
			{
				_isDispose = true;
				
				if(_bitmap)
				{
					_bitmap.bitmapData = null;
					removeChild(_bitmap);
				}
				
				if(_hitAria)
				{
					removeChild(_hitAria)
				}
				
				_god.removeSliceInstance(this);
				
				_god 		= null;
				_ani 		= null;
				_hitAria	= null;
				
			}
		}
		//---------------------------------------------------------------
		//
		//      ACCESSORS
		//
		//---------------------------------------------------------------
		
		private var _isTick:Boolean = false;
		public function get isTick():Boolean
		{
			return _isTick;
		}
		
		protected var _isAlive:Boolean = true;
		public function get isAlive():Boolean
		{
			return _isAlive; 
		}
		public function set isAlive(value:Boolean):void
		{
			_isAlive = value; 
		}
		
		public function getChildsByNameDifinition(name:String):Vector.<IEntityComplex>
		{
			var result:Vector.<IEntityComplex> = new Vector.<IEntityComplex>();
			return result;
		}
		
		private var _nameDifinition:String = "";
		public function get nameDifinition():String
		{
			return _nameDifinition;
		}
		
		public function set nameDifinition(value:String):void
		{
			_nameDifinition = value;
		}
		
		protected var _isDispose:Boolean = false;
		public function get isDispose():Boolean
		{
			return _isDispose; 
		}
		
	}
}