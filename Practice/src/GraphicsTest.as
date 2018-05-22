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
	 * @author juli
	 * 
	 */	
	[SWF(width="800", height="600", frameRate="60", backgroundColor="0")]
	public class GraphicsTest extends Sprite
	{
		public function GraphicsTest()
		{
			super();
		}
	}
}