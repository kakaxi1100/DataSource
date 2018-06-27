/**
 *二叉搜索树
 * 
 * 删除的时候,分为三种情况
 * 第一：删除的节点没有孩子节点, 则直接删除
 * 第二：删除的节点只有一个孩子节点, 则将孩子节点指给它的父节点即可
 * 第三：删除的节点有两个孩子节点, 则先找到它右子树的最小节点然后与其替换(注意右子树的最小节点必然只有一个孩子或则没有孩子),然后再进行第一或第二种情况的删除
 */
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
			
			tree.remove(60);
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
	
	public function remove(data:int):Boolean
	{
		var boo:Boolean = false;
		var tempNode:Node = search(data);
		if(tempNode != null)
		{
			boo = true;
		}
		//假如没有孩子
		if((tempNode.left || tempNode.right) == null)
		{
			this.removeNoneChildNode(tempNode);
		}else if((tempNode.left != null && tempNode.right == null) || (tempNode.left == null && tempNode.right != null))//只有一个的情况
		{
			this.removeOneChildNode(tempNode);
		}else if((tempNode.left && tempNode.right) != null){
			//先找到右子树的最小点
			var leftMost:Node = this.findMostLeft(tempNode.right);
			//然后交换它与当前点的值
			var temp:int = leftMost.data;
			leftMost.data = tempNode.data;
			tempNode.data = temp;
			//leftMost现在变成了要删除的点,把temp变成leftmost
			tempNode = leftMost;
			//删除leftMost
			if((tempNode.left || tempNode.right) == null)
			{
				this.removeNoneChildNode(tempNode);
			}else{
				this.removeOneChildNode(tempNode);
			}
		}
		
		return boo;
	}
	
	public function removeNoneChildNode(node:Node):void
	{
		node.np.left = node.np.right = null;
		node.np = null;
	}
	
	public function removeOneChildNode(node:Node):void
	{
		if(node == node.np.left)//假如是左孩子
		{
			if(node.left != null)
			{
				node.left.np = node.np.left;
				node.np.left = node.left;
			}else if(node.right != null)
			{
				node.right.np = node.np.left;
				node.np.left = node.right;
			}
		}else if(node == node.np.right){//假如是右孩子
			if(node.left != null)
			{
				node.left.np = node.np.right;
				node.np.right = node.left;
			}else if(node.right != null)
			{
				node.right.np = node.np.right;
				node.np.right = node.right;
			}
		}
	}
	
	public function search(data:int):Node
	{
		var currentNode:Node = this.treeRoot;
		while(currentNode != null)
		{
			if(data < currentNode.data)
			{
				currentNode = currentNode.left;
			}else if(data > currentNode.data)
			{
				currentNode = currentNode.right;
			}else{
				//否则data相等的话,那么这个节点就是要取得的节点
				break;
			}
		}
		
		return currentNode;
	}
	
	public function findMostLeft(first:Node):Node
	{
		var currentNode:Node = first;
		var tempNode:Node = null;
		while(currentNode != null)
		{
			tempNode = currentNode;
			currentNode = currentNode.left;
		}
		return tempNode;	
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
					currentNode.left.np = currentNode;
					currentNode = null;
				}else{
					currentNode = currentNode.left;
				}
			}else{
				if(currentNode.right == null)
				{
					currentNode.right = new Node(data);
					currentNode.right.np = currentNode;
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
	public var np:Node;//node parent
	public function Node(d:int)
	{
		data = d;	
	}
	
	public　function toString():String
	{
		return "Data: " + data;
	}
}