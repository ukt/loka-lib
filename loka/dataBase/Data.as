package loka.dataBase {
	import flash.display.Sprite;
	/**
	 * ...
	 * @author loka
	 */
	public class Data extends Sprite{
		private var _arr:Array = new Array();
		private var _traceStatus:Boolean = false;
		public function Data() {
			
		}
		//protected function 
		public function get data():Array {
			return this._arr;
		}
		public function init():void{
			this._arr = new Array();
			this.addNewData("init", "init");
		}
		public function swapData(name1:String, name2:String):Boolean {
			var action:Boolean = true;
			if (issetData(name1) && issetData(name1)) {
				var el1:Object;
				var el1Index:int;
				var el2:Object;
				var el2Index:int;
				for (var c:String in this._arr) {
					if (this._arr[c].name == name1) {
						el1 = this._arr[c];
						el1Index = parseInt(c);
					}
					if (this._arr[c].name == name2) {
						el2 = this._arr[c];
						el2Index = parseInt(c);
					}
				}
				
				this._arr[el1Index] = el2;
				this._arr[el2Index] = el1;
			}else{
				action = false;
				if(this._traceStatus) trace("error data name: "+name);
			}
			return action;
		}
		public function getDataByName(name:String):Object {
			var arr:Array = new Array();
			var action:Boolean = true;
			for (var c:String in this._arr) {
				if (this._arr[c].name == name) {
					return this._arr[c];
				}
				//trace("name="+this._arr[c].name);
			}
			action = false;
			if(this._traceStatus) trace("error data name: "+name);
			var obj:Object = new Object();
			obj.data = false;
			return obj;
		}
		public function updateDataByName(name:String,data:Object):Boolean {
			for (var c:String in this._arr) {
				if (this._arr[c].name == name) {
					this._arr[c] = data;
					return true;
				}
			}
			return false;
		}
		public function addNewData(name:String,data:Object,replace:Boolean = false):Boolean {
			var action:Boolean = true;
			var obj:Object = new Object();
			for (var c:String in this._arr) {
				if (this._arr[c].name == name) {
					//this._arr[c] = data;
					if(!replace){
						action = false;
						if(this._traceStatus) trace("this not new data:"+name);
						return action;
					}else {
						obj.name = name;
						obj.data = data;
						this._arr[c]=obj;
						action = true;
						if(this._traceStatus) trace("this replace old data:"+name);
						return action;
					}
				}
			}
			if (name != '') {
				obj.name = name;
				obj.data = data;
				this._arr.push(obj);
				
				action = true;
			}else {
				action = false;
			}
			return action;
		}
		public function issetData(name:String):Boolean {
			for (var c:String in this._arr) {
				if (this._arr[c].name == name) {
					return true;
				}
			}
			return false;
		}
		public function updateData(arr:*):Boolean {
			var action:Boolean = true;
			/*trace("update: " + (arr as Array) );
			if ((arr as Array) == null) {
				this._arr = new Array();
				return true;
			}*/
			
			for (var c:String in this._arr){
				if (arr[c].name == ''|| arr[c].name == undefined|| arr[c].name == null) {
					//this._arr[c] = data;
					action = false;
					if(this._traceStatus) trace("not good data array");
					return action;
				}
			}
			if (action) {
				this._arr = new Array();
				this._arr = arr;
				return action;
			}else {
				return action;
			}
		}
		public function traceDB():void {
			trace(this.DBStrings(63,"_"));
			trace("| Num:" + this.DBStrings(0) + "| Name:" + this.DBStrings(16) + "| Data:" + this.DBStrings(26) + "|");
			trace("|"+this.DBStrings(61,"-")+"|");
			var numNum:uint=0;
			var numName:uint=0;
			var numData:uint=0;
			for (var c:String in this._arr) {
				numNum = 4 - c.length; //trace((4-c.toString().length)+"_"+numNum);
				numName = 16+5 - this._arr[c].name.toString().length;
				numData = 26 + 5 - this._arr[c].data.toString().length;
				if (this._arr[c].data.toString().length > 26) {
					trace("| "+c+this.DBStrings(numNum)+"| "+this._arr[c].name+this.DBStrings(numName)+"| "+"very long data"+this.DBStrings(12+5)+"| ");
				}else{
					trace("| " + c + this.DBStrings(numNum) + "| " + this._arr[c].name + this.DBStrings(numName) + "| " + this._arr[c].data + this.DBStrings(numData) + "| ");
				}
			}
			trace("|"+this.DBStrings(61,"_")+"|");
			
		}
		public function getDataByType(name:String,type:String="type"):Array {
			var arr:Array = this.data;
			var needArr:Array = new Array();
			for (var c:String in arr) {
				//trace((this.data[c].data as Number));
				if ("data" in this.data[c])
				if (type in this.data[c].data)
				if (this.data[c].data[type] == name){
					needArr.push(this.data[c]);
					//trace("data=" + this.data[c].data.type);
				}
				/*if ((this.data[c].data as String) == null) {
					if((this.data[c].data as DisplayObject)==null)
					if(isNaN(this.data[c].data))
					if(this.data[c].data.type==name)
					needArr.push(this.data[c]);
					//trace("data=" + this.data[c].data.type);
				}*/
				//trace("data="+this.data[c].data.type);
			}
			return needArr;
		}
		public function DBStrings(n:uint,letter:String=" "):String {
			var str:String = "";
			//trace("="+n);
			for (var i:uint = 0; i < n; i++) {
				str += letter;
			}
			return str;
		}
		private function set traceStatus(val:Boolean):void {	this._traceStatus = val;}
		private function get traceStatus():Boolean { return this._traceStatus; }
		
	}

}