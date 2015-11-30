package utils.loka.google
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	
	import utils.loka.button.Btn;
	import utils.loka.console.Console;
	import utils.loka.ui.Popup;
	
	/**
	 * ...
	 *
	 * @history create Apr 25, 2012 11:01:00 PM
	 * @author g.savenko
	 */    
	public class Sheet extends Sprite
	{
		//------------------------------------------------
		//      Class constants
		//------------------------------------------------
		
		//------------------------------------------------
		//      Variables
		//------------------------------------------------
		
		//---------------------------------------------------------------
		//
		//      CONSTRUCTOR
		//
		//---------------------------------------------------------------

		private var submitBtn:Btn;

		private var name_txt:TextField;

		private var message_txt:TextField;

		private var email_txt:TextField;
		
		public function Sheet()
		{
			initUI();
			initListeners();
		}
		
		
		
		//---------------------------------------------------------------
		//
		//      PRIVATE & PROTECTED METHODS
		//
		//---------------------------------------------------------------
		private function initUI():void
		{
			submitBtn = new Btn();
			submitBtn.createBtnRect(100, "send");
			
			name_txt = new TextField();
			message_txt = new TextField();
			email_txt = new TextField();
			email_txt.type = TextFieldType.INPUT;//"input";
			email_txt.text = "asd";
			
			name_txt.border = true;
			name_txt.borderColor = 0xffffff;
			
			message_txt.border = true;
			message_txt.borderColor = 0xffffff;
			
			email_txt.border = true;
			email_txt.borderColor = 0xffffff;
			
			name_txt.border = true;
			name_txt.borderColor = 0xffffff;
			
			name_txt.width		= 290; 
			message_txt.width	= 290; 
			email_txt.width		= 290;
			
			name_txt.height		= 23,8; 
			message_txt.height	= 56,8; 
			email_txt.height	= 23,8;
			
			name_txt.x 		= 100; 
			message_txt.x 	= 100; 
			email_txt.x 	= 100;
			submitBtn.x 	= 312,2
				
			name_txt.y 		= 10; 
			message_txt.y 	= 40; 
			email_txt.y 	= 130;
			submitBtn.y 	= 207,1;
			
			addChild(name_txt);
			addChild(message_txt);
			addChild(email_txt);
			addChild(submitBtn);
//			var submitBtn:TextField = new TextField();
		}
		
		private function initListeners():void
		{
			submitBtn.addEventListener(MouseEvent.MOUSE_UP, onSubmitBtnPressed);
		}
		
		protected function onSubmitBtnPressed(event:MouseEvent):void
		{
			var loader:URLLoader = new URLLoader();
			
			var variables:URLVariables = new URLVariables();
			variables["entry.0.single"] = this.name_txt.text;
			variables["entry.1.single"] = this.message_txt.text;
			variables["entry.2.single"] = this.email_txt.text;
			//the unique key for your form, found in the url for your form
			var key:String = "pyxyLmVwUP3PhX7wp6GV_SQ"
			//Take the url using the key from your form
			var _targetURL:String = "http://spreadsheets.google.com/formResponse?key="+key
			//embed the url to call to add the data to spreadsheet as post var
			variables["_url"] = _targetURL;
			//call the proxy page passing all the variables above
			var request:URLRequest = new URLRequest("GoogleSpreadsheetProxy.php");
			request.data = variables;
			request.method = URLRequestMethod.POST;
			//navigateToURL(request);
			//Show the user a sending progress message for usability.
			this.showSendingMessage();
			loader.addEventListener(Event.COMPLETE, onSendDataComplete);
			//loader.addEventListener(Event.OPEN, onSendDataComplete);
			//loader.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSendDataError);
			//loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, onSendDataError);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onSendDataError);
			
			loader.load(request);
		}
		protected function showSendingMessage():void
		{
//			this.showScreenBlocker();
			//call internal method to create and show a panel using "SendingPanel linked mc from library and giving new panel instance name "sendingPanel_mc"
//			this.showPanel("SendingPanel","sendingPanel_mc");
		}
		
		protected function onSendDataError(event:IOErrorEvent):void
		{
			// TODO Auto-generated method stub
			Console.write("onSendDataError.IOErrorEvent: " + event.errorID);
		}
		
		protected function onSendDataComplete(event:Event):void
		{
			// TODO Auto-generated method stub
			Console.write("onSendDataComplete");
			this.showCompletionMessage();
		}
		/**
		 * Shows completion message to user so they know that their message has been delivered
		 *
		 */
		public function showCompletionMessage():void
		{
			//hide the panel showing sending in progress
			this.hidePanel(this.getChildByName("sendingPanel_mc"));
			//should really put this code in its own class, by the time investment turning 3 lines into a class is not warrented
			Popup.ShowMessage("Message Sent");
			Popup.target.addEventListener(Popup.HIDE, onCompletionOkPressed);
//			var panel = this.showPanel("CompletionMessage","completionMessage_mc");
//			panel.okBtn.buttonMode = true;
//			panel.okBtn.addEventListener(MouseEvent.MOUSE_UP, onCompletionOkPressed);
		}
		
		/**
		 * Takes in the name of a mc linked in the library, and the instance name to give it, and creates it
		 * offscreen. Then applies a tween to transition it to the center of the screen.
		 * It also gives it a dropshadow and removes any instances with the same name.
		 *
		 */
		/*function showPanel(libName:String,instanceName:String):MovieClip
		{
			//remove previous instance
			try{
				var oldInstance = this.getChildByName(instanceName);
				this.removeChild(oldInstance);
			}catch(error:Error)
			{
				
			}
			//create new instance from name	
			var ClassReference:Class = getDefinitionByName((libName) as Class;
			var panel:MovieClip = new ClassReference();
			
			panel.name = instanceName;//this.attachMovie(libName,instanceName,this.getNextHighestDepth());
			//get the final point to transition it to , based on width of the stage
			var targetX:int = Math.round((410/2)-(panel.width/2));
			//position in vertically in the middle
			panel.y = Math.round((this.height/2)	-(panel.height/2));
			//apply a dropshadow
			panel.filters = [new flash.filters.DropShadowFilter()];
			//position it offscreen
			panel.x = this.width;
			//decalre easing to use
			var easing = fl.transitions.easing.Regular.easeOut;
			//declare the tween intself
//			var tween:Tween = new fl.transitions.Tween(panel,"x",easing,panel.x,targetX,.5,true);
			
			this.addChild(panel);
			
			return panel;
		}*/
		/**
		 * Called when the user actions the ok button on the completion panel
		 */
		public function onCompletionOkPressed(event:MouseEvent):void
		{
			this.removeChild(this.getChildByName("completionMessage_mc"));
			this.hideScreenBlocker();
		}
		
		public function hideScreenBlocker():void
		{
			//remove the screenblcoker from the stage
			try{
				
//				this.removeChild(this.ScreenBlocker_mc);
			}catch(error:Error)
			{
				
			}
		}
		/**
		 * Hide the instance passed, by removing it fom stage.
		 *
		 */
		public function hidePanel(target:DisplayObject):void
		{
			try{
				this.removeChild(target);
			}catch(error:Error)
			{
				
			}
		}
		
		public function onScreenBlockerPressed(event:MouseEvent):void
		{
			
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
		
		
		//---------------------------------------------------------------
		//
		//      ACCESSORS
		//
		//---------------------------------------------------------------
	}
}