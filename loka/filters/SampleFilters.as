package utils.loka.filters {
	import flash.filters.ConvolutionFilter;
	public class SampleFilters	{
		
		public function SampleFilters(){
			
		}
		public static function DarkedFilter(n:Number):Array {
			return [new ConvolutionFilter(1, 1, 
															 [1, 1, 1
															, 1, 1, 1
															, 1, 1, 1
															], n)];
		}
		
	}
	
}