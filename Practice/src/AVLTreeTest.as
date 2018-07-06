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
	 * 
	 * 需要找到最小不平衡子树
	 * https://www.cnblogs.com/zhujunxxxxx/p/3348798.html
	 * 
	 * 
	 * 平衡因子解析：
	 * 为什么同号就是单旋,异号就是双旋？
	 * 因为 假如 A节点的平衡因子=2 , 那么说明 A的左节点要高于右节点, 
	 * 如果 此时A的左孩子A1的平衡因子=1, 那么说明A1的左节点也要高于右节点,那么进行右旋
	 * 如果 此时A的左孩子A1的平衡因子=-1, 那么说明A1的右节点也要高于左节点,那么进行A1左旋再进行A的右旋
	 * 因为右节点是要变为A的左节点所以一定要保证这个左节点比A小,所以才要进行两次旋转
	 * 
	 * 比如 ⑦ ⑩ ⑨
	 * 
	 * ⑦ = -2 , ⑩ = 1 , ⑨ = 0
	 * 如果进行单旋 那么 ⑦会称为⑩的左节点 而⑨成为⑩的右节点, 这是错误的
	 * 必须保证绕着旋转的点 是一大一小
	 * 想想旋转马车
	 * 
	 * 比如使绕着 ⑨ 的点是一大一小, 除此之外其它的都不满足
	 *  
	 * 
	 * 删除分析
	 * https://blog.csdn.net/qifengzou/article/details/17362277
	 * 
	 * 一、
	 * 删除之前整棵树是平衡的
	 * 
	 * 删除一个节点可以看出：
	 * 1. 这个节点的子节点高度不变   
	 * 因为 删除有三种情况  
	 * ① 删除的是叶子节点, 那么它没有子节点,所以不变
	 * ② 删除的节点含有单个子节点, 因为子节点也是平衡树, 所以子节点的高度也不变
	 * ③ 删除的节点含有两个子节点, 根据删除算法, 实际情况和删除叶子节点是一样的
	 * 
	 * 2. 这个节点的父节点高度可能会变化
	 * 因为删除掉了一个节点, 所以高度可能变化
	 * 
	 * 二、
	 * 高度变化时我们就需要重平衡树
	 * 如何重平衡：
	 * 1. 首先找到 此节点父节点的最小平衡子树, 并记录删除节点前的高度
	 * 2. 删除节点,根据情况对此子树进行旋转处理, 旋转后此子树平衡,算一下这个子树的高度
	 * 3. 如果这个子树平衡后的高度和未删除节点前的高度不一致, 那么这个子树的父节点也有可能失衡, 那么再重复 1,2,3步骤 直至树整体平衡
	 * 
	 * 
	 * 
	 * @author juli
	 * 
	 */	
	[SWF(width="800", height="600", frameRate="60", backgroundColor="0")]
	public class AVLTreeTest extends Sprite
	{
		private var test:Array = [10,40,60,30,90,50,70,20,100,80];
		private var test1:Array = [3, 2, 1, 4, 5, 6, 7, 10, 9, 8];
		public function AVLTreeTest()
		{
			super();
			var i:int;
			var tree:Tree = new Tree();
			for(i = 0; i < test1.length; i++)
			{
				tree.insert(test1[i]);
			}
			
//			trace(tree);
//			tree.updateTreeHeight();
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
		treeRoot = node;
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
		if(node.parent)
		{
			if(node.parent.left == node)
			{
				node.parent.left = node.right;
			}else{
				node.parent.right = node.right;
			}
		}
		var tempRightLeft:Node;
		if(node.left != null)
		{
			tempRightLeft = node.right.left;
		}else{
			tempRightLeft = null;
		}
		//1.当前节点的右节点的左节点变成当前节点
		node.right.left = node;
		node.right.parent = node.parent;
		node.parent = node.right;
		//2.把之前右节点的左子树复制给当前节点的右节点
		node.right = tempRightLeft;
	}
	
	public function rightRotate(node:Node):void
	{
		//右旋
		if(node.parent)
		{
			if(node.parent.left == node)
			{
				node.parent.left = node.left;
			}else{
				node.parent.right = node.left;
			}
		}
		var tempLeftRight:Node = node.left.right;
		//1.把当前节点变成其左节点的右节点
		node.left.right = node;
		node.left.parent = node.parent;
		node.parent = node.left;
		//2.把之前节点左节点的右子树赋值给他的左节点
		node.left = tempLeftRight;
	}
	
	public function leftRightRotate(node:Node):void
	{
		leftRotate(node.left);
		rightRotate(node);
	}
	
	public function rightLeftRotate(node:Node):void
	{
		rightRotate(node.right);
		leftRotate(node);
	}
	
	public function findMostUnbalanceTree(node:Node):Node
	{
		var currentNode:Node = node;
		while(currentNode != null)
		{
			if(currentNode.balanceFactor() > 1 || currentNode.balanceFactor() < -1)
			{
				break;
			}else{
				currentNode = currentNode.parent;
			}
		}
		
		return currentNode;
	}
	
	public function findNode(rootNode:Node, destNode:Node):Boolean
	{
		var boo:Boolean = false;
		if(rootNode == null){
			return boo;
		}
		var currentNode:Node = destNode;
		while(currentNode != rootNode)
		{
			currentNode = currentNode.parent;
			if(currentNode == rootNode)
			{
				boo = true;
				break;
			}
		}
		return boo;
	}
	
	//在插入的时候就需要重平衡树
	//每当插入一个点时是否被破坏了平衡
	//如果破坏了则要找出它的最小平衡子树
	public function insert(data:int):void
	{
		var currentNode:Node = null;
		var tempMost:Node;
		if(treeRoot == null)
		{
			treeRoot = new Node(data);
			return;
		}else{
			currentNode = treeRoot;
		}
		
		while(currentNode != null)
		{
			if(currentNode.data > data)//是否插入到左边
			{
				if(currentNode.left == null)
				{
					currentNode.left = new Node(data);
					currentNode.left.parent = currentNode;
					updateHeight(currentNode.left);
					tempMost = findMostUnbalanceTree(currentNode.left);
					if(tempMost != null)//找到了最小不平衡树,最小不平衡这个节点的祖先都是不平衡的,但是我们只需要调整这个最小树平衡之后其祖先就都平衡了
					{
						//我们还需要看一下是属于哪种情况再考虑怎么旋转
						//看看是否是tempMost的左子树上插入的点
						if(findNode(tempMost.left, currentNode.left))
						{
							if(tempMost.balanceFactor() * tempMost.left.balanceFactor() > 0)
							{
								//假如两个的平衡因子相同, 则只需要进行单旋就可以了
								//由于是LL,那么进行右旋
								rightRotate(tempMost);
								updateTreeHeight();
							}else{
								//假如两个的平衡因子不相同, 则需要进行双旋
								leftRightRotate(tempMost);
								updateTreeHeight();
							}
						}else{//否则就是右子树
							if(tempMost.balanceFactor() * tempMost.right.balanceFactor() > 0)
							{
								leftRotate(tempMost);
								updateTreeHeight();
							}else{
								rightLeftRotate(tempMost);
								updateTreeHeight();
							}
						}
					}
					currentNode = null;
				}else{
					currentNode = currentNode.left;
				}
			}else{//是否插入到右边
				if(currentNode.right == null)
				{
					currentNode.right = new Node(data);
					currentNode.right.parent = currentNode;
					updateHeight(currentNode.right);
					tempMost = findMostUnbalanceTree(currentNode.right);
					if(tempMost != null)
					{
						if(findNode(tempMost.right, currentNode.right))
						{
							if(tempMost.balanceFactor() * tempMost.right.balanceFactor() > 0)
							{
								leftRotate(tempMost);
								updateTreeHeight();
							}else{
								rightLeftRotate(tempMost);
								updateTreeHeight();
							}
						}else{
							if(tempMost.balanceFactor() * tempMost.left.balanceFactor() > 0)
							{
								//假如两个的平衡因子相同, 则只需要进行单旋就可以了
								//由于是LL,那么进行右旋
								rightRotate(tempMost);
								updateTreeHeight();
							}else{
								//假如两个的平衡因子不相同, 则需要进行双旋
								leftRightRotate(tempMost);
								updateTreeHeight();
							}
						}
					}
					currentNode = null;
				}else{
					currentNode = currentNode.right;
				}
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
	
	//TODO::: 这里分析完毕就先不写了,因为之前的代码写的比较乱
	public function remove(data:int):Boolean
	{
		var boo:Boolean = false;
		var tempNode:Node = search(data);
		var preHeight:int;
		var postHeight:int;
		if(tempNode != null)
		{
			boo = true;
		}
		//假如没有孩子
		if((tempNode.left || tempNode.right) == null)
		{
			this.removeNoneChildNode(tempNode);
			this.updateTreeHeight();
			this.findMostUnbalanceTree(tempNode.parent);
			//TODO:rebalance
		}else if((tempNode.left != null && tempNode.right == null) || (tempNode.left == null && tempNode.right != null))//只有一个的情况
		{
			this.removeOneChildNode(tempNode);
			this.updateTreeHeight();
			this.findMostUnbalanceTree(tempNode.parent);
			//TODO:rebalance
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
			this.updateTreeHeight();
			this.findMostUnbalanceTree(tempNode.parent);
			//TODO:rebalance
		}
		
		return boo;
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
	
	public function removeNoneChildNode(node:Node):void
	{
		node.parent.left = node.parent.right = null;
		node.parent = null;
	}
	
	public function removeOneChildNode(node:Node):void
	{
		if(node == node.parent.left)//假如是左孩子
		{
			if(node.left != null)
			{
				node.left.parent = node.parent.left;
				node.parent.left = node.left;
			}else if(node.right != null)
			{
				node.right.parent = node.parent.left;
				node.parent.left = node.right;
			}
		}else if(node == node.parent.right){//假如是右孩子
			if(node.left != null)
			{
				node.left.parent = node.parent.right;
				node.parent.right = node.left;
			}else if(node.right != null)
			{
				node.right.parent = node.parent.right;
				node.parent.right = node.right;
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
	
	//计算平衡因子,用左子树的高度-右子树的高度
	//假如子节点为空则值为-1
	public function balanceFactor():int
	{
		//左右子树的深度差
		var leftH:int = this.left == null ? -1 : this.left.height;
		var rightH:int = this.right == null ? -1 : this.right.height;
		
		return leftH - rightH;
	}
	
	public　function toString():String
	{
		return "Data: " + data;
	}
}