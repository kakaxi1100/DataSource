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
	public class BinaryTree extends Sprite
	{
		public function BinaryTree()
		{
			super();
		}
	}
}