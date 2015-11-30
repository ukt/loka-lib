package utils.loka.asUtils
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.GlowFilter;
	import flash.net.SharedObject;
	import flash.system.System;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.getTimer;
	
	import utils.loka.asUtils.setInterval.IntervalCaller;
	import utils.loka.drags.Drags;
	import utils.loka.text.TextUtils;
	
//	import utils.asUtils.setInterval.IntervalCaller;

//	import utils.drags.Drags;
//	import utils.text.TextUtils;
	
	/**********************************************************************
	 * @author Kondratenko Alexandr
	 **********************************************************************/
	public class FPSGraphic extends Sprite
	{
		static private const WIDTH:int = 200;
		static private const HEIGHT:int = 100;
		static private const VALUES_COUNT:int = 200;
		static private const MAX_GRAPS_LINE:int = 70;
		
		static private const NAME:String = "FPSGraphic";
		
		static private const FONT_NAME:String = "Arial";
		static private const FONT_SIZE:int = 12;
		static private const FONT_COLOR:uint = 0xffffff;
		
		static private const LINE_COLOR_MAX_FPS:uint = 0x00ffff;
		static private const LINE_COLOR_FPS:uint = 0xff0000;
		static private const LINE_COLOR_MEMORY:uint = 0x00ff00;
		static private const GRID_COLOR:uint = 0x00ffff;
		
		private var _MAX_FPS:Array;
		private var _FPS:Array;
		private var _MEMORY:Array;
		private var _currentFPS:Number;
		
		private var _bg:Sprite;
		private var _graphic:Sprite;
		private var _lastTime:int;
		
		private var _inforamitionTxt:TextField;
		private var _drager:Drags;

		private var userData:SharedObject;
		private var _secconds:int = new Date().seconds;

		private var _timmerNum:Number;
		public function FPSGraphic()
		{
			if(parent)
			{
				onInit(null);
			}
			else
			{
				addEventListener(Event.ADDED_TO_STAGE, onInit);
			}
			
		}
		
		private var _init:Boolean = false;
		protected function onInit(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			addEventListeners();
			if(!_init)
			{
				_init = true;
			_lastTime = 0;
			_currentFPS = 0;
			
//			mouseEnabled = false;
			mouseChildren = false;
			
			_bg = new Sprite();
			_graphic = new Sprite();
			
			addChild(_bg);
			
			_bg.graphics.beginFill(0);
			_bg.graphics.drawRect(0, 0, WIDTH, HEIGHT);
			_bg.graphics.endFill();
			
			initBg();
			
			addChild(_graphic);
			
			_inforamitionTxt = createTextField();
			_inforamitionTxt.alpha = 0.5;
			
			addChild(_inforamitionTxt);
			
			_inforamitionTxt.x = 0;//WIDTH/2;
			
			_FPS = new Array();
			_MAX_FPS = new Array();
			_MEMORY = new Array();
			
			var i:int;
			
			for(i = 0; i < VALUES_COUNT; i++)
			{
				_MAX_FPS.push(0);
				_FPS.push(0);
				_MEMORY.push(0);
			}
			
			_drager = new Drags(this, true, 1);
			
			userData = SharedObject.getLocal(NAME);
			this.x = userData.data.x;
			this.y = userData.data.y;
			_drager.addEventListener(Drags.DRAGED_START, 
				function(e:Event):void
				{
					removeEventListeners();
				}
			);
				
			_drager.addEventListener(Drags.DRAGED_STOP, 
				function(e:Event):void
				{
					addEventListeners();
					userData = SharedObject.getLocal(NAME);
					userData.data.x = x;
					userData.data.y = y;
					userData.flush();
				}
			);
			
			_timmerNum = IntervalCaller.addIntervalCaller(function():void
			{
				_secconds++;
				if(_secconds > 60)
				{
					_secconds = 1;
				}
			}
				,1000
			)
		}
		}
		
		private function removeEventListeners():void
		{
			parent.removeEventListener(Event.ADDED, updateZPosition);
			parent.removeEventListener(Event.REMOVED, updateZPosition);
			parent.removeEventListener(Event.ENTER_FRAME, onEnterFrame, false);
		}
		
		private function addEventListeners():void
		{
			parent.addEventListener(Event.ADDED, updateZPosition);
			parent.addEventListener(Event.REMOVED, updateZPosition);
			parent.addEventListener(Event.ENTER_FRAME, onEnterFrame, false, 0, true);
		}
		
		protected function updateZPosition(event:Event):void
		{
			// TODO Auto-generated method stub
			if(event.target == this)
			{
				removeEventListeners();
				addEventListener(Event.ADDED_TO_STAGE, onInit);
			}
			else
			{
				parent?parent.addChild(this):null;
			}
		}
		
		private function initBg():void
		{
			_bg.graphics.lineStyle(1, GRID_COLOR);
			
			var i:int = 10;
			var y:Number;
			
			while(i < MAX_GRAPS_LINE)
			{
				y = (1-i/MAX_GRAPS_LINE)*HEIGHT;
				
				_bg.graphics.moveTo(0, y);
				_bg.graphics.lineTo(WIDTH, y);
				
				i += 10;
			}
			
			_bg.alpha = 0.2;
		}
		
		private function createTextField():TextField
		{
			var fmt:TextFormat = new TextFormat(FONT_NAME, FONT_SIZE, FONT_COLOR, true);
			
			var res:TextField = new TextField();
			
			res.selectable = false;
			res.tabEnabled = false;
			res.defaultTextFormat = fmt;
			res.autoSize = TextFieldAutoSize.LEFT;
			TextUtils.changeLeading(res, -4);
			res.filters = [new GlowFilter(0, 1,2,2,12,1)];
			return res;
		}
		
		private function onEnterFrame(event:Event):void
		{
			var curTime:int = getTimer();
			var dt:int = curTime-_lastTime;
			
			_lastTime = curTime;
			
			if(dt)
			{
				var fps:Number = 1000/dt;
				
				var k:Number = 0.3;
				
				if(fps > _currentFPS)
				{
					k = 0.1;
				}
				
				_currentFPS = (fps-_currentFPS)*k+_currentFPS;
				
				update(_currentFPS);
				draw();
			}
			else
			{
				update(0);
			}
		}
		
		private function getMaxValue(arr:Array):Number
		{
			var result:Number = arr[0];
			
			for each(var c:Number in arr)
			{
				result = Math.max(result, c);
			}
			
			return result;
		}
		
		private var memoryMaxK:Number = 1;
		private var memoryMaxValue:Number = MAX_GRAPS_LINE;
		private function update(fps:Number):void
		{
			_MAX_FPS.shift();
			_FPS.shift();
			_FPS.push(fps);
			
			var memory:Number = Math.round(System.totalMemory/1048576);
			var oldMemmory:Number = _MEMORY.shift();
			_MEMORY.push(memory);
			
			_MAX_FPS.push(stage.frameRate);
			
			if(oldMemmory == memoryMaxValue)
			{
				memoryMaxValue = getMaxValue(_MEMORY);
				memoryMaxK = (MAX_GRAPS_LINE / memoryMaxValue);
			}
			
			if(memory * memoryMaxK > MAX_GRAPS_LINE)
			{
				memoryMaxValue = memory;
				memoryMaxK = (MAX_GRAPS_LINE / memory);
			}
		}
		
		private function drawGrafs(arr:Array, color:uint, k:Number):void
		{
			var i:int;
			
			var x:Number;
			var y:Number;
			
			_inforamitionTxt.text = "";
			
			var text:String = "maxFPS: " + int(stage.frameRate).toString();
			TextUtils.addTextWithColor(_inforamitionTxt, text, LINE_COLOR_MAX_FPS);
			
			text = "\nFPS: " + int(_currentFPS).toString();
			TextUtils.addTextWithColor(_inforamitionTxt, text, LINE_COLOR_FPS);
			
			text = "\nMemory: " +Math.round(System.totalMemory/1048576);
			TextUtils.addTextWithColor(_inforamitionTxt, text, LINE_COLOR_MEMORY);
			
			text = "\nSec: " + _secconds;
			TextUtils.addTextWithColor(_inforamitionTxt, text, 0xffffff);
			
			text = "\nmouse: [" + stage.mouseX + " , " + stage.mouseY + "]";
			TextUtils.addTextWithColor(_inforamitionTxt, text, 0xcecece);
			
			
			
			
			_graphic.graphics.lineStyle(1, color);
			
			x = WIDTH*i/(arr.length-1);
			y = (1-((arr[0] * k)/MAX_GRAPS_LINE))*HEIGHT;
			
			_graphic.graphics.moveTo(x, y);
			
			for(i = 1; i < arr.length; i++)
			{
				x = WIDTH*i/(arr.length-1);
				y = (1-((arr[i] * k)/MAX_GRAPS_LINE))*HEIGHT;
				
				_graphic.graphics.lineTo(x, y);
			}
		}
		
		private function draw():void
		{
			if(visible)
			{
				_graphic.graphics.clear();
				drawGrafs(_MAX_FPS, LINE_COLOR_MAX_FPS, 1);
				drawGrafs(_FPS, LINE_COLOR_FPS, 1);
				drawGrafs(_MEMORY, LINE_COLOR_MEMORY, memoryMaxK);
			}
		}
	}
}