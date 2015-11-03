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
			vertexs = [];
			arc = [];
		}
		
		/**
		 *添加一个顶点 
		 * @param v
		 * 
		 */		
		public function addVertex(v:DirectedGraphNode):void
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
		public function addEdge(v:DirectedGraphNode, w:DirectedGraphNode):void
		{
			var posV:int = getPosition(v);//找到顶点v的位置
			var posW:int = getPosition(w);//找到顶点w的位置
			if(posV == -1 || posW == -1)
			{
				trace("没有这个顶点!");
				return;
			}
			
			//创建二维矩阵
			if(arc[posV] == null)
			{
				arc[posV] = new Array();
			}
			if(arc[posV][posW] == null)
			{
				arc[posV][posW] = 1;//将边的权置为1,注意这个是有向图
				numArc++;
			}
		}
		
		/**
		 *图的深度遍历 
		 * 递归算法
		 * 定义一个数组把访问过的节点储存起来
		 * 这个算法只对连通图有效，如果有非连通图，则需要遍历所有点
		 */
		private var visited:Array = [];
		private function DFS(node:DirectedGraphNode):void
		{
			visit(node);//访问顶点
			visited[node] = 1;//标记访问过顶点
			for(var j:int = 0; j<numVertexs; j++)
			{
				if(arc[getPosition(node)][j] == 1 && !visited[vertexs[j]])//取得此顶点的邻接点，假如没有访问过则访问
				{
					DFS(vertexs[j]);
				}
			}
		}
		
		/**
		 *非连通图需要遍历所有点做DFS操作 
		 * 
		 */		
		public function DFSTraverse():void
		{
			visited = [];
			for(var i:int = 0; i < numVertexs; i++)
			{
				visited[vertexs[i]] = 0;
			}
			for(var j:int = 0; j < numVertexs; j++)
			{
				if(visited[vertexs[j]] == 0)
				{
					DFS(vertexs[j]);
				}
			}
		}
		
		/**
		 *图的广度遍历 
		 * 与树的层次遍历一样，用队列就可以完成。 
		 */		
		public function HFSTraverse():void
		{
			visited = [];
			var queue:Array = [];
			for(var i:int = 0; i<numVertexs; i++)
			{
				visited[vertexs[i]] = 0;
			}
			//要考虑非连通图的情况
			//所以要遍历所有点
			for(var j:int = 0; i<numVertexs; j++)
			{			
				//找到一个可以访问的点，加入队列中
				queue.unshift(vertexs[j]);
				while(queue.length > 0)//只要队列还有值就继续访问
				{
					var crt:DirectedGraphNode = queue.shift() as DirectedGraphNode;
					visit(crt);//访问节点
					//找到当前节点的所有邻接节点
					for(var k:int = 0; k<numVertexs; k++)
					{
						if(arc[crt] && arc[getPosition(crt)][k] && visited[vertexs[k]] == 0)//假如此邻接节点没有被访问过
						{
							queue.push(vertexs[k]);//添加到队列尾部
						}
					}
				}
			}

			
		}

		/**
		 *取得节点在顶点列表中的位置 
		 * @param node
		 * @return 
		 * 
		 */		
		private function getPosition(node:DirectedGraphNode):int
		{
			var temp:int = -1;
			for(var i:int = 0; i<numVertexs; i++)
			{
				if(vertexs[i].data == node.data)
				{
					return i;
				}
			}
			
			return temp;
		}
		
		private function visit(node:DirectedGraphNode):void
		{
			trace(node);
		}

	}
}
