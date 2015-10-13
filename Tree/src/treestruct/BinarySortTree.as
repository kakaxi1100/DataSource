package treestruct
{
	/**
	 *二叉查找树 
	 *要满足左节点的值比本节点的小，右节点的值比本节点大 
	 * @author Administrator
	 * 
	 */	
	public class BinarySortTree
	{
		public var r:BinarySortTreeNode;
		public function BinarySortTree()
		{
		}
		//深度优先有三种情况  前序遍历  中序遍历  后序遍历
		/**
		 *中顺遍历 的递归方法
		 * 
		 */		
		public function inorder(p:BinarySortTreeNode):void
		{
			if(p == null)
			{
				return;
			}
			
			inorder(p.left);
			visit(p);
			inorder(p.right);
		}
		
		/**
		 *前序遍历  的递归方法
		 * 
		 */		
		public function preorder(p:BinarySortTreeNode):void
		{
			if(p == null)
			{
				return;
			}
			
			visit(p);
			preorder(p.left);
			preorder(p.right);
		}
		
		/**
		 *后序遍历  的递归方法
		 * 
		 */		
		public function postorder(p:BinarySortTreeNode):void
		{
			if(p == null)
			{
				return;
			}
			
			postorder(p.left);
			postorder(p.right);
			visit(p);
		}
		
		/**
		 *前序遍历 的迭代方法 
		 *前序的迭代方法最简单，无非就是按访问顺序 右字节点左节点先后入栈而已 
		 */		
		public function iterativePreorder():void
		{
			var p:BinarySortTreeNode = r;
			var temp:Array = [];
			if(p != null)
			{
				temp.push(p);
				while(temp.length != 0)
				{
					p = temp.pop();
					visit(p);
					if(p.right != null)//右节点要先入栈
					{
						temp.push(p.right);
					}
					if(p.left != null)//左节点要后入栈 因为要先弹出
					{
						temp.push(p.left);
					}
				}
			}
		}
		
		/**
		 *中序遍历 的迭代方法 
		 *按照访问顺序呢 LVR 来操作栈
		 * 先让 左节点全部入栈，然后弹出节点，如果节点有右节点，
		 * 先访问节点后，再将右节点的左节点全部入栈，一次循环
		 * 另外需要一个q 来记录已经访问过的节点，如果节点访问过，就不应再循环入栈 
		 */		
		public function iterativeInorder():void
		{
			var p:BinarySortTreeNode = r;
			var q:BinarySortTreeNode;
			var temp:Array = [];
			while( p != null){
				while(p != null && q != p)//假如节点存在，并且上次没有访问过
				{
					temp.push(p);//保存了所有当前节点的左子树节点
					p = p.left;
				}
				if(temp.length == 0)//假如栈无值就返回
				{
					return;
				}
				p = temp.pop();//出栈，访问栈顶元素
				q = p
				visit(p);
				if(p.right != null)
				{
					p = p.right;//如果有右节点，则当前节点出站后，要把右节点也假如进来
				}
				
			}
		}
		
		/**
		 *后序遍历 的迭代方法 
		 *思路有由于是 先 L 再 R 再 V
		 * 所以先将当前节点的左节点全部入栈，除了叶子节点，此时指针指向的是 当前节点最左节点的 叶子节点
		 * 然后访问叶子节点，并且弹出栈顶节点即 此时叶子节点的父节点， 检查 父节点有没有右节点， 并且判断右节点有没有被访问过
		 * 如果有右节点并且没有被访问过，就再将此节点入栈，并且当前节点指向此节点的右节点，
		 * 循环将其左节点入栈 循环往复
		 */		
		public function iterativePostorder():void
		{
			var p:BinarySortTreeNode = r;//表示当前节点
			var q:BinarySortTreeNode = p;//表示上次被访问过的节点
			var temp:Array = [];
			while(p != null)
			{
				for(;p.left != null; p = p.left)//先将除了叶子节点的左节点全部入栈
				{
					temp.push(p);
				}
				//此时P指向的是最后一个左叶子节点，并且没有入栈
				while(p.right == null || p.right == q)//假如当前节点的右节点为空或者P的右节点被访问过了，则P可以访问，因为访问的顺序是 LRV
				{
					visit(p);//访问这个节点
					q = p;
					if(temp.length == 0)//假如只有一个节点，则根本不会有节点入栈
					{
						return;
					}
					p = temp.pop();//弹出父左节点
				}
				
				//假如右节点不为空， 则被弹出的节点，再次入栈， 因为它不能被先访问，要先访问右节点
				temp.push(p);
				//再将下次访问的节点指向此节点的右节点
				p = p.right;
			}
		}
		
		/**
		 *广度优先遍历 
		 * 先将访问的节点添加到数组头部，再将其左右节点添加到数组尾部
		 * 这样访问节点的顺序就构成了广度优先
		 */		
		public function breadthFirst():void
		{
			var temp:Array = [];
			var p:BinarySortTreeNode = r;
			if(p != null)
			{
				temp.unshift(p);
				while(temp.length != 0)
				{
					p = temp.shift();
					visit(p);
					if(p.left != null)
					{
						temp.push(p.left);
					}
					if(p.right != null)
					{
						temp.push(p.right);
					}
				}
			}
		}

		/**
		 * 根据数据查找数据所在节点， 如果不存在就返回空
		 * @param s 要查找的数据
		 * @return 返回节点
		 * 
		 */		
		public function search(s:int):BinarySortTreeNode
		{
			var p:BinarySortTreeNode = r;
			while(p != null)
			{
				if(p.data == s)
				{
					return p;
				}else if(p.data > s)
				{
					p = p.left;
				}else
				{
					p = p.right;
				}
			}
			return null;
		}
		
		public function visit(p:BinarySortTreeNode):void
		{
			trace(p);
		}
	}
}