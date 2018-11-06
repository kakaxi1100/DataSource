package
{
	import flash.display.Sprite;
	
	public class SkipListTest extends Sprite
	{
		private var mMaxLayer:uint = 4;
		private var mRoot:Vector.<Node> = new Vector.<Node>(4);
		public function SkipListTest()
		{
			super();
			init();
		}
		
		private function init():void
		{
			//初始化头结点
			for(var i:int = 0; i < mMaxLayer; i++)
			{
				mRoot[i] = new Node();
			}
		}
		
		public function search(value:int):void
		{
			
		}
		
		public function insert(value:int):void
		{
			var prev:Vector.<Node> = new Vector.<Node>(4);//上一个节点
			var cur:Vector.<Node> = new Vector.<Node>(4);//当前查找的节点
			var newNode:Node;
			//1.先从最上层开始找起
			for(var i:int = mMaxLayer - 1; i >= 0; --i)
			{
				prev[i] = mRoot[i];
				cur[i] = mRoot[i].next;
				if(cur[i] == null)//假如这一层的第一个节点就是空那么就直接从下一层开始找起
				{
					continue;
				}else
				{
					if(cur[i] > value)
					{
						
					}else if(cur[i] < value)//如果当前的节点必要查找的小,那么就要继续查找下一个区间
					{
						prev[i] = cur[i];
						cur[i] = cur[i].next;
					}else//如果元素相同则不要插入
					{
						return;
					}
				}
			}
			
			newNode = new Node();
			newNode.data = value;
			//看要插入几层
			var layer:uint = randomLayer();
			//对每一层进行插入
			for(var j:int = 0; j <= layer; j++)
			{
				newNode.next = prev[j].next;
				prev[j].next = newNode;
			}
		}
		
		public function remove():void
		{
			
		}
		
		private function randomLayer():uint
		{
			return Math.floor(Math.random() * 4);
		}
	}
}

class Node
{
	public var data:int;
	public var next:Node;
	public function Node()
	{
		
	}
}