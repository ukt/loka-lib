package loka.dataBase {
	import flash.events.Event;
	
	import loka.console.Console;
	import loka.loaders.*;
	
	/**
	 * ...
	 * @author loka
	 */
	public class XmlDBReader extends Data	{
		private var _prefix:String = "";
		private var _parent:String = "";
		private var _parentStatus:Boolean= false;
		private var _readStatus:Boolean= true;
		private var _xml:XML;
		private var _link:String;
		private var _XmlLoader:TxtLoader;
		public static const XML_CREATE:String = "XML_CREATE";
		public function XmlDBReader(link:String, base:Array) {
			this._link = link;
			//this._xml = new XML(xml);
			//this._xml.ignoreWhitespace = true;
			this.updateData(base);
			//this.createData();
		}
		public function load(local:Boolean = true):void {
			if(this._parentStatus){
				this._XmlLoader = new TxtLoader(this._link);
				this._XmlLoader.addEventListener(LoaderConstans.LOAD_TXT_COMPLETED, read);
				this._XmlLoader.Load(local);
				Console.instance.write("Load: "+local);
			}else {
				Console.instance.write("ERROR: xmlParent don't set? Plese set a name parent link search");
				trace("ERROR: xmlParent don't set? Plese set a name parent link search");
			}
			//trace("link="+this._link);
		}
		
		private function read(e:Event):void {
			this._xml = new XML(this._XmlLoader.txt);
			//trace("\n\n\n"+this._xml )
			//trace("\n\n\nXML:\n"+this._xml[this._parent] )
			//trace("\n\n\nXML_:\n"+this._xml["photoset"]["photo"] )
			this._xml.ignoreWhitespace = true;
			if (this._parent != ""&&this._readStatus) {
				for each(var i:XML in this._xml[this._parent] ) {
					var xml:XMLList = i.@ * ;
					var obj:Object = new Object();
					for (var j:int = 0; j < xml.length(); j++) {
						obj[""+xml[j].name()] = xml[j];
					}
					obj.child = i;
					this.addNewData(this._prefix+i.attribute("name").toString(), obj);
				}
				this.dispatchEvent(new Event(XmlDBReader.XML_CREATE, true));
			}
		}
		/**
		 * prefix - is a parammetr to name, thay has attach to start name this prefix
		 * if prefix="xml" then nameObj=prefix+nameObj;
		 */
		public function set prefix(val:String):void {
			this._prefix = val;
		}
		public function set xmlread(val:Boolean):void { this._readStatus = val; }
		public function set xmlParent(val:String):void {
			this._parentStatus = true;
			this._parent = val;
		}
		public static function readXml(xmlData:String, parent:String, prefix:String = ""):Data {
			var xmls:XMLList = new XMLList(xmlData);
			//trace(xmls);
			//xmls.ignoreWhitespace = true;
			var DB:Data = new Data(); 
			DB.init();
			if (parent != "") {
				for each(var i:XML in xmls[parent] ) {
					var xmlList:XMLList = i.@ * ;
					var obj:Object = new Object();
					for (var j:int = 0; j < xmlList.length(); j++) {
						obj[""+xmlList[j].name()] = xmlList[j];
					}
					obj.child = i;
					DB.addNewData(prefix+i.attribute("name").toString(), obj);
				}
				//this.dispatchEvent(new Event(XmlDBReader.XML_CREATE, true));
			}
			return DB;
		}
		
	}

}