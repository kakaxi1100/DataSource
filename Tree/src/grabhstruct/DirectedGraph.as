package grabhstruct
{
	/**
	 *不带权的有向图
	 * 用邻接矩阵来实现
	 * 顶点用int表示 
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
		 *添加一个顶点 
		 * @param v
		 * 
		 */		
		public function addVertex(v:int):void
		{
			vertexs.push(v);
			numVertexs++;
		}
		
		/**
		 *在v和w 之间建立一条边 
		 * @param v
		 * @param w
		 * 
		 */		
		public function addEdge(v:int, w:int):void
		{
			if(arc[v] == null || arc[v][w] == null)
			{
				trace("没有这个顶点！");
				return;
			}
			arc[v][w] = 1;
			numArc++;
		}
		
		/**
		 *图的深度遍历 
		 * 递归算法
		 * 定义一个数组把访问过的节点储存起来
		 * 这个算法只对连通图有效，如果有非连通图，则需要遍历所有点
		 */
		private var visited:Array = [];
		public function DFS(node:int):void
		{
			visit(node);//访问顶点
			visited[node] = 1;//标记访问过顶点
			for(var j:int = 0; j<numVertexs; j++)
			{
				if(arc[node][j] == 1 && !visited[j])//取得此顶点的邻接点，假如没有访问过则访问
				{
					DFS(j);
				}
			}
		}
		
		/**
		 *非连通图需要遍历所有点做DFS操作 
		 * 
		 */		
		public function DFSTraverse():void
		{
			for(var i:int = 0; i < numVertexs; i++)
			{
				visited[i] = 0;
			}
			for(var j:int = 0; j < numVertexs; j++)
			{
				if(visited[j] == 0)
				{
					DFS(j);
				}
			}
		}
		
		/**
		 *图的广度遍历 
		 * 
		 */		
		public function HFSTraverse():void
		{
			
		}
		
		private function visit(node:int):void
		{
			trace(node);
		}
	}
}
