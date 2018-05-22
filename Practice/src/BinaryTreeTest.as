package
{
	import flash.display.Sprite;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;

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
	[SWF(width="800", height="600", frameRate="60", backgroundColor="0")]
	public class BinaryTreeTest extends Sprite
	{
		public var chars:Array = ["a", "b", "c", "d", "e", "f", "g","h","i","j","k","l"];
		public var charsDic:Dictionary = new Dictionary();
		public var encode:uint = 0;
		public function BinaryTreeTest()
		{
			super();
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
				var first:BinaryTree = trees.shift();
				first.rootNode.data = 0;
				var second:BinaryTree = trees.shift();
				second.rootNode.data = 1;
				//创建一个新的trees
				var newTree:BinaryTree = new BinaryTree();
				newTree.rootNode.data = 1;//默认是1, 因为root需要是1, 因为001和01在二进制都表示1
				newTree.rootNode.leftChild = first.rootNode;
				newTree.rootNode.rightChild = second.rootNode;
				first.rootNode.parentNode = newTree.rootNode;
				second.rootNode.parentNode = newTree.rootNode;
				trees.push(newTree);
			}
			this.addChild(trees[0]);
			trees[0].x = 200;
			trees[0].y = 100;
			trees[0].draw(trees[0].rootNode);
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
					index++;
				}
				charsDic[key] = value;
				charsDic[value] = key;
			}
			
			for(var k:* in charsDic)
			{
				trace(k," : " ,charsDic[k]);
			}
			
			//4.测试
			var s:String = "deflkjlhlkjlkjljlkjljlkjabcddd";
			var b:ByteArray = encodeS(s);
			decodeV(b);
		}
		
		public function encodeS(s:String):ByteArray
		{
			var abc:uint = 0;
			var key:String = "";
			var bb:ByteArray = new ByteArray();
			var value:uint = 0;
			for(var i:int= 0; i < s.length; i++)
			{
				key = s.charAt(i);
				value = this.charsDic[key];
				bb.writeUnsignedInt(value);
			}
			
			return bb;
		}
		
		public function decodeV(value:ByteArray):String
		{
			value.position = 0;
			var s:String = "";
			while(value.bytesAvailable > 0)
			{
				var charKey:uint = value.readUnsignedInt();	
				s += this.charsDic[charKey];
			}
			trace(s);
			return s;
		}
	}
}
import flash.display.Sprite;
import flash.text.TextField;

class BinaryTree extends Sprite
{
	public var rootNode:BinaryNode = new BinaryNode();
	public function BinaryTree()
	{
		this.graphics.lineStyle(2, 0xffffff);
	}
	
	public function draw(node:BinaryNode, offsetX:int = 0, offsetY:int = 0, color:uint = 0xffffff):void
	{
		if(node == null) return;
		this.addChild(node);
		node.draw(color);
		var parentX:int = 0;
		var parentY:int = 0;
		if(node.parentNode != null)
		{
			parentX = node.parentNode.x;
			parentY = node.parentNode.y;
		}
		node.x = parentX + offsetX * 50;
		node.y = parentY + offsetY * 50;
		this.graphics.moveTo(parentX,  parentY + 5);
		this.graphics.lineTo(node.x, node.y - 5);
		this.draw(node.leftChild, -1, 1, 0xffff00);
		this.draw(node.rightChild, 1, 1, 0xff00ff);
	}
}

class BinaryNode extends Sprite
{
	public var data:int;
	public var leftChild:BinaryNode = null;
	public var rightChild:BinaryNode = null;
	public var parentNode:BinaryNode = null;
	public var tf:TextField = new TextField();
	public function BinaryNode()
	{
		this.graphics.lineStyle(2, 0xffffff);
		this.graphics.drawCircle(0,0,10);
		tf.text = this.data.toString();
		tf.height = 20;
		tf.width = 20;
		tf.x = -10;
		tf.y = -10;
		tf.textColor = 0xffffff;
		addChild(tf);
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
	
	public function draw(color:uint = 0xffffff):void
	{
		this.graphics.clear();
		this.graphics.lineStyle(2, color);
		this.graphics.drawCircle(0,0,10);
		tf.text = this.data.toString();
	}
}