package
{
	import flash.display.Sprite;
	/**
	 *二分查找的变体
	 * 
	 * 1. 查找第一个值等于给定值的元素
	 * 2. 查找最后一个值等于给定值的元素
	 * 3. 查找第一个大于等于给定值的元素
	 * 4. 查找最后一个小于等于给定值的元素
	 * 
	 *  
	 * @author juli
	 * 
	 */	
	public class BinaryTreeAdvanceTest extends Sprite
	{
		public function BinaryTreeAdvanceTest()
		{
			super();
			
			var a:Array = [1,4,4,5,7,7,8,8,8,9];
			trace(findLastValueInArray(a, 9));
		}
		
		public function findLessEqualValueInArray(s:Array, value:int):int
		{
			return -1;
		}
		
		public function findGreatEqualValueInArray(s:Array, value:int):int
		{
			return -1;
		}
		
		//2. 查找最后一个值等于给定值的元素
		public function findLastValueInArray(s:Array, value:int):int
		{
			var low:int = 0;
			var height:int = s.length - 1;
			var mid:int;
			
			while(low <= height)
			{
				mid = Math.floor((low + height) / 2);
				if(s[mid] < value)
				{
					low = mid + 1;
				}else if(s[mid] > value)
				{
					height = mid - 1;	
				}else
				{
					if(mid == s.length - 1 || s[mid + 1] != value)
					{
						return mid;
					}else
					{
						low = mid + 1;	
					}
				}
			}
			
			return -1;
		}
		
		//1. 查找第一个值等于给定值的元素
		public function findFirstValueInArray(s:Array, value:int):int
		{
			var low:int = 0;
			var height:int = s.length - 1;
			var mid:int;
			
			while(low <= height)
			{
				mid = Math.floor((low + height) / 2);
				if(s[mid] < value)
				{
					low = mid + 1;
				}else if(s[mid] > value)
				{
					height = mid - 1;	
				}else
				{
					if(mid == 0 || s[mid - 1] != value)
					{
						return mid;
					}else
					{
						height = mid - 1;	
					}
				}
			}
			
			return -1;
		}
		
//		public function findFirstValueInArray2(s:Array, value:int):int
//		{
//			var low:int = 0;
//			var height:int = s.length - 1;
//			var mid:int;
//			do{
//				mid = Math.floor((low + height) / 2);
//				//先看看low和height是不是
//				if(s[low] == value)
//				{
//					return low;
//				}else if(s[height] == value)//找到了第一个相等的值
//				{
//					if(s[height - 1] != value)
//					{
//						return height;						
//					}else
//					{
//						low = low + 1;
//						height = height - 1;
//					}
//				}else if(s[mid] < value)//在大区里面找
//				{
//					low = mid + 1;
//					//因为height已经计算过了,所以height - 1
//					height = height - 1;
//				}else if(s[mid] > value)//在小区里面找
//				{
//					//因为low已经找过了,所以low + 1
//					low = mid + 1;
//					height = mid - 1;
//				}else if(s[mid] == value)//找到了
//				{
//					if(s[mid - 1] != value)//假如它是第一个这个值
//					{
//						return mid;
//					}else
//					{
//						low = mid + 1;
//						height = mid - 1;
//					}
//				}
//				
//			}while(low < height)
//			
//			
//			return -1;
//		}

	}
}