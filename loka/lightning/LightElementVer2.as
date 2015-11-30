package loka.lightning
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.utils.getTimer;
	
	
	/**
	 * ...
	 *
	 * @history create Sep 26, 2012 4:17:00 PM
	 * @author g.savenko
	 */    
	public class LightElementVer2 extends Sprite
	{
		//------------------------------------------------
		//      Class constants
		//------------------------------------------------
		
		//------------------------------------------------
		//      Variables
		//------------------------------------------------
		private var _elements:Vector.<Point> = new Vector.<Point>();
		private var _width:Number;
		private var _widthDT:Number;
		
		private var _livingTime:Number;
		private var _islivingTime:Boolean;
		
		private var _ptStart:Point;
		private var _ptFinish:Point;
		
		private var _dt:Number;
		private var _lastTime:Number;
		
		private var _yDt:Number;
		
		private var _glowed:Boolean = true;
		private var _isHasAnotherlight:Boolean = true;
		//---------------------------------------------------------------
		//
		//      CONSTRUCTOR
		//
		//---------------------------------------------------------------
		public function LightElementVer2(ptStart:Point, ptFinish:Point, widthDt:Number, livingTime:Number = 0, glowed:Boolean = true, isHasAnotherlight:Boolean = true)
		{
			super();
			
			_glowed = glowed;
			_isHasAnotherlight = isHasAnotherlight;
			
			setPoint1(ptStart);
			setPoint2(ptFinish);
			
			_islivingTime = livingTime != 0;
			_livingTime = livingTime;
			
			this._widthDT = widthDt;
			
			if(!stage)
			{
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
			else
			{
				init();
			}
			
		}
		
		//---------------------------------------------------------------
		//
		//      PRIVATE & PROTECTED METHODS
		//
		//---------------------------------------------------------------
		private function init(e:Event = null):void
		{
			this._width = Point.distance(_ptStart, _ptFinish);
			_yDt = this._widthDT * 10;
			var angl:Number = Math.atan2(_ptFinish.y - _ptStart.y, _ptFinish.x - _ptStart.x) * 180 / Math.PI;
			rotation = angl;
			
			var count:uint = _width / _widthDT;
			
			var lengthXDT:Number = _width / count;
			var lengthYDT:Number = 1;
			lengthYDT = 1;
			
			for(var step:uint = 0; step < _width / _widthDT; step++)
			{
				if(step > _elements.length)
				{
					_elements.push(new Point(step * lengthXDT, Math.random() * _yDt - _yDt / 2 /*+ Math.cos(step / 50) * (100)*/));
				}
			}
			_elements = _elements.slice(0, step);
			if(_glowed && this.filters.length == 0)
			{
				filters = [
					new GlowFilter(0xffffff, .7, 6, 6, 4, 3),
					new GlowFilter(0x00ffff, .7, 24, 24, 4, 3)
				];
			}
			else if(!_glowed)
			{
				filters = [];
			}
			_lastTime = getTimer();
			
			addEventListener(Event.ENTER_FRAME, onEnter);
			draw();
		}
		
		protected function onEnter(event:Event):void
		{
			update();
		}
		
		private var _orientation:int = 1
		private var _randomeWaveId:int = 0
		private var _nextRandomTime:Number = 0;
		private function randomWavePoint():void
		{
			_randomeWaveId = int(Math.random() * _elements.length);
			_nextRandomTime = Math.random() * 1000;
			
			if(int(Math.random() * 2))
			{
				_orientation = -_orientation;
			}
		}
		
		private var _endDraw:uint = 0
		private var _startDraw:uint = 0
		private function draw():void
		{
			graphics.clear();
			graphics.lineStyle(2, 0xffffff, .5);
			graphics.moveTo(0, 0);
			var step:uint = 0;
			for each(var pt:Point in _elements)
			{
//				graphics.drawCircle(pt.x, pt.y, .1);
				step+=1;
				if(_startDraw < step && _endDraw > step )
				{
					graphics.lineTo(pt.x, pt.y);
				}
				else if(_startDraw > step)
				{
					graphics.moveTo(pt.x, pt.y);
				}

				
				
			}
		}
		
		private var _anotherLight:LightElementVer2;
		private var _anotherLightLivingTime:Number = 1000 / 2;
		private var _anotherLightRandomeWaveId1:uint = 0;
		private var _anotherLightRandomeWaveId2:uint = 0;
		
		private function anotherLight(dt:Number):void
		{
			_anotherLightLivingTime-=dt;
			if(_anotherLightLivingTime < 0)
			{
				_anotherLightLivingTime = Math.random() * 1000 * 15;
//				_anotherLightLivingTime = 1000;
				_anotherLightRandomeWaveId1 = int(Math.random() * _elements.length);
				_anotherLightRandomeWaveId2 = int(Math.random() * _elements.length);
//				_anotherLightRandomeWaveId2 = int(_elements.length - 1);
//				_anotherLightRandomeWaveId1 = int(0);
				if(_anotherLight)
				{
					_anotherLight.die();
					_anotherLight = null;
				}
				if(_anotherLightRandomeWaveId1 < _anotherLightRandomeWaveId2)
				{
					var pt1:Point = _elements[_anotherLightRandomeWaveId1].clone();
					
					var pt2:Point = _elements[_anotherLightRandomeWaveId2].clone();
					pt2.x -= pt1.x;
					pt2.y -= pt1.y;
					
					_anotherLight = new LightElementVer2(pt1, pt2, _widthDT * .81, _anotherLightLivingTime, false);
					if(parent)
					{
						addChild(_anotherLight);
					}
					
					_anotherLight.setPoint1(pt1);
//					_anotherLight.setPoint2(_elements[_anotherLightRandomeWaveId2].clone());
					_anotherLight.setPoint2(pt2);
				}
				else
				{
					_anotherLightLivingTime = 0;
				}
			}
			
			if(
				_anotherLight
				&&
				_anotherLightRandomeWaveId1 < _elements.length 
				&&
				_anotherLightRandomeWaveId2 < _elements.length 
			)
			{
				/*var pt1:Point = _elements[_anotherLightRandomeWaveId1].clone();
				
				var pt2:Point = _elements[_anotherLightRandomeWaveId2].clone();
				pt2.x -= pt1.x;
				pt2.y -= pt1.y;
				_anotherLight.setPoint1(pt1);
				//					_anotherLight.setPoint2(_elements[_anotherLightRandomeWaveId2].clone());
				_anotherLight.setPoint2(pt2);*/
			}
			else if(_anotherLight)
			{
				_anotherLight.dispose();
				_anotherLight = null;
			}
		}
		
		private function living(dt:Number):void
		{
			if(_islivingTime)
			{
				_livingTime -= _dt;
				if(_livingTime < 0 && !_die)
				{
					die();
				}
			}
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
		
		public function setPoint1(point:Point):void
		{
			if(!_ptStart || _ptStart.x != point.x && _ptStart.y != point.y)
			{
				_ptStart = point;
				x = _ptStart.x;
				y = _ptStart.y;
				_ptStart.x = 0;
				_ptStart.y = 0;
				if(stage)
				{
					init();
				}
			}
		}
		
		private var _obj2:Object;
		private var _obj2XOffset:Number = 0;
		private var _obj2YOffset:Number = 0;
		public function setEndObject(obj2:Object, XOffset:Number = 0, YOffset:Number = 0):void
		{
			_obj2 = obj2;
			_obj2XOffset = XOffset;
			_obj2YOffset = YOffset;
		}
		
		private var _obj1:Object;
		public function setStartObject(obj1:Object):void
		{
			_obj1 = obj1;
		}
		
		public function setPoint2(point:Point):void
		{
			if(!_ptFinish || _ptFinish.x != point.x && _ptFinish.y != point.y)
			{
				_ptFinish = point;
				_ptFinish.x -= x;
				_ptFinish.y -= y;
				if(stage)
				{
					init();
				}
			}
		}
		
		
		public function update():void
		{
			var prevPt:Point;
			var count:uint = 0;
			
			var duration:Number = 5;
			var time:Number = getTimer(); 
			_dt = time - _lastTime;
			_lastTime = time;
			
			updateObjectPosition();
			
			_nextRandomTime -= _dt;
			
			_nextRandomTime -= _dt;
			if(_nextRandomTime < 0)
			{
				randomWavePoint();
			}
			if(_elements.length <= 2)
			{
				return;
			}
			
			for each(var pt:Point in _elements)
			{
				count++;
				if(
					_anotherLight
					&&
					(
						count == _anotherLightRandomeWaveId1 
						|| 
						count == _anotherLightRandomeWaveId2
						||
						count + 1 == _anotherLightRandomeWaveId1 
						|| 
						count + 1 == _anotherLightRandomeWaveId2
						||
						count - 1 == _anotherLightRandomeWaveId1 
						|| 
						count - 1 == _anotherLightRandomeWaveId2
					)
				)
				{
					continue;
				}
				pt.y += Math.random() * _yDt - _yDt / 2;
//				yDt +=.1;
				if(prevPt)
				{
					pt.y += (prevPt.y - pt.y) / duration;
					prevPt.y += (pt.y - prevPt.y) / duration
				}
				else if(!prevPt && _elements.length > count+1)
				{
					pt.y += (0 - pt.y) / duration;
					_elements[count+1].y += (pt.y - _elements[count+1].y) / duration
				}
				if(count == _elements.length && prevPt)
				{
					pt.y = 0;//_ptFinish.y - _ptStart.y;//(_ptFinish.y - pt.y) / 2;	
					prevPt.y += (pt.y - prevPt.y) / duration;
				}
				
				if(count == _randomeWaveId)
				{
					pt.y += _yDt * _orientation / 2 * 1;
				}
				prevPt = pt;
			}
			
			draw();
			if(!_die && _isHasAnotherlight)
			{
				anotherLight(_dt);
			}
			if(_die)
			{
				_startDraw+=_width / 40;
			}
			if(_endDraw < _elements.length && !_die)
			{
				_endDraw+=_width / 20;
			}
			if(_startDraw > _elements.length)
			{
				dispose();
			}
			living(_dt);
		}
		
		private function updateObjectPosition():void
		{
			// TODO Auto Generated method stub
//			if(!_die)
			{
				if(_obj2)
				{
					if(_obj2.hasOwnProperty("x") && _obj2.hasOwnProperty("y"))
					{
						setPoint2(new Point(_obj2.x + _obj2XOffset, _obj2.y + _obj2YOffset));
					}
				}
				
				if(_obj1)
				{
					if(_obj1.hasOwnProperty("x") && _obj1.hasOwnProperty("y"))
					{
						setPoint1(new Point(_obj1.x, _obj1.y));
					}
				}
			}
		}
		
		private var _die:Boolean = false;
		public function die():void
		{
			_die = true;
			if(_anotherLight)
			{
				_anotherLight.die();
			}
		}
		
		public function dispose():void
		{
			if(_anotherLight)
			{
				_anotherLight.dispose();
				_anotherLight = null;
			}
			removeEventListener(Event.ENTER_FRAME, onEnter);
			graphics.clear();
			_elements = null;
			
			if(parent)
			{
				parent.removeChild(this);
			}
		}
		//---------------------------------------------------------------
		//
		//      ACCESSORS
		//
		//---------------------------------------------------------------
	}
}