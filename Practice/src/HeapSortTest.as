package
{
	import flash.display.Sprite;
	/**
	 * 堆分为大顶堆和小顶堆
	 * 
	 * 它的本质是一颗完全二叉树, 并且（大顶堆）它的子树的每个节点都必须小于当前节点
	 * 
	 * 它的构建有两个过程 自底向上和自顶向下
	 * 
	 * ① 自顶向下就是一个插入节点的过程
	 * 
	 * ② 自底向上更优化交换的次数更少
	 * 它的实现过程是 从最后一个非叶子节点开始(因为叶子节点不需要与子节点发生交换), 与它的子树节点进行比较, 如果遇到比它小的节点就和此节点交换
	 * 完全二叉树 如何判断哪个是最后一个非叶子节点？
	 * 由于我们的完全二叉树是 通过数组表示的, 那么最后一个叶子节点的的数组下标是 n - 1, 那么它对应的父节点就是最后一个非叶子节点
	 * 如果它的下标是奇数那么它的父节点就是 (n-1)/2   如果是偶数那么它的父节点是就 (n-2)/2
	 * 父节点对应的子节点为 左子节点为 2n+1 , 右子节点为 2n+2
	 * 
	 *  
	 * @author juli
	 * 
	 */	
	public class HeapSortTest extends Sprite
	{
		public function HeapSortTest()
		{
			super();
			var arr:Array = [7,5,19,8,4,1,20,13,16];
			createDownToTop(arr);
			insert(14, arr);
			insert(15, arr);
			insert(38, arr);
			insert(26, arr);
			trace(arr);
			remove(20, arr);
			remove(8, arr);
			remove(38, arr);
			trace(arr);
		}
		
		//从下往上构建
		public function createDownToTop(list:Array):void
		{
			//最后一个子节点
			var total:int = list.length - 1;
			var lastIndex:int;
			if(total % 2 == 0)
			{
				lastIndex = (total - 2) / 2;
			}else
			{
				lastIndex = (total - 1) / 2;
			}
			
			for(var i:int = lastIndex; i >= 0; i--)
			{
				//当前节点
				var curtIndex:int = i;
				
				while(curtIndex >= 0)
				{
					var temp:int;
					var leftIndex:int = 2*curtIndex + 1;
					var rightIndex:int = 2*curtIndex + 2;
					var tempIndex:int = -1;
					//如果左边超出了范围, 那么右边肯定超出了范围, 所以只要检测左边范围就就可以了
					if(leftIndex < list.length)
					{
						if(rightIndex >= list.length || list[leftIndex] > list[rightIndex])//假如左边比右边大, 就跟左边交换
						{
							tempIndex = leftIndex;
						}else//否则就跟右边交换
						{
							tempIndex = rightIndex;		
						}
					}
					
					if(tempIndex != -1)
					{
						if(list[curtIndex] < list[tempIndex])
						{
							temp = list[curtIndex];
							list[curtIndex] = list[tempIndex];
							list[tempIndex] = temp;
						}
					}
					
					curtIndex = tempIndex;
				}

			}
		}
		
		public function insert(node:int, heap:Array):void
		{
			//先添加到最后，然后再找父级,如果父级比它小就交换
			heap.push(node);
			var curtIndex:int = heap.length - 1;
			var parentIndex:int;
			var temp:int;
			var tempIndex:int;
			while(curtIndex >= 0)
			{
				tempIndex = -1;
				if(curtIndex % 2 == 0)
				{
					parentIndex = (curtIndex - 2) / 2;
				}else
				{
					parentIndex = (curtIndex - 1) / 2;
				}
				
				if(parentIndex >= 0){
					if(heap[curtIndex] > heap[parentIndex])//和父级交换
					{
						temp = heap[curtIndex];
						heap[curtIndex] = heap[parentIndex];
						heap[parentIndex] = temp;
						tempIndex = parentIndex;
					}
				}
				
				curtIndex = tempIndex;
			}
		}
		
		public function remove(node:int, arr:Array):void
		{
			var nodeIndex:int = -1;
			//先找到在数组中的哪个位置
			for(var i:int = 0; i < arr.length; i++)
			{
				if(arr[i] == node)
				{
					nodeIndex = i;
					break;
				}
			}
			
			if(nodeIndex == -1)
			{
				return;
			}
			//然后在把数组中最后一个元素与此元素交换, 删掉最后一个元素
			//然后在对交换的位置上的元素执行堆化,即与子节点交换直到停止
			
			var lastNode:int = arr.pop();
			arr[nodeIndex] = lastNode;
			
			while(nodeIndex >= 0)
			{
				var temp:int;
				var leftIndex:int = 2*nodeIndex + 1;
				var rightIndex:int = 2*nodeIndex + 2;
				var tempIndex:int = -1;
				//如果左边超出了范围, 那么右边肯定超出了范围, 所以只要检测左边范围就就可以了
				if(leftIndex < arr.length)
				{
					if(rightIndex >= arr.length || arr[leftIndex] > arr[rightIndex])//假如左边比右边大, 就跟左边交换
					{
						tempIndex = leftIndex;
					}else//否则就跟右边交换
					{
						tempIndex = rightIndex;		
					}
				}
				
				if(tempIndex != -1)
				{
					if(arr[nodeIndex] < arr[tempIndex])
					{
						temp = arr[nodeIndex];
						arr[nodeIndex] = arr[tempIndex];
						arr[tempIndex] = temp;
					}	
				}
				nodeIndex = tempIndex;
			}
			
		}
	}
}