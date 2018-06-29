package
{
	import flash.display.Sprite;
	/**
	 *平衡二叉树
	 * 
	 * 要会平衡二叉树的算法主要要理解 左旋和右旋
	 * 不管是左旋还是右旋 都满足 旋转之后树的 中序遍历不变
	 * 
	 * 还要注意每次增加和删除节点的时候, 都要重新计算它父节点的高度
	 * 它父节点的高度=子节点的高度+1
	 * 
	 * 我们这里假设:
	 * 空树的高度为 -1//我这里可能并不记录树的高度
	 * 叶子节点的高度为0
	 *  
	 * 下面先来分析下不平衡发生的四种情况：
	 * 
	 * 1、An insertion into the left subtree of the left child of A; （LL）
	 * 
	 * 2、An insertion into the right subtree of the left child of A;（RL）
	 * 
	 * 3、An insertion into the left subtree of the right child of A;（LR）
	 * 
	 * 4、An insertion into the right subtree of the right  child of A;（RR）
	 * 
	 * 
	 * 旋转方法：
	 * 
	 * 1、A 和 A's child 顺时针旋转 singlerotateLL() //右旋
	 * 
	 * 4、A 和 A's child 逆时针旋转 singlerotateRR() //左旋
	 * 
	 * 2、A's child 和 A's grandchild 逆时针旋转，A 和 A's new child 顺时针旋转  doublerotateRL()
	 * 
	 * 3、A's child 和 A's grandchild 顺时针旋转，A 和 A's new child 逆时针旋转 doublerotateLR()
	 * 
	 * https://blog.csdn.net/lemon_tree12138/article/details/50393548
	 * 
	 * @author juli
	 * 
	 */	
	[SWF(width="800", height="600", frameRate="60", backgroundColor="0")]
	public class AVLTreeTest extends Sprite
	{
		private var test:Array = [10,40,60,30,90,50,70,20,100,80];
		public function AVLTreeTest()
		{
			super();
			var i:int;
			var tree:Tree = new Tree();
			for(i = 0; i < test.length; i++)
			{
				tree.insert(test[i]);
			}
			
			trace(tree);
			tree.updateTreeHeight();
		}
	}
}

class Tree
{
	public var treeRoot:Node;
	public function Tree()
	{
		
	}
	
	public function traverseAfter(node:Node):void
	{
		if(node == null)
		{
			return;
		}
		traverseAfter(node.left);
		traverseAfter(node.right);
		trace(node);
	}
	
	public function traverseMid(node:Node):void
	{
		if(node == null)
		{
			return;
		}
		traverseMid(node.left);
		trace(node);
		traverseMid(node.right);
	}
	
	public function traverseBefore(node:Node):void
	{
		if(node == null)
		{
			return;
		}
		trace(node);
		traverseBefore(node.left);
		traverseBefore(node.right);
	}
	
	public function setNodeHeightToZero(node:Node):void
	{
		if(node == null)
		{
			return;
		}
		setNodeHeightToZero(node.left);
		setNodeHeightToZero(node.right);
		node.height = 0;
	}
	
	public function resetNodeHeight(node:Node):void
	{
		//这里用了后序遍历, 因为后续遍历一定是先从叶子节点开始的
		if(node == null) return;
		resetNodeHeight(node.left);
		resetNodeHeight(node.right);
		while(node.parent != null)
		{
			var currentHeight:int = node.height + 1;
			if(node.parent.height < currentHeight)
			{
				node.parent.height = currentHeight;
			}
			node = node.parent;
		}
	}
	
	public function updateTreeHeight():void
	{
		setNodeHeightToZero(treeRoot);
		resetNodeHeight(treeRoot);
	}
	
	public function updateHeight(node:Node):void
	{
		var currentNode:Node = node;
		
		while(currentNode != null)
		{
			if(currentNode.parent != null)
			{
				currentNode.parent.height = currentNode.height+1;				
			}
			currentNode = currentNode.parent;
		}
	}
	
	public function leftRotate(node:Node):void
	{
		//左旋
		var tempRightLeft:Node = node.left.right;
		//1.当前节点的右节点的左节点变成当前节点
		node.right.left = node;
		node.right.left.parent = node.parent;
		node.parent = node.right;
		//2.把之前右节点的左子树复制给当前节点的右节点
		node.right = tempRightLeft;
	}
	
	public function rightRotate(node:Node):void
	{
		//右旋
		var tempLeftRight:Node = node.left.right;
		//1.把当前节点变成其左节点的右节点
		node.left.right = node;
		node.left.right.parent = node.parent;
		node.parent = node.left;
		//2.把之前节点左节点的右子树赋值给他的左节点
		node.left = tempLeftRight;
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
					currentNode.left.parent = currentNode;
					updateHeight(currentNode.left);
					currentNode = null;
				}else{
					currentNode = currentNode.left;
				}
			}else{
				if(currentNode.right == null)
				{
					currentNode.right = new Node(data);
					currentNode.right.parent = currentNode;
					updateHeight(currentNode.right);
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
	public var parent:Node;
	public var height:int;
	public function Node(d:int)
	{
		data = d;	
	}
	
	//计算平衡因子
	public function balanceFactor():void
	{
		
	}
	
	public　function toString():String
	{
		return "Data: " + data;
	}
}