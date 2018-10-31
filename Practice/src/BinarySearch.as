package
{
	import flash.display.Sprite;
	/**
	 *二分查找法 
	 * 
	 * @author juli
	 * 
	 */	
	public class BinarySearch extends Sprite
	{
		public function BinarySearch()
		{
			super();
			
			var a:Number = SquareRoot(121);
			trace("last number is:", a);
			var b:int = BinaryInt(121, 0, 121);
			trace("last number is:", b);
		}
		
		public function SquareRoot(num:Number):Number
		{
			var factor:int = 1;
			var temp:Number = num;
			if(num < 0)
			{
				factor = -1;
				temp = -num;
			}
			
			temp = BinaryNum(num, 0, num) * factor;
			
			return temp;
		}
		
		//要先算整数如果整数不行再算小数
		public function BinaryInt(target:int, low:int, high:int):int
		{
			
			if(low * low == target) return low;
			if(high * high == target) return high;
			if(low == high - 1) return -1;
			var mid:int = Math.floor((low + high) / 2);
			var mid2:Number = mid * mid;
			
			if(mid2 > target)
			{
				return BinaryInt(target, low, mid);
			}else if(mid2 < target)
			{
				return BinaryInt(target, mid, high);
			}else
			{
				return mid;
			}
		}
		
		public function BinaryNum(target:Number, low:Number, high:Number):Number
		{
			var doubleValue:Number = low * low;
			if(target - doubleValue <= 0.000001 && target - doubleValue >= 0)
			{
				return low;
			}
			doubleValue = high * high;
			if(target - doubleValue <= 0.000001 && target - doubleValue >= 0)
			{
				return doubleValue;
			}
			var mid:Number = (low + high) / 2;

			doubleValue = mid * mid;
			if(target - doubleValue <= 0.000001 && target - doubleValue >= 0)
			{
				return mid;
			}
			if(doubleValue > target)
			{
				return BinaryNum(target, low, mid);
			}else if(doubleValue < target)
			{
				return BinaryNum(target, mid, high);
			}else
			{
				return mid;
			}
		}
	}
}