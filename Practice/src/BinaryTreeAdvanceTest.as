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
	 * 5. 查找有序循环数组中与给定值相同的元素
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
			trace(findGreatEqualValueInArray(a, 10));
			trace(findLessEqualValueInArray(a, 0));
			
			var b:Array = [3,4,5,6,1,2];
			trace(fintTheSameInCycleOrderArray(b, 5));
		}
		
		
		//5. 查找有序循环数组中与给定值相同的元素
		// 如 [3,4,5,6,1,2] 找出数字4，或者找出数字 2
		//这里没有考虑重复数字,不过原理是一样的
		public function fintTheSameInCycleOrderArray(s:Array, value:int):int
		{
			var low:int = 0;
			var high:int = s.length - 1;
			var mid:int;
			
			var offset:int;
			var realMid:int;
			
			for(var i:int = s.length - 1; i > 0; --i)
			{
				if(s[i] < s[i - 1])
				{
					offset = i;
					break;
				}
			}
				
			while(low <= high)
			{
				mid = Math.floor((low + high) / 2);
				//这里的mid有讲究了,这个才是真正数组中要取得数值的下标
				realMid = mid + offset >= s.length ? mid + offset - s.length : mid + offset;
				if(s[realMid] < value)
				{
					low = mid + 1;
				}else if(s[realMid] > value)
				{
					high = mid - 1;
				}else
				{
					return realMid;
				}
			}
			
			return -1;
		}
		
		//4. 查找最后一个小于等于给定值的元素
		//这个可以参考大于等于的做法
		public function findLessEqualValueInArray(s:Array, value:int):int
		{
			var low:int = 0;
			var high:int = s.length - 1;
			var mid:int;
			var min:int = -1;
			
			while(low <= high)
			{
				mid = Math.floor((low + high) / 2);
				if(s[mid] < value)//在大区里面找
				{
					min = mid;
					low = mid + 1;
					//high不变
				}else if(s[mid] > value)//在小区里面找
				{
					high = mid - 1; //因为我要找的就是比它大的值,所以不用 -1
					//low 不变
				}else
				{
					//假如找到等同的值
					if(mid == s.length - 1 || s[mid + 1] != value)
					{
						return mid;
					}else//如果它之前还有相同的值
					{
						low = mid + 1;
					}
				}
			}
			
			return min;
		}
		
		//3. 查找第一个大于等于给定值的元素
		//只要low值每次检查的时候 +1, 而high值每次检查的时候与mid位置相等
		//知道 low = high的时候结束判断即可
		public function findGreatEqualValueInArray(s:Array, value:Number):int
		{
			var low:int = 0;
			var high:int = s.length - 1;
			var mid:int;
			var max:int = -1;
			
			while(low <= high)
			{
				mid = Math.floor((low + high) / 2);
				if(s[mid] < value)//在大区里面找
				{
					low = mid + 1;
					//high不变
				}else if(s[mid] > value)//在小区里面找
				{
					max = mid;
					high = mid - 1; //因为我要找的就是比它大的值,所以不用 -1
					//low 不变
				}else
				{
					//假如找到等同的值
					if(mid == 0 || s[mid - 1] != value)
					{
						return mid;
					}else//如果它之前还有相同的值
					{
						high = mid - 1;
					}
				}
			}
			
			return max;
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