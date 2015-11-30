package loka.gi{
	import flash.display.GradientType;
	import flash.display.SpreadMethod;
	import flash.geom.Matrix;

	/**
	 * ...
	 * @author loka
	 */

	public class GradientObject {
		
		public var fillType:String;
		public var colors:Array;
		public var alphas:Array;
		public var ratios:Array;
		public var matr:Matrix;
		public var spreadMethod:String;
		
		public function GradientObject() {
			this.fillType = GradientType.LINEAR;
			this.colors = [0xEDEFED, 0x9A9A9A];
			this.alphas = [1.0, 1.0];
			this.ratios = [0x00, 0xFF];
			this.matr = new Matrix();
			matr.createGradientBox(150, 150, Math.PI/2, 0, 0);
			this.spreadMethod = SpreadMethod.PAD;
		}
		
	}
}