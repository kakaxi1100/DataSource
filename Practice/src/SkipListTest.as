package
{
	import flash.display.Sprite;
	
	public class SkipListTest extends Sprite
	{
		private var mMaxLayer:uint = 4;
		private var mSkipRoot:Vector.<SkipNode> = new Vector.<SkipNode>(4);
		private var nodeHead:Node = new Node();
		public function SkipListTest()
		{
			super();
			init();			
			
			var a:Array = [10,30,20,50,40];
			for(var i:int = 0; i < a.length; i++)
			{
				this.insert(a[i]);
			}
			print();
			
		}
		
		private function init():void
		{
			//初始化头结点
			for(var i:int = 0; i < mMaxLayer; i++)
			{
				mSkipRoot[i] = new SkipNode();
				mSkipRoot[i].data = nodeHead;
				if(i > 0)
				{
					mSkipRoot[i].down = mSkipRoot[i - 1];
				}
			}
		}
		
		public function search(value:int):SkipNode
		{
			var prev:Vector.<SkipNode> = new Vector.<SkipNode>(4);//上一个节点
			var cur:Vector.<SkipNode> = new Vector.<SkipNode>(4);//当前查找的节点
			var i:int;
			for(i = 0; i < mMaxLayer; i++)
			{
				prev[i] = mSkipRoot[i];
				cur[i] = prev[i].next;
			}
			i = mMaxLayer - 1;
			do
			{
				
				if(cur[i] == null)
				{
					i--;
				}else
				{
					if(cur[i].data.data > value)//在下层查找
					{
						i--;
						if(i >=0 )
						{
							prev[i] =prev[i + 1].down;
							cur[i] = prev[i].next;
						}
					}else if(cur[i].data.data < value)//继续在本层查找
					{
						prev[i] = cur[i];
						cur[i] = prev[i].next;
						
					}else//不保存相同值
					{
						return cur[i];
					}
				}
				
			}while( i >= 0);
				
			return null;
		}
		
		public function insert(value:int):void
		{
			var prev:Vector.<SkipNode> = new Vector.<SkipNode>(4);//上一个节点
			var cur:Vector.<SkipNode> = new Vector.<SkipNode>(4);//当前查找的节点
			var newNode:Node;
			var newSkipNode:SkipNode;
			var i:int;
			for(i = 0; i < mMaxLayer; i++)
			{
				prev[i] = mSkipRoot[i];
				cur[i] = prev[i].next;
			}
			i = mMaxLayer - 1;
			do
			{

				if(cur[i] == null)
				{
					i--;
				}else
				{
					if(cur[i].data.data > value)//在下层查找
					{
						i--;
						if(i >=0 )
						{
							prev[i] =prev[i + 1].down;
							cur[i] = prev[i].next;
						}
					}else if(cur[i].data.data < value)//继续在本层查找
					{
						prev[i] = cur[i];
						cur[i] = prev[i].next;
						
					}else//不保存相同值
					{
						return;
					}
				}
				
			}while( i >= 0)
			
			newNode = new Node();
			newNode.data = value;
			
			//看要插入几层
			var layer:uint = randomLayer();
			//对每一层进行插入
			for(var j:int = 0; j <= layer; j++)
			{
				newSkipNode = new SkipNode();
				newSkipNode.data = newNode;
				newSkipNode.next = prev[j].next;
 				prev[j].next = newSkipNode;
				if(j > 0)
				{
					newSkipNode.down = prev[j - 1].next;
				}
			}
		}
		
		public function remove(value:int):void
		{
			//remove 其实很简单了 因为 search 可以做到同时返回值与值的前驱
		}
		
		private function randomLayer():uint
		{
			return Math.floor(Math.random() * 4);
		}
		
		public function print():void
		{
			for(var i:int = mSkipRoot.length - 1; i >= 0 ; --i)
			{
				var s:String = "";
				s += "第" + i + "行: ";
				var cur:SkipNode = mSkipRoot[i];
				while(cur != null)
				{
					s += cur.toString() + ", ";
					cur = cur.next;
				}
				trace(s);
			}
		}
	}
}

class SkipNode
{
	public var data:Node;//引用的那个Node
	public var next:SkipNode;//下一个Node
	public var down:SkipNode;//下一级指向的Node
	
	public function toString():String
	{
		return data.toString();
	}
}

class Node
{
	public var data:int;
	public var next:Node;
	public function Node()
	{
		
	}
	
	public function toString():String
	{
		return data.toString();
	}
}