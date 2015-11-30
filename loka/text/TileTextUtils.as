package loka.text
{
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;

	public class TileTextUtils
	{
		public function TileTextUtils()
		{
		}
		public static function setTitleDefautStyle(tf:TextField):TextField{
			tf.autoSize = TextFieldAutoSize.NONE;
//			tf.border = true;
			tf.width = 103;
			tf.height = 20;
			tf.x = -1.5;
			tf.y = -26;
			tf.wordWrap = true;
			tf.multiline = true;
			TextUtils.changeLeading(tf, -3);
			return tf;
		}
	}
}