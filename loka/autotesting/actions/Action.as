package loka.autotesting.actions {
	import flash.display.Stage;
	import flash.events.Event;
	import flash.utils.getTimer;
	
	import loka.autotesting.Testing;
	import loka.autotesting.actions.data.ActionData;
	import loka.autotesting.actions.data.IActionDataCollection;
	import loka.autotesting.actions.data.parser.ActionDataParser;
	import loka.console.ConsoleCommand;

	public class Action {
		
		private var stage:Stage;
		private var _id:int;
		private var automationBridge:Testing;
		private var actions:IActionDataCollection;
		private var prevTimeOut:uint;
		
		public function Action(actionsDataParser:ActionDataParser, automationBridge:Testing, id:int) {
			this._id = id;
			this.actions = actionsDataParser.parse();
			this.automationBridge = automationBridge;
			registerAction(this.actions)
			
			stage = automationBridge.getDisplayObject("*?index:1/..", false) as Stage;
			
		}
		
		protected function onEnter(event:Event):void {
			var actionData:ActionData = actions.getNext();
			if(getTimer() - prevTimeOut>actionData.timeOut){
				var isComlete:Boolean = execute(actionData);
			}
		}
		
		private function execute(actionData:ActionData):Boolean {
			if(ConsoleCommand.hasCommand(actionData.command)){
				ConsoleCommand.commandDo(actionData.command, actionData.parrams);
			}
				
			return false;
		}
		
		private function registerAction(actions:IActionDataCollection):void {
			var data:Object = actions.getNext();
		}
		
		public function run():Action{
			prevTimeOut = getTimer();
			stage.addEventListener(Event.ENTER_FRAME, onEnter);
			return this;
		}
		public function stop():Action {
			stage.removeEventListener(Event.ENTER_FRAME, onEnter);
			return this;
		}
		
		public function getId():int{
			return _id;
		}
	}
}