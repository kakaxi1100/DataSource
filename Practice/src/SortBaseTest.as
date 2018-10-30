package
{
	import flash.display.Sprite;
	/**
	 *基础排序 
	 * 
	 * 排序的稳定性：
	 * 如果待排序的序列中存在值相等的元素，经过排序之后，相等元素之间原有的先后顺序不变, 则说明这排序算法是稳定的
	 * 否则这个排序算法就是不稳定的
	 * 例：
	 * 2,9,3,4,8,3
	 * 如果排序之后,第一个3仍然再第二个3之前,那么说明这个排序算法是稳定的
	 * 
	 * 原地排序:
	 * 即不增加额外的空间存储
	 * 
	 * 冒泡
	 * 
	 * 插入
	 * 
	 * 选择
	 * 
	 * @author juli
	 * 
	 */	
	public class SortBaseTest extends Sprite
	{
		public function SortBaseTest()
		{
			super();
//			var a:Array = [1,5,8,6,3,7,2,10,4,9];
			var a:Array = [1,9,8,7,6,5,4,3,2,10];
			//			BubbleSort(a);
			//			InsertionSort(a);
			trace(a);
			SelectionSort(a);
			trace(a);
		}
		
		/**
		 * 冒泡排序是相邻的两个数据两两交换，直到有序
		 * [6,8,5,1] -> [6,5,1,8] ->[5,1,6,8]->[1,5,6,8]
		 * 至少要循环 数组的长度-1 次才能满足最后得到的数组有序
		 * 
		 * 它是原地排序 所以空间复杂度是1
		 * 时间复杂度为 O(n²)
		 * @param source
		 * 
		 */		
		public function BubbleSort(source:Array):void
		{
			if(!source || source.length <= 1) return;
			var i:int = 0, j:int = 0;
			for( i = 0; i < source.length; i++)
			{
				for(j = 0; j < source.length - i - 1; j++)//每一次排序过后最后一个都是有序的所以没必要再去判断顺序了
				{
					if(source[j] > source[j + 1])
					{
						var temp:int = source[j];
						source[j] = source[j + 1];
						source[j + 1] = temp;
					}
				}
			}
		}
		
		/**
		 * 
		 * 插入排序
		 * 就像玩家打扑克接牌一样, 每次接到的牌与玩家手中的牌做对比
		 * 找到要插入的位置,移动之后的牌挪出这个位置然后再执行插入
		 * 
		 * [10,5,8,6,3] -> [5,10,8,6,3] -> [5,8,10,6,3] -> [5,6,8,10,3] -> [3,5,6,8,10]
		 * 
		 * 它是原地排序 所以空间复杂度是1
		 * 时间复杂度为 O(n²)
		 * @param source
		 * 
		 */		
		public function InsertionSort(source:Array):void
		{
			if(!source || source.length <= 1) return;
			var i:int = 0, j:int = 0;
			var value:int;
			for(i = 1; i < source.length; i++)
			{
				value = source[i];
				for(j = i - 1; j >= 0; j--)//这里用 -- 是为了方便移动, 如果采用++需要做很多额外操作
				{
					if(source[j] > value)
					{
						source[j + 1] = source[j];//移动位置
					}else
					{
						break;
					}
				}	
				source[j + 1] = value;
			}
		}
		
		/**
		 * 选择排序
		 * 选择排序每次会从未排序区间中找到最小的元素，将其放到已排序区间的末尾
		 * [5,4,3,2,1] -> [1,4,3,2,5] -> [1,2,3,4,5]
		 * 
		 * 
		 * 它是原地排序 所以空间复杂度是1
		 * 时间复杂度为 O(n²)
		 * @param source
		 * 
		 */		
		public function SelectionSort(source:Array):void
		{
			if(!source || source.length <= 1) return;
			var i:int = 0, j:int = 0;
			var mini:int;
			for(i = 0; i < source.length - 1; i++) //只需要遍历九次
			{
				mini = i;
				//找到未排序数组中的最小值
				for( j = i; j < source.length; j++)
				{
					if(source[j] < source[mini])
					{
						mini = j;
					}
				}
				//交换
				var temp:int = source[i];
				source[i] = source[mini];
				source[mini] = temp;
			}
		}
	}
}