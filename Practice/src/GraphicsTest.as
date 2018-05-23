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
	 * 
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
		public function GraphicsTest()
		{
			super();
			for(var i:int = 0; i < 4; i++)
			{
				gm.vertex[i].data = i * 10;
				for(var j:int = i + 1; j < 4; j++){
					var e:Edge = gm.edges[i][j] = gm.edges[j][i];//无向图矩阵对称
					e.weight = 1;
				}
			}
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

//---------------------------------------------------------------------------