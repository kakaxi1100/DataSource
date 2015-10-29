package grabhstruct
{
	/**
	 *不带权的有向图 
	 * @author Administrator
	 * 
	 */	
	public class DirectedGraph
	{
		//一维数组用来存储顶点
		public var vertexs:Array;
		//邻接矩阵表示法
		//二维数组来表示弧
		public var arc:Array;
		
		public var numVertexs:int;
		public var numArc:int;
		
		public function DirectedGraph()
		{
		}
		
		/**
		 *在v和w 之间建立一条边 
		 * @param v
		 * @param w
		 * 
		 */		
		public function addEdge(v:int, w:int):void
		{
			
		}
	}
}
