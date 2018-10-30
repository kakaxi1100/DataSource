package
{
	import flash.display.Sprite;
	/**
	 *进阶排序
	 * 
	 * 归并排序
	 * 
	 * 快速排序
	 * 
	 *  
	 * @author juli
	 * 
	 */	
	public class SortAdvancedTest extends Sprite
	{
		public function SortAdvancedTest()
		{
			super();
			trace(12223);
			var a:Array;
			a = [1,2,3,4,5,6,7,8,9];
			a = [9,8,7,6,5,4,3,2,1];
			a = [1,5,8,6,3,7,2,10,4,9];
			trace(a);
//			a = MergeSort(a);
			QuickSort(a);
			trace(a);
			
		}
			
		/**
		 *
		 * 归并排序
		 * 用到的分治的思想
		 * 假如一个数组 前半部分和后半部分都是有序的, 那么它的排序时间复杂度是O(n)
		 * 那么有：
		 * A(m, n) = A(m, k) + A(k + 1, n)
		 * 当 m = k 时  说明数组只有一个数字那么它自然有序了 
		 * 同理n = k + 1 也是
		 * 所以我们只需要把数组 拆成 长度为一个 数组集，排序后再组合起来那么整个数组就有序了
		 * 那么剩下我们就要看看把数组 拆成 长度为一的数组集，需要的时间复杂度是多少
		 * 
		 * 假如数组长度 为 n, 我们每次 拆一半,最终得到 数组长度为1 
		 * 数学等式可以写为：
		 * n*(1/2)^x = 1 => 2^x = n => x = log(2)n (注意n是log的真数) => O(logn)
		 * 
		 * 所以整个算法的时间复杂度为： O(nlogn)
		 * 
		 *  
		 * @param s
		 * 
		 */		
		public function MergeSort(s:Array):Array
		{
			return Merge(s,0, s.length - 1);
		}
		private function Merge(s:Array, m:int, n:int):Array
		{
			var temp:Array = [];
			//假如相等,说明不能再分了就终止了
			if(m == n)
			{
				temp[0] = s[m];
				return temp;
			}
			var k:int = Math.floor((m + n) / 2);
			
			var t1:Array = Merge(s, m, k);
			var t2:Array = Merge(s, k + 1, n);
			//这里合并成一个
			var q:int = 0, p:int = 0;
			for(var i:int = 0; p <= k - m && q <= n - k - 1; i++)
			{
				if(t1[p] < t2[q])
				{
					temp[i] = t1[p];
					p++;
				}else
				{
					temp[i] = t2[q];
					q++;
				}
			}
			//把剩下的补齐
			while(p <= k-m)
			{
				temp[temp.length] = t1[p];
				p++;
			}
			
			while(q <= n - k - 1)
			{
				temp[temp.length] = t2[q];
				q++;
			}
			return temp;
		}
		
		/**
		 *快速排序
		 * 用到的分治的思想
		 * 假如一个数组 前半部分和后半部分都是有序的, 那么它的排序时间复杂度是O(n)
		 * 那么有：
		 * A(m, n) = A(m, k) + A(k + 1, n)
		 * 当 m = k 时  说明数组只有一个数字那么它自然有序了 
		 * 同理n = k + 1 也是
		 * 所以我们只需要把数组 拆成 长度为一个 数组集，排序后再组合起来那么整个数组就有序了
		 * 那么剩下我们就要看看把数组 拆成 长度为一的数组集，需要的时间复杂度是多少
		 * 
		 * 注意拆分的策略和归并排序不一样, 这里的拆分和选择的对比点有很大关系 
		 * 我们每次选择最后一个点
		 * 假如选择点能平分数组 那么时间复杂度就和归并排序一样 O(logn)
		 * 
		 * 假如数组是有序的 [1,2,3,4,5,6,7,8],
		 * 那么我们拆分的情况就是  
		 * [1,2,3,4,5,6,7,8] => [1,2,3,4,5,6,7] | 8 => [1,2,3,4,5,6] | 7,8 => ... => [] | 1,2,3,4,5,6,7,8
		 * 可以看出总共要进行n次拆分 所以时间复杂度是O(n)
		 * 
		 * 而如果输入是完全无序的[8,7,6,5,4,3,2,1]
		 * 那么我们的拆分情况是
		 * [1,2,3,4,5,6,7,8] => 1 | [2,3,4,5,6,7,8] => 1,2 | [3,4,5,6,7,8] => ... => 1,2,3,4,5,6,7,8 | []
		 * 也是O(n)
		 * 
		 * 所以可以看出,中心点的选择是很重要的,我们需要尽量选择可以平分数组的点
		 * 它最好的情况是 O(nlogn), 最差的情况是 O(n²)
		 * 
		 * @param s
		 * 
		 */		
		public function QuickSort(s:Array):void
		{
			Quick(s, 0, s.length - 1);
		}
		private function Quick(s:Array, m:int, n:int):void
		{
			//
			if(m >= n)
			{
				return;
			}
			//每次都选最后一个作为中心点
			var j:int = m;//已排序区域起始序号
			var value:int;
			//排序
			for(var i:int = m; i < n; i++)
			{
				if(s[i] < s[n])//假如元素比中心点的这个小, 则把它交换到已排序区域的最后一位
				{
					value = s[j];
					s[j] = s[i];
					s[i] = value;
					j++;
				}else//否则假如元素比它大,则不做任何交换
				{
					
				}
			}
			//排序完成之后把最后一个值,与已排序列表的最后一位交换
			value = s[j];
			s[j] = s[n];
			s[n] = value;
			trace(s);
			Quick(s, m, j - 1);
			Quick(s, j + 1, n);
		}
	}
}