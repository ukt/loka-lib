package utils.loka.ui.text{
	
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import utils.loka.GlobalConst;

	/**
	 * ...
	 * @author AeroHills
	 */

	public class GlobalTextFormat 
	{
		private var fontStandartName:String;// = GlobalConst.STANDART_FONT_NAME;
		private static var _instance:GlobalTextFormat;  
			public static function Instance():GlobalTextFormat
			{
				if (_instance == null) _instance = new GlobalTextFormat();
				return _instance;
			}
		/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
		private var _recordsTableVictory:TextFormat;
		private var _recordsTableLineFormat:TextFormat;
		private var _recordsTableHeaderFormat:TextFormat;
		
		public function RecordsTableLineFormat():TextFormat {return this._recordsTableLineFormat;}
		public function RecordsTableHeaderFormat():TextFormat {return this._recordsTableHeaderFormat;}
		public function RecordsTableVictoryt():TextFormat { return this._recordsTableVictory; }
		
		/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
		private var _userBoxPlaceFormat:TextFormat;
		private var _userBoxPointFormat:TextFormat;
		private var _userBoxNameFormat:TextFormat;
		
		public function UserBoxPlaceFormat():TextFormat { return this._userBoxPlaceFormat; }
		public function UserBoxPointFormat():TextFormat { return this._userBoxPointFormat; }
		public function UserBoxNameFormat():TextFormat { return this._userBoxNameFormat; }
		
		/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
		private var _tabButtonNameFormat:TextFormat;
		public function TabButtonNameFormat():TextFormat { return this._tabButtonNameFormat; }
		
		/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
		private var _btnStandartLabel:TextFormat;
		public function BtnStandartLabel():TextFormat { return this._btnStandartLabel; }
		
		/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
		private var _currencyLabel:TextFormat;
		public function CurrencyLabel():TextFormat { return this._currencyLabel; }
		
		/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
		private var _standartVeryLittleLabel:TextFormat;
		private var _standartLittleLabel:TextFormat;
		//private var _standartLabel:TextFormat;
		private var _standartBigLabel:TextFormat;
		public static var VERY_LITTLE_LABEL:uint = 0;
		public static var LITTLE_LABEL:uint = 1;
		public static var LABEL:uint = 2;
		public static var BIG_LABEL:uint = 3;
		public function StandartVeryLittleLabel():TextFormat { return this._standartVeryLittleLabel; }
		public function StandartLittleLabel():TextFormat { return this._standartLittleLabel; }
		public function StandartLabel():TextFormat { return new TextFormat(fontStandartName, 24, 0xb273e0b, false, true, false, null, null, TextFormatAlign.CENTER); }
		public function StandartBigLabel():TextFormat { return this._standartBigLabel; }
		
		/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
		private var _gameButtonLabel:TextFormat;
		public function GameButtonLabel():TextFormat { return this._gameButtonLabel; }
		
		public function GlobalTextFormat() {
			this.fontStandartName = GlobalConst.STANDART_FONT_NAME;//Vectora CricketLight
			//this.fontStandartName = "JOKERMAN";
			_recordsTableVictory = new TextFormat(fontStandartName, 36, 0xeb9f3e, false, true, false, null, null, TextFormatAlign.CENTER);
			
			_recordsTableLineFormat = new TextFormat(fontStandartName, 20, 0x23322e, false, true, false, null, null, TextFormatAlign.CENTER);
			_recordsTableHeaderFormat = new TextFormat(fontStandartName, 24, 0x3a4b10, false, true, false, null, null, TextFormatAlign.CENTER);
			
			_userBoxPlaceFormat = new TextFormat(fontStandartName, 16, 0x2b1407, true, false, false, null, null, TextFormatAlign.CENTER);
			_userBoxPointFormat = new TextFormat(fontStandartName, 13, 0x2b1407, true, false, false, null, null, TextFormatAlign.CENTER);
			_userBoxNameFormat = new TextFormat(fontStandartName, 12, 0x000000, true, false, false, null, null, TextFormatAlign.RIGHT);
			//_userBoxTabFormat = new TextFormat(fontStandartName, 12, 0x2b1407, true, true, false, null, null, TextFormatAlign.CENTER);
			
			_tabButtonNameFormat = new TextFormat(fontStandartName, 24, 0x506816, false, true, false, null, null, TextFormatAlign.CENTER);
			
			_btnStandartLabel = new TextFormat(fontStandartName, 24, 0xb273e0b, false, true, false, null, null, TextFormatAlign.CENTER);
			_standartVeryLittleLabel = new TextFormat(fontStandartName, 12, 0xb273e0b, false, true, false, null, null, TextFormatAlign.CENTER);
			_standartLittleLabel = new TextFormat(fontStandartName, 18, 0xb273e0b, false, true, false, null, null, TextFormatAlign.CENTER);
			//_standartLabel = new TextFormat(fontStandartName, 24, 0xb273e0b, false, true, false, null, null, TextFormatAlign.CENTER);
			_standartBigLabel = new TextFormat(fontStandartName, 48, 0xb273e0b, false, true, false, null, null, TextFormatAlign.CENTER);
			
			_currencyLabel = new TextFormat(fontStandartName, 20, 0x3b0000, true, true, false, null, null, TextFormatAlign.CENTER);
			
			_gameButtonLabel = new TextFormat(fontStandartName, 24, 0xf2ffa2, true, true, false, null, null, TextFormatAlign.CENTER);
		}
	}
}