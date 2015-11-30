package loka.ui
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.*;
	
	import loka.asUtils.updater.IUpdater;
	import loka.asUtils.updater.Updater;
	import loka.bitmap.BitmapEdit;
	import loka.ui.uiI.IEntityComplex;
	import loka.ui.uiI.IModernSprite;
	import loka.ui.vo.TickVO;
	
	public class ModernSprite extends Sprite implements IModernSprite 
	{
		private static var sliceInstance:Vector.<IEntityComplex> = new Vector.<IEntityComplex>();
		public static var instance:ModernSprite
		// TO DO hack
		public static var SPEED_FPS:Number = 60;
		public static var SPEED_UPDATE:Number = 1000 / SPEED_FPS;
		private static var key:Boolean = false;
		private var _nameDifinitionItter:int = 0;
		private var _nameDifinition:String = "";
		
		private static var _updater:IUpdater;
		public function ModernSprite()
		{
			super();
			_nameDifinitionItter++
			_nameDifinition = _nameDifinitionItter + "";
			if(!instance){
				key = true;
				instance = this;
				_updater = new Updater(instance);
				if(!stage)
				{
					addEventListener(Event.ADDED_TO_STAGE, initSuperInstance);
				}
				else
				{
					initSuperInstance(null)
				}
			}
			
			if(!stage)
			{
				addEventListener(Event.ADDED_TO_STAGE, initSuper);
			}
			else
			{
				init(null);
			}
		}
		
		
		public function get updater():IUpdater
		{
			return _updater;
		}

		public function getChildsByNameDifinition(name:String):Vector.<IEntityComplex>
		{
			var result:Vector.<IEntityComplex> = new Vector.<IEntityComplex>();
			for each (var c:IEntityComplex in sliceInstance)
			{
				if(c.nameDifinition == name)
				{
					result.push(c);
				}
			}
			return result;
		}
		
		public function get nameDifinition():String
		{
			return _nameDifinition;
		}

		public function set nameDifinition(value:String):void
		{
			_nameDifinition = value;
		}

		private var _data:* = {}; 
		public function get data():*
		{
			return _data;
		}
		
		private function initSuperInstance(e:Event):void
		{
			instance.removeEventListener(Event.ADDED_TO_STAGE, initSuperInstance);
		}
		
		
		protected var _init:Boolean = false;
		
		private function initSuper(e:Event = null):void
		{
			_init = true;
			removeEventListener(Event.ADDED_TO_STAGE, initSuper);
			init();
		}
		
		protected function init(e:Event = null):void
		{
			_isTick = true;
			addSliceInstance(this);
		}
		
		private var _isTick:Boolean = false;
		public function set isTick(value:Boolean):void
		{
			_isTick = value;
		}
		
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
		
		private var _god:IModernSprite;
		public function initEntity(god:IModernSprite):void
		{
			_god = god;
		}
		
		
		protected var _isDispose:Boolean = false;
		public function get isDispose():Boolean
		{
			return _isDispose; 
		}
		
		public function dispose():void
		{
			for (var c:uint = 0; c < numChildren; c++)
			{
				if(getChildAt(c) is ModernSprite)
				{
					if(!ModernSprite(getChildAt(c)).isDispose)
					{
						ModernSprite(getChildAt(c)).dispose();
					}
				}
			}
			
			for (c = 0; c < numChildren; c++)
			{
				removeChildAt(0);
			}
			
			removeSliceInstance(this);
			
			_isTick = false;
			_isDispose = true;
			_data = null;
			
			if(parent)
			{
				parent.removeChild(this);
			}
		}
		
		public function tick(data:TickVO):void 
		{
		}
		
		public function removeSliceInstance(child:IEntityComplex):void
		{
			if(child is IEntityComplex){
				if(sliceInstance.indexOf(child) != -1)
				{
					sliceInstance.splice(sliceInstance.indexOf(child), 1);
				}
			}
			_updater.removeUpdater(child);
		}
		
		public function addSliceInstance(child:IEntityComplex):void
		{
			var issetChild:int = sliceInstance.indexOf(child);
			if(issetChild == -1)
			{
				if(child is IEntityComplex)
				{
					IEntityComplex(child).initEntity(this);
					sliceInstance.push(child as IEntityComplex);
				}
			}
			_updater.addUpdater(child);
			
		}
		
		/**
		 * Test Alpha from local point
		 * returm true if point is alpha  
		 * @param x
		 * @param y
		 * @return 
		 * 
		 */
		public function hitAlphaPoint(x:Number, y:Number):Boolean
		{
			var result:Boolean = false;
			if(BitmapEdit.drawImgNew(this, false, 0.1, 0.1).bitmapData.getPixel32(x, y) == 0)
			{
				result = true;
			}
			return result;
		}
		
		public function swapDown():void
		{
			if(this.parent)
			{
				if(this.parent.getChildIndex(this) - 1 >= 0)
				{
					var child:DisplayObject = this.parent.getChildAt(this.parent.getChildIndex(this) - 1);
					if(child)
					{
						this.parent.swapChildren(this, child);
					}
				}
			}
		}
		
		public function swapTop():void
		{
			if(this.parent)
			{
				if(this.parent.numChildren > this.parent.getChildIndex(this) + 1)
				{
					var child:DisplayObject = this.parent.getChildAt(this.parent.getChildIndex(this) + 1);
					if(child)
					{
						this.parent.swapChildren(this, child);
					}
				}
			}
		}
		
		override public function addChildAt(child:DisplayObject, index:int):DisplayObject
		{
			addSliceInstance(child as IEntityComplex);
			return super.addChildAt(child, index);
		}
	
		override public function addChild(child:DisplayObject):DisplayObject{
			addSliceInstance(child as IEntityComplex);
			return super.addChild(child);
		}
		
		override public function removeChildAt(index:int):DisplayObject
		{
			var child:DisplayObject = super.removeChildAt(index); 
			removeSliceInstance(child as IEntityComplex);
			return child;
		}
		
		override public function removeChild(child:DisplayObject):DisplayObject
		{
			removeSliceInstance(child as IEntityComplex);
			return super.removeChild(child);
		}
//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=GETTER || SETTER-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
		public function get index():int
		{
			if(this.parent){
				return this.parent.getChildIndex(this);
			}
			
			return int.MAX_VALUE;
		}
		
		public function set widthMask(value:Number):void
		{
			if(this.mask)
			{
				this.mask.width = value; 
			}
			else
			{
				super.width = value;
			}
		}
		
		public function get widthMask():Number
		{
			if(this.mask)
			{
				return this.mask.width; 
			}
			else
			{
				return super.width;
			}
		}
		
		public function set xMask(value:Number):void
		{
			if(this.mask)
			{
				this.mask.x = value; 
			}
			else
			{
				super.x = value;
			}
		}
		
		public function get xMask():Number
		{
			if(this.mask)
			{
				return this.mask.x; 
			}
			else
			{
				return super.x;
			}
		}
		
		public function set yMask(value:Number):void
		{
			if(this.mask)
			{
				this.mask.y = value; 
			}
			else
			{
				super.y = value;
			}
		}
		
		public function get yMask():Number
		{
			if(this.mask)
			{
				return this.mask.y; 
			}
			else
			{
				return super.y;
			}
		}
		
		public function set heightMask(value:Number):void
		{
			if(this.mask)
			{
				this.mask.height = value; 
			}
			else
			{
				super.height = value;
			}
		}
		
		public function get heightMask():Number
		{
			if(this.mask)
			{
				return this.mask.height; 
			}
			else
			{
				return super.height;
			}
		}
		
	}
}