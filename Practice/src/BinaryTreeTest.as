package
{
	import flash.display.Sprite;
	/**
	 *  v的孩子总数，称作其度数或度（degree）
	 *  沿每个节点v到根r的唯一通路所经过边的数目，称作v的深度（depth）
	 *  树T中所有节点深度的最大值称作该树的高度（height）
	 * 
	 *  有序多叉树 = 二叉树
	 *  为了保证作为多叉树特例的二叉树有足够的能力表示任何一棵多叉树，我们只需给多
		叉树增加一项约束条件同一节点的所有孩子之间必须具有某一线性次序
	
	 *  1.长子 + 兄弟 
	 * 为每个节点 设置两个指针，分别指向其“长子”和下一“兄弟”
	 *  
	 * @author juli
	 * 
	 */	
	public class BinaryTreeTest extends Sprite
	{
		public var chars:Array = ["a", "b", "c", "d", "e", "f", "g"];
		public function BinaryTreeTest()
		{
			super();
			trace(1<<1);
			var i:int;
			var trees:Array = [];
			var leaves:Array = [];
			var tempTree:BinaryTree;
			//1.转化为树
			for(i = 0; i < chars.length; i++)
			{
				tempTree = new BinaryTree();
				trees.push(tempTree);
				leaves.push(tempTree);
			}
			//2.生成编码树
			while(trees.length > 1)
			{
				//取出两颗树进行合并
				var first:BinaryTree = trees.pop();
				first.rootNode.data = 0;
				var second:BinaryTree = trees.pop();
				second.rootNode.data = 1;
				//创建一个新的trees
				var newTree:BinaryTree = new BinaryTree();
				newTree.rootNode.data = 0;//默认是0
				newTree.rootNode.leftChild = first.rootNode;
				newTree.rootNode.rightChild = second.rootNode;
				first.rootNode.parentNode = newTree.rootNode;
				second.rootNode.parentNode = newTree.rootNode;
				trees.push(newTree);
			}
			//3.生成编码表
			while(leaves.length > 0)
			{
				var key:String = chars.pop();
				var value:uint = 0;
				var index:int = 0;
				var leave:BinaryTree = leaves.pop();
				var temp:BinaryNode = leave.rootNode;
				while( temp != null )
				{
					var data:uint = temp.data << index;
//					value = temp.data;
					value |= data;
					temp = temp.parentNode;
				}
			}
		}
	}
}
import flash.display.Sprite;

class BinaryTree extends Sprite
{
	public var rootNode:BinaryNode = new BinaryNode();
	public function BinaryTree()
	{
		
	}
	
	public function draw():void
	{
		
	}
}

class BinaryNode extends Sprite
{
	public var data:int;
	public var leftChild:BinaryNode = null;
	public var rightChild:BinaryNode = null;
	public var parentNode:BinaryNode = null;
	public function BinaryNode()
	{
		this.graphics.lineStyle(2, 0xffffff);
		this.graphics.drawCircle(0,0,10);
	}
	
	public function insertLeft(left:BinaryNode):void
	{
		left.leftChild = this.leftChild;
		this.leftChild = left;
	}
	
	public function insertRight(right:BinaryNode):void
	{
		right.rightChild = this.rightChild;
		this.rightChild = right;
	}
	
	public function isLeave():Boolean
	{
		return leftChild == null && rightChild == null;
	}
}