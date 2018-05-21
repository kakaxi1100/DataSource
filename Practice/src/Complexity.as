package
{
	import flash.display.Sprite;
	/**
	 *	 大O记号 
	 *	同样地出于保守的估计，我们首先关注T(n)的渐进上界。为此可引入所谓“大O记号”
	 *	（big-O notation）。具体地，若存在正的常数c和函数f(n)，使得对任何n >> 2都有 
	 *	T(n)  <  c∙f(n) 
	 *	则可认为在n足够大之后，f(n)给出了T(n)增长速度的一个渐进上界。此时，记之为： 
	 *	T(n)  =  O(f(n)) 
	 *	由这一定义，可导出大O记号的以下性质： 
	 *	(1) 对于任一常数c > 0，有O(f(n))  =  O(c∙f(n)) 
	 *	(2) 对于任意常数a > b > 0，有O(na + nb)  =  O(na) 
	 * 
	 * 
	 * 
	 * 
	 * 题目一：
	 *  1 int countOnes(unsigned int n) { //统计整数n癿二迕刢展开中数位1癿总数：O(logn) 
		2    int ones = 0; //计数器复位 
		3    while (0 < n) { //在n缩减至0前，反复地 
		4       ones += (1 & n); //检查最低位，若为1则计数 
		5       n >>= 1; //右移动一位 
		6    } 
		7    return ones; //迒回计数 
		8 } //等效亍glibc癿内置函数int __builtin_popcount (unsigned int n) 
	
	 * 
	 * 解析:
	 * 1. 输入规模 为n
	 * 2. 求while的运算次数
	 * 
	 * n每次会右移动一位 => n每次会缩减1/2 , 假如缩减了x次  => n变为 n*(1/2)^x
	 * 求当n<1时x的值
	 * x = log2^n
	 * T(n) < O(logn)
	 * 
	 * 
	 * 递归复杂度：
	 * 递归跟踪 
		作为一种直观且可视的方法，递归跟踪（recursion trace）可用以分析递归算法的总体
		运行时间与空间。具体地，就是按照以下原则，将递归算法的执行过程整理为图的形式： 
		1. 算法的每一递归实例都表示为一个方框，其中注明了该实例调用的参数 
		2. 若实例M调用实例N，则在M与N对应的方框之间添加一条有向联线 
	 * 
	 * 递推方程 
		递归算法的另一常用分析方法，即递推方程（recurrence equation）法。与递归跟踪分
		析相反，该方法无需绘出具体的调用过程，而是通过对递归模式的数学归纳，导出复杂度定界函
		数的递推方程（组）及其边界条件，从而将复杂度的分析，转化为递归方程（组）的求解。 	 
	 * 
	 * 
	 * 
	 * 
	 * 
	 * 
	 * 
	 * 
	 * 
	 * 
	 * 
	 * 
	 * 
	 * 
	 * 
	 * 
	 * 
	 * 
	 * 
	 * 
	 * 
	 * 
	 * 
	 * 
	 * 
	 * 
	 * 
	 * 
	 * 
	 * 
	 * 
	 * 
	 * 
	 * 
	 * @author juli
	 * 
	 */	
	public class Complexity extends Sprite
	{
		//hahahah
		public function Complexity()
		{
			super();
		}
	}
}