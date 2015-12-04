package loka.app.view.stateMachine.states
{
	import flash.display.DisplayObjectContainer;

	/**
	 * Базовая сущность стейта, Не хранит логики, упрощает работу и исбавляет от излишней копипасты
	 * @author loka
	 * 
	 */
	public class BaseState implements IState
	{
		private var _doc:DisplayObjectContainer;
		private var _alias:String;
		private var _isDispose:Boolean = false;
		
		/**
		 * 
		 * @param DOC
		 * @param alias
		 * 
		 */
		public function BaseState(DOC:DisplayObjectContainer, alias:String)
		{
			_doc = DOC;
			_alias = alias;
		}
		
		public function init():void
		{
		}
		
		public function activate(reasone:* = null):void
		{
			initEventListeners();
		}
		
		public function deactivate():void
		{
			removeEventListeners();
		}
		
		public function get alias():String
		{
			return _alias;
		}
		
		public function get DOC():DisplayObjectContainer
		{
			return _doc;
		}
		
		public function dispose():void
		{
			try
			{
				removeEventListeners();
			}
			catch(e:*)
			{
				trace("object with linkage has already destroyed");
			}
			
			_isDispose = true;
			_doc = null;
			_alias = "";
			
		}
		
		public function get isDispose():Boolean
		{
			return _isDispose;
		}
		
		protected function initEventListeners():void
		{
			
		}
		
		protected function removeEventListeners():void
		{
			
		}
		
	}
}