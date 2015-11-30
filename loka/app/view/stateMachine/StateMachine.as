package utils.loka.app.view.stateMachine
{
	import flash.display.DisplayObjectContainer;
	import flash.utils.Dictionary;
	
	import utils.loka.app.view.stateMachine.states.IState;

	/**
	 * State machine beta version
	 * Статический класс для работы с сущностями стейтов 
	 * @author loka
	 * 
	 */
	public class StateMachine
	{
		/**
		 *Parent stage for states  
		 */
		private static var mainConteinner:DisplayObjectContainer;
		
		/**
		 *Хешь стейтов 
		 */
		private static var _states:Dictionary;
		private static var _currentState:IState;
		
		public function StateMachine()
		{
			
		}
		
		/**
		 * Текущий, активный стейт 
		 */
		public static function get currentState():IState
		{
			return _currentState;
		}

		/**
		 * Инициализация стейт машины 
		 * @param mainConteinner
		 * 
		 */
		public static function init(mainConteinner:DisplayObjectContainer):void
		{
			StateMachine.mainConteinner = mainConteinner;
			_states = new Dictionary(); 
		}
		
		/**
		 *	Возвращает стейт по его уникальному имени 
		 * @param stateAlias
		 * @return 
		 * 
		 */
		public static function getState(stateAlias:String, reasone:* = null):IState
		{
			if(_states.hasOwnProperty(stateAlias))
			{
				return _states[stateAlias] as IState; 
			}
			
			return null;
		}
		
		/**
		 * Уничтожение стейта 
		 * @param stateAlias
		 * 
		 */
		public static function removeState(stateAlias:String):void
		{
			var state:IState = getState(stateAlias); 
			if(state)
			{
				delete _states[stateAlias];
				state.dispose();
				if(state.DOC.parent)
				{
					mainConteinner.removeChild(state.DOC);
					if(_currentState == state)
					{
						_currentState = null;
					}
				}
			}
			else
			{
				throw new Error("Wow, state with alias name: " + state.alias + " has not found to remove");
			}
		}
		
		/**
		 * Регистрация стейта 
		 * @param state
		 * 
		 */
		public static function registerState(state:IState):void
		{
			if(getState(state.alias))
			{
				throw new Error("Wow, state with alias name: " + state.alias + " has registered ");
			}
			
			_states[state.alias] = state;
			
			state.init();
		}
		
		/**
		 * Открывает стейт в независимости от того есть ли кроме него другие стейты 
		 * @param stateAlias
		 * 
		 */
		public static function openState(stateAlias:String, reasone:* = null):void
		{
			mainConteinner.addChild(getState(stateAlias).DOC);
			getState(stateAlias).activate(reasone);
		}
		
		/**
		 * Закрывает стейт в независимости от того есть ли кроме него другие стейты
		 * @param stateAlias
		 * 
		 */
		public static function closeState(stateAlias:String):void
		{
			mainConteinner.removeChild(getState(stateAlias).DOC);
			getState(stateAlias).deactivate();
		}
		
		/**
		 * Метод предоставляющий возможность перехода со стейта в стейт 
		 * @param stateAlias
		 * 
		 */
		public static function gotoState(stateAlias:String, reasone:* = null):void
		{
			var prevState:IState = _currentState;
			_currentState = getState(stateAlias);
			
			if(_currentState)
			{
				if(prevState)
				{
					mainConteinner.removeChild(prevState.DOC);
					prevState.deactivate();
				}
				
				mainConteinner.addChild(_currentState.DOC);
				_currentState.activate(reasone);
			}
			else
			{
				throw new Error("Wow, state with alias name: " + stateAlias + " has not found to activate him");
			}
		}
	}
}