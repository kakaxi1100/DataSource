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
		
		/**
		 *插入节点到 二叉查找树 
		 * 插入就是插入到叶子节点，
		 * 找到最终的那个叶子节点，
		 * 如果比此叶子节点的值大就插到右边， 否则插入到左边
		 * @param p
		 * 
		 */		
		public function instert(p:BinarySortTreeNode):void
		{
			if(p == null) return;
			var crt:BinarySortTreeNode = r;
			var pre:BinarySortTreeNode;
			//先循环找到叶子节点
			while(crt != null)
			{
				pre = crt;
				if(p.data > crt.data)
				{
					crt = crt.right;
				}else
				{
					crt = crt.left;
				}
			}
			
			//此时 pre为要找的那个而叶子节点， crt为空
			if(r == null)
			{
				r = p;
			}else if(p.data > pre.data)//比较叶子节点的值，进行插入
			{
				pre.right = p;
			}else
			{
				pre.left = p;
			}
		}
		
		/**
		 *合并删除
		 * 合并删除会增加树的高度,删除节点会增加数的高度
		 * 有三种情况：
		 * 1，要删除的节点是一个叶子节点，直接删除此节点，并将父节点的指向它的指针置为空
		 * 2，要删除的节点只有一个子节点，则删除此及诶单，并将它父节点的指向它的指针指向它的子节点
		 * 3，要删除的节点有两个子节点，可以通过合并删除处理
		 * 此节点删除后，分为左子树和右子树，找到此左子树的最大节点，并将其作为右子树的父节点
		 * 或者同意，找到右子树最小的节点，作为左子树的父节点。 
		 * @param s
		 * 
		 */		
		public function findAndDeleteByMerging(s:int):void
		{
			var crt:BinarySortTreeNode = r;
			var parent:BinarySortTreeNode;
			//先找到要找的节点并和父节点
			while(crt != null)
			{
				if(s == crt.data)
				{
					break;
				}
				parent = crt;
				if(s > crt.data)
				{
					crt = crt.right;
				}else if(s < crt.data)
				{
					crt = crt.left;
				}
			}
			
			//看此节点子节点的情况来决定如何删除
			if(crt != null && crt.data == s)
			{
				deleteByMerging(crt, parent);
			}
		}
		
		/**
		 *合并并删除节点 
		 * @param pCrt
		 * @param pParent
		 * 
		 */		
		private function deleteByMerging(pCrt:BinarySortTreeNode, pParent:BinarySortTreeNode):void
		{
			//假如点为空，就直接返回
			if(pCrt == null) return;
			var rightMost:BinarySortTreeNode = findTheRightMost(pCrt.left);//找到左子树的最大节点
			/*if(rightMost != null)//假如有左子节点一定可以找到
			{
				rightMost.right = pCrt.right;//找到后，让右子树做合并，不管是不是null 都可以
			}*/
				
			if(pParent == null)//表明是root 重新指派root
			{
				if(rightMost != null)//假如当前节点有左子节点，则做过合并，root 直接指向左子节点
				{
					r = pCrt.left;
				}else
				{
					r = pCrt.right;//假如没有左子节点，则指向其右子节点
				}
			}
			else
			{
				if(pParent.right == pCrt)//假如当前节点是父节点的右节点，就将父节点的右指针，指向当且节点不为空的那个节点。
				{
					if(pCrt.left != null)//也可以用rightMost 代替
					{
						pParent.right = pCrt.left;
					}else
					{
						pParent.right = pCrt.right;
					}
				}else//假如当前节点是父节点的左节点，就将父节点的左指针，指向当且节点不为空的那个节点。
				{
					if(pCrt.left != null)//也可用用rightMost 代替
					{
						pParent.left = pCrt.left;
					}else
					{
						pParent.left = pCrt.right;
					}
				}
			}
			pCrt = null;//删除当前节点
		}
		
		/**
		 *复制删除 
		 * 复制删除的优点是没有增加树的高度,但是如果删除的都是同一个节点，那么多次的插入和删除会使树向右倾斜
		 * 有三种情况：
		 * 1，要删除的节点是一个叶子节点，直接删除此节点，并将父节点的指向它的指针置为空
		 * 2，要删除的节点只有一个子节点，则删除此及诶单，并将它父节点的指向它的指针指向它的子节点
		 * 3，要删除的节点有两个子节点，可以通过复制删除处理
		 * 先找到要删除的点左子树的最右边一点，在把值复制给当前点，假如最右边的一点有左子树，则它的父节点指向其左节点。
		 * @param s
		 * 
		 */		
		public function findAndDeleteByCopying(s:int):void
		{
			var crt:BinarySortTreeNode = r;
			var parent:BinarySortTreeNode;
			//先找到要找的节点并和父节点
			while(crt != null)
			{
				if(s == crt.data)
				{
					break;
				}
				parent = crt;
				if(s > crt.data)
				{
					crt = crt.right;
				}else if(s < crt.data)
				{
					crt = crt.left;
				}
			}
			
			//看此节点子节点的情况来决定如何删除
			if(crt != null && crt.data == s)
			{
				deleteByCopying(crt, parent);
			}
		}
		
		private function deleteByCopying(pCrt:BinarySortTreeNode,  pParent:BinarySortTreeNode):void
		{
			//假如点为空，就直接返回
			if(pCrt == null) return;
			var parent:BinarySortTreeNode = pCrt;//parent, 首先指向要删除的节点
			var temp:BinarySortTreeNode = pCrt.left;//temp首先指向当前节点的左节点，不管是不是空
			//查找左子树最大的节点，并且记录 parent 值
			while(temp != null && temp.right != null)
			{
				parent = temp;//记录最后右节点的父节点
				temp = temp.right;//左子树中最大的值
			}
			//此时有两种情况
			//1, 当前节点有左子树,则 temp不为空
			if(temp != null)
			{
				//1,把temp的赋值给当前节点
				pCrt.data = temp.data;
				//2，删除temp节点,temp节点除了初始的pCrt.left外只能是parent的右节点
				if(temp == pCrt.left)
				{
					parent.left = null;
				}
				else
				{
					parent.right = null;
				}
				temp = null;
			}
			//2, 当前节点没有左子树，则temp为空
			else
			{
				//则将其右节点赋值给它的parent，不管它的右节点是不是为空，然后删除此节点
				//1,先判断它是自己parent的左节点还是右节点
				if(pParent.left == pCrt)
				{
					pParent.left = pCrt.right;
				}else
				{
					pParent.right = pCrt.right;
				}
				pCrt = null;
			}
		}
		
		/**
		 *找到最小的点 
		 * @return 
		 * 
		 */		
		private function findTheLeftMost(p:BinarySortTreeNode):BinarySortTreeNode
		{
			var temp:BinarySortTreeNode = p;
			while(temp != null && temp.left != null)
			{
				temp = temp.left;
			}
			return temp
		}
		
		/**
		 *找到最大的点 
		 * @return 
		 * 
		 */		
		private function findTheRightMost(p:BinarySortTreeNode):BinarySortTreeNode
		{
			var temp:BinarySortTreeNode = p;
			while(temp != null && temp.right != null)
			{
				temp = temp.right;
			}
			return temp
		}
		
		/**
		 *访问节点 
		 * @param p
		 * 
		 */		
		public function visit(p:BinarySortTreeNode):void
		{
			trace(p);
		}
	}
}