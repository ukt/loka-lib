package loka.ui
{
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormatAlign;
	
	import loka.button.Btn;
	import loka.globalInterface.IDispose;
	import loka.text.TextUtils;
	
	/**
	 * ...
	 *
	 * @history create Apr 25, 2012 11:18:23 PM
	 * @author g.savenko
	 */    
	public class Popup
	{
		//------------------------------------------------
		//      Class constants
		//------------------------------------------------
		
		public static var HIDE:String = "popupHide";
		//------------------------------------------------
		//      Variables
		//------------------------------------------------
		private var _tfTitle:TextField;
		private var _tfMessage:TextField;
		private var _okBtn:Btn;
		/**
		 * заливка попапа 
		 */
		private var _bgroundPopup:Sprite;
		
		private var _popup:DisplayObject;
		/**
		 *заливка экрана 
		 */
		private var _bground:Sprite;
		private var _target:Sprite;
		private var _do:DisplayObject;
		private var _doDefault:Sprite;
		private var _popupTarget:Sprite;
		//---------------------------------------------------------------
		//
		//      CONSTRUCTOR
		//
		//---------------------------------------------------------------
		public function Popup()
		{
			if(_instance)
			{
				throw new Error("this only single tone class")
			}
			
			_instance = this;
			
		}

		private function initUI():void
		{
			// TODO Auto Generated method stub
			_doDefault = new Sprite();
			_tfTitle = new TextField();
			_tfMessage = new TextField();
			
			_bgroundPopup = new Sprite();
			_bground = new Sprite();
			_popupTarget = new Sprite();
			_okBtn = new Btn();
			_okBtn.addEventListener(MouseEvent.CLICK, function onClick(e:Event):void{Hide();});
			
			_popupTarget.addChild(_bground);
			_bground.addChild(_bgroundPopup);
//			_popupTarget.addChild(_bgroundPopup);
			_doDefault.addChild(_tfTitle);
			_doDefault.addChild(_tfMessage);
			_doDefault.addChild(_okBtn);
		}
		
		private function initUIParrams():void
		{
			TextUtils.setBold(_tfTitle, true);
			TextUtils.changeColor(_tfTitle, 0);
			TextUtils.changeSize(_tfTitle, 16);
			TextUtils.setAlign(_tfTitle, TextFormatAlign.LEFT);
			_tfTitle.autoSize = TextFieldAutoSize.LEFT;
			_tfTitle.selectable = false;
//			_tfTitle.height = 16;
			
			TextUtils.setBold(_tfMessage, true);
			TextUtils.changeColor(_tfMessage, 0);
			TextUtils.changeSize(_tfMessage, 12);
			TextUtils.setAlign(_tfMessage, TextFormatAlign.CENTER);
			_tfMessage.autoSize = TextFieldAutoSize.LEFT;
			_tfMessage.selectable = false;
			
			_tfMessage.y = _tfTitle.height;
			
			_okBtn.createBtnRect(100, "ok");
			
			_bgroundPopup.filters	= [new DropShadowFilter()];
			_tfMessage.filters		= [new GlowFilter(0xffffff, 1, 2, 2, 12, 1)];
			_tfTitle.filters 		= [new GlowFilter(0xffffff, 1, 2, 2, 12, 1)];
			
//			new Drags().dragElement(_bgroundPopup);
		}
		
		private function initUIBgrounds():void
		{
			
			var gr:Graphics = _bgroundPopup.graphics;
			gr.clear();
			
			_bgroundPopup.cacheAsBitmap = true;
			var bounds:Rectangle = _bgroundPopup.getBounds(_bgroundPopup.parent);
//			gr.beginFill(int(Math.random() * 0xffffff));
			var bgAlpha:Number = _isbackgroundShow ? 1 : 0;
			gr.beginFill(0xcecece, bgAlpha);
			gr.drawRoundRect(0,0,bounds.width, bounds.height + 10, 10, 10);
			gr.endFill();
			
			_bground.cacheAsBitmap = true;
			gr = _bground.graphics;
			gr.clear();
			gr.beginFill(0xcecece, .3);
			gr.drawRoundRect(0,0,_target.stage.stageWidth, _target.stage.stageHeight, 10, 10);
			gr.endFill();
		}
		
		private function show():void
		{
			_target.stage.addChild(_popupTarget);
		}
		
		private var _isCallBack:Boolean = true;
		private function hide():void
		{
			if(_popup && _popup.parent)
			{
				if(_popup is IDispose)
				{
					IDispose(_popup).dispose();
					_popup = null;
				}
				
			}
			if(_popupTarget.parent)
			{
				_target.stage.removeChild(_popupTarget);				
			}
			
			_target.dispatchEvent(new Event(HIDE));
			if(_callBack != null && _isCallBack)
			{
				_isCallBack = false;
				_callBack();
				_callBack = null;
				_isCallBack = true;
			}
		}
		private function alignAll():void
		{
			_tfMessage.y = _tfTitle.height;
			
			_okBtn.x = (_bgroundPopup.width - _okBtn.width) / 2;
			_okBtn.y = _tfMessage.y + _tfMessage.height + 5;//(_bgroundPopup.height - _okBtn.height - 5);
			
			var rect:Rectangle = _bgroundPopup.getBounds(_bground);
			_bgroundPopup.x = (_bground.width - rect.width) / 2;
			_bgroundPopup.y = (_bground.height - rect.height) / 2;
		}
		//---------------------------------------------------------------
		//
		//      PRIVATE & PROTECTED METHODS
		//
		//---------------------------------------------------------------
		
		
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
		private var _callBack:Function;
		public function showWithDO(popup:DisplayObject, title:String = "", closed:Boolean = false, callBackF:Function = null):void
		{
			Hide();
			_callBack = callBackF;
			while(_bgroundPopup.numChildren)
			{
				var DO:DisplayObject = _bgroundPopup.removeChildAt(0)
				
				if(_popupTarget is IDispose)
				{
					IDispose(_popupTarget).dispose();
				}
			}
			
			_tfTitle.text 		= title;
			_popup = popup;
			_bgroundPopup.addChild(_popup);
			instance.alignAll();
			instance.initUIBgrounds();
			instance.alignAll();
			show();
		}
		
		public function showMessage(message:String, title:String = "", closed:Boolean = false, callBackF:Function = null):void
		{
			_tfTitle.text 		= title;
			_tfMessage.text 	= message;
			showWithDO(_doDefault, title, closed, callBackF);
		}
		
		//---------------------------------------------------------------
		//
		//      ACCESSORS
		//
		//---------------------------------------------------------------
		
		//---------------------------------------------------------------
		//
		//      STATICS
		//
		//---------------------------------------------------------------
		public static function Hide():void
		{
			instance.hide();
		}
		
		public static function ShowWithDO(popup:DisplayObject, title:String = "", closed:Boolean = false, callBackF:Function = null):void
		{
			instance.showWithDO(popup, title, closed, callBackF);
		}
		
		public static function ShowMessage(message:String, title:String = "", closed:Boolean = false, callBackF:Function = null):void
		{
			instance.showMessage(message, title, closed, callBackF);
		}
		
		private var _isbackgroundShow:Boolean = true;
		public static function backgroundShow(value:Boolean):void
		{
			instance._isbackgroundShow = false;
		}
		public static function Init(target:Sprite):void
		{
			if(!_init)
			{
				_init = true;
				instance._target = target;
				instance.initUI();
				instance.initUIParrams();
				instance.initUIBgrounds();
				instance.alignAll();
			}
		}
		
		public static function get target():Sprite
		{
			return instance._target;
		}
		//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
		private static var _init:Boolean = false;
		private static var _instance:Popup;
		public static function get instance():Popup
		{
			if(!_init)
			{
				throw new Error("need Init(target) single tone class  ")
			}
			if(!_instance)
			{
				_instance = new Popup();
			}
			return _instance;
		}
		
		
	}
}