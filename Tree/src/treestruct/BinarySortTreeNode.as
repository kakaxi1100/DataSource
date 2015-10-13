package treestruct
{
	public class BinarySortTreeNode
	{
		public var left:BinarySortTreeNode;
		public var right:BinarySortTreeNode;
		public var data:int;
		
		public function BinarySortTreeNode()
		{
			
		}
		
		public function toString():String
		{
			return data.toString();
		}
	}
}