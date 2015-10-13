package
{
	import flash.display.Sprite;
	
	import treestruct.BinarySortTree;
	import treestruct.BinarySortTreeNode;
	
	public class Tree extends Sprite
	{
		public function Tree()
		{
			var t31:BinarySortTreeNode = new BinarySortTreeNode();
			t31.data = 29;
			
			var t21:BinarySortTreeNode = new BinarySortTreeNode();
			t21.data = 2;
			
			var t22:BinarySortTreeNode = new BinarySortTreeNode();
			t22.data = 12;
			
			var t23:BinarySortTreeNode = new BinarySortTreeNode();
			t23.data = 20;
			
			var t24:BinarySortTreeNode = new BinarySortTreeNode();
			t24.data = 31;
			t24.left = t31;
			
			var t11:BinarySortTreeNode = new BinarySortTreeNode();
			t11.data = 10;
			t11.left = t21;
			t11.right = t22;
			
			var t12:BinarySortTreeNode = new BinarySortTreeNode();
			t12.data = 25;
			t12.left = t23;
			t12.right = t24;
			
			var r:BinarySortTreeNode = new BinarySortTreeNode();
			r.data = 13;
			r.left = t11;
			r.right = t12;

			var bt:BinarySortTree = new BinarySortTree();
			bt.r = r;
			
			//trace(bt.search(10).data);
			//bt.breadthFirst();
//			bt.inorder(r);
			bt.iterativeInorder();
//			bt.preorder(r);
//			bt.iterativePreorder();
//			bt.postorder(r);
//			bt.iterativePostorder();
		}
	}
}