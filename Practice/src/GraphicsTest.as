package
{
	import flash.display.Sprite;
	/**
	 * 度 
		对于任何边e = (u, v)，称顶点u和v彼此邻接（adjacent），互为邻居；而它们都与边e
		彼此关联 （incident） 。 在无向图中， 与顶点v关联的边数， 称作v的度数 （degree） ， 记作deg(v)。
		对于有向边e = (u, v)，e称作u的出边（outgoing edge）、v的入边（incoming edge）。
		v的出边总数称作其出度 （out-degree） ， 记作outdeg(v)； 入边总数称作其入度 （in-degree） ，
		记作indeg(v)
	 * 
	 * 
	 * 通路与环路 
		所谓路径或通路（path），就是由m + 1个顶点与m条边交替而成的一个序列： 
		  π =  { v0, e1, v1, e2, v2, ..., em, vm } 
		且对任何0 < i  m都有ei = (vi-1, vi)。也就是说，这些边依次地首尾相联。其中沿途
		边的总数m，亦称作通路的长度，记作|| = m。 
		为简化描述，也可依次给出通路沿途的各个顶点，而省略联接于其间的边，即表示为： 
  		π =  { v0, v1, v2, ..., vm } 
	 * 
	 * 
	 * 图遍历算法概述 
	 * 无论采用何种策略和算法，图的遍历都可理解为，将非线性结构转化为半线性结构的过程
	 * 
	 * 
	 * 广度优先搜索（breadth-first search, BFS）采用的策略，可概括为： 
		越早被访问到的顶点，其邻居越优先被选用 
		若将上述BFS策略应用于树结构，则效果等同于层次遍历
	
	 * 深度优先搜索（Depth-First Search, DFS）选取下一顶点的策略，可概括为： 
		优先选取最后一个被访问到的顶点的邻居  
	 	以顶点s为基点的DFS搜索，将首先访问顶点s；再从s所有尚未访问到的邻居中任取
		其一，并以之为基点，递归地执行DFS搜索。故各顶点被访问到的次序，类似于树的先序遍历
		而各顶点被访问完毕的次序，则类似于树的后序遍历
		就是一条路走到黑,如果不行就回退到最近的点,在把这个点的路走到黑,直至所有的点都走完
	 * 	 
	 * 
	 * 图的邻接矩阵表示方式
	 * 一个一维数组用来存储顶点信息, 一个二维数组存储边的信息
	 * 
	 * 图的邻接表表示方法
	 * 一个一维数组用来存储顶点信息(或者用链表, 只不过数组更方便读取顶点信息)
	 * 每个顶点还需要有个指向其第一个邻接点的指针
	 * 
	 * 
	 * 
	 * @author juli
	 * 
	 */	
	[SWF(width="800", height="600", frameRate="60", backgroundColor="0")]
	public class GraphicsTest extends Sprite
	{
		// v0  v1
		// -------
		// |\   /|
		// | \ / |
		// |  \  |
		// | / \ |
		// |/   \|
		// -------
		// v2    v3
		//
		
		public var gm:GraphicsMatrix = new GraphicsMatrix(4);
		public var gl:GraphicsAdjoinList = new GraphicsAdjoinList(4);
		public function GraphicsTest()
		{
			super();
			var i:int;
			for(i = 0; i < 4; i++)
			{
				gm.vertex[i].data = i * 10;
				for(var j:int = i + 1; j < 4; j++){
					var e:Edge = gm.edges[i][j] = gm.edges[j][i];//无向图矩阵对称
					e.weight = 1;
				}
			}
			
			for(i = 0; i < 4; i++)
			{
				gl.vertex[i].data = i * 10;
			}
			
			var temp:EdgeNode;
			gl.vertex[0].edge = new EdgeNode();
			gl.vertex[0].edge.data = gl.vertex[1];
			temp = new EdgeNode();
			temp.data = gl.vertex[2];
			temp.next = gl.vertex[0].edge;
			gl.vertex[0].edge = temp;
			temp = new EdgeNode();
			temp.data = gl.vertex[3];
			temp.next = gl.vertex[0].edge;
			gl.vertex[0].edge = temp;
			
			gl.vertex[1].edge = new EdgeNode();
			gl.vertex[1].edge.data = gl.vertex[0];
			temp = new EdgeNode();
			temp.data = gl.vertex[2];
			temp.next = gl.vertex[1].edge;
			gl.vertex[1].edge = temp;
			temp = new EdgeNode();
			temp.data = gl.vertex[3];
			temp.next = gl.vertex[1].edge;
			gl.vertex[1].edge = temp;
			
			gl.vertex[2].edge = new EdgeNode();
			gl.vertex[2].edge.data = gl.vertex[0];
			temp = new EdgeNode();
			temp.data = gl.vertex[1];
			temp.next = gl.vertex[2].edge;
			gl.vertex[2].edge = temp;
			temp = new EdgeNode();
			temp.data = gl.vertex[3];
			temp.next = gl.vertex[2].edge;
			gl.vertex[2].edge = temp;
			
			gl.vertex[3].edge = new EdgeNode();
			gl.vertex[3].edge.data = gl.vertex[0];
			temp = new EdgeNode();
			temp.data = gl.vertex[2];
			temp.next = gl.vertex[3].edge;
			gl.vertex[3].edge = temp;
			temp = new EdgeNode();
			temp.data = gl.vertex[1];
			temp.next = gl.vertex[3].edge;
			gl.vertex[3].edge = temp;
			
			gl.BFS_ALL();
		}
	}
}

