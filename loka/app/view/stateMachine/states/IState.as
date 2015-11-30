package loka.app.view.stateMachine.states
{
	import flash.display.DisplayObjectContainer;
	
	import loka.globalInterface.IActivateDeactivate;
	import loka.globalInterface.IDispose;

	/**
	 *	Интерфейс сущности стейтоа.
	 * 	В основном для работы стейт машины 
	 * @author loka
	 * 
	 */
	public interface IState extends IDispose, IActivateDeactivate
	{
		/**
		 * Метод инициализации стейта 
		 * 
		 */
		function init():void;
		
		/**
		 * Unique identifier 
		 * @return alias name as String
		 * 
		 */
		function get alias():String;
		
		/**
		 * Need to know about DO content
		 * @return DisplayObjectContainer
		 * 
		 */
		
		function get DOC():DisplayObjectContainer;
		
	}
}