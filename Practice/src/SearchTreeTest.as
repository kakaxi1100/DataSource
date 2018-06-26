package
{
	import flash.display.Sprite;
	
	[SWF(width="800", height="600", frameRate="60", backgroundColor="0")]
	public class SearchTreeTest extends Sprite
	{
		private var test:Array = [10,40,60,30,90,50,70,20,100,80];
		public function SearchTreeTest()
		{
			super();
			var i:int;
			var tree:Tree = new Tree();
			for(i = 0; i < test.length; i++)
			{
				tree.insert(test[i]);
			}
			
			trace(tree);
		}
	}
}

class Tree
{
	public var treeRoot:Node;
	public function Tree()
	{
		
	}
	
	public function insert(data:int):void
	{
		var currentNode:Node = null;
		if(treeRoot == null)
		{
			treeRoot = new Node(data);
			return;
		}else{
			currentNode = treeRoot;
		}

		while(currentNode != null)
		{
			if(currentNode.data > data)
			{
				if(currentNode.left == null)
				{
					currentNode.left = new Node(data);
					currentNode = null;
				}else{
					currentNode = currentNode.left;
				}
			}else{
				if(currentNode.right == null)
				{
					currentNode.right = new Node(data);
					currentNode = null;
				}else{
					currentNode = currentNode.right;
				}
			}
		}
	}
}

class Node
{
	public var data:int;
	public var left:Node;
	public var right:Node;
	public function Node(d:int)
	{
		data = d;	
	}
}