//-----------邻接矩阵表示法-------------------------------------------------------
class GraphicsMatrix
{
	public var vertex:Vector.<Node> = new Vector.<Node>();
	public var edges:Vector.<Vector.<Edge>> = new Vector.<Vector.<Edge>>();
	public function GraphicsMatrix(numVertex:int)
	{
		for(var i:int = 0; i < numVertex; i++)
		{
			vertex[i] = new Node();
			edges[i] = new Vector.<Edge>();
			for(var j:int = 0; j < numVertex; j++)
			{
				edges[i][j] = new Edge();
			}
		}
	}
}

class Node
{
	public var data:int;
	public function Node()
	{
		
	}
}

class Edge
{
	public var weight:int;
	public function Edge()
	{
		
	}
}
//---------------------------------------------------------------------------

//-----------邻接表表示法--------------------------------------------------------
class GraphicsAdjoinList
{
	//顶点列表, 顶点列表可以用数组也可以用链表, 当然用数组更容易
	public var vertex:Vector.<VertexNode> = new Vector.<VertexNode>();
	public function GraphicsAdjoinList(numVertex:int)
	{
		for(var i:int = 0; i < numVertex; i++)
		{
			vertex[i] = new VertexNode();
		}
	}
	
	//检查所有联通域
	//因为可能存在多个连通域
	public function BFS_ALL():void
	{
		var checkedList:Vector.<VertexNode> = new Vector.<VertexNode>();
		for(var i:int = 0; i < vertex.length; i++)
		{
			bfs( vertex[i],checkedList);
		}
	}
	
	//和树的层次遍历一样的
	//检查单独的连通域
	public function bfs(firstNode:VertexNode, list:Vector.<VertexNode>):void
	{
		//已经检查过的列表
		var checkedList:Vector.<VertexNode> = list;
		//引入队列
		var queue:Vector.<VertexNode> = new Vector.<VertexNode>();
		//将首点加入
		queue.push(firstNode);
		while(queue.length > 0)
		{
			//第一个点出队列
			var node:VertexNode = queue.shift();
			if(checkedList.indexOf(node) == -1)
			{
				checkedList.push(node);
				trace(node);
			}
			var temp:EdgeNode = node.edge;
			while(temp != null)
			{
				if(queue.indexOf(temp.data) == -1 && checkedList.indexOf(temp.data) == -1)
				{
					queue.push(temp.data);
				}
				temp = temp.next;
			}
		}
		
	}
	
	//
	public function DFS_ALL():void
	{
		
	}
	
	public function dfs():void
	{
		//检查列表
		var checkList:Vector.<VertexNode> = new Vector.<VertexNode>();
		//访问列表
		var visitList:Vector.<VertexNode> = new Vector.<VertexNode>();
		//先指定第一个点
		visitList.push(vertex[0]);
	}
}

class VertexNode
{
	//数据域
	public var data:int;
	//链表域
	public var edge:EdgeNode = null;
	public function VertexNode()
	{
		
	}
	
	public function toString():String
	{
		return data.toString();
	}
}


class EdgeNode
{
	public var data:VertexNode;
	public var weight:int;
	public var next:EdgeNode;
	public function EdgeNode()
	{
		
	}
}
//---------------------------------------------------------------------------