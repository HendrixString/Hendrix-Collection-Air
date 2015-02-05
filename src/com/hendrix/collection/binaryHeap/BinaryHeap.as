package com.hendrix.collection.binaryHeap
{
	public class BinaryHeap
	{
		public static var MAX_HEAP:	String 					= "MAX_HEAP";
		public static var MIN_HEAP:	String 					= "MIN_HEAP";
		
		protected var _heapType:		String					=	null;
		protected var _keyField:		String					=	null;
		
		protected var _A:						Vector.<Object> = null;
		protected var _heapSize:		uint						=	0;
		
		// an empty set and a singleton is a heap
		protected var _isHeap:			Boolean					=	true;
		
		/**
		 * Binary Heap data structure. please note that all data access should
		 * be done under the assumption of positive array indices <code>[1..n]</code>.
		 * supports the regular operations of building a min/max heap, heapify a node, heapsort.
		 * @author Tomer Shalev
		 */
		public function BinaryHeap($keyField:String = null,$heapType:String = "MAX_HEAP")
		{
			_keyField	=	$keyField;
			_heapType	=	$heapType;
			
			_A 				= new Vector.<Object>();
		}
		
		public function dispose():void
		{
			_A.length = 0;
			_A = null;	
		}
		
		public function reset():void
		{
			_A.length = 0;
		}
		
		public function get keyField():String
		{
			return _keyField;
		}

		/**
		 * @return <code>True</code> if Heap property is maintained. <code>False</code> if Heap
		 * property is violated. 
		 */
		public function  isHeap():Boolean
		{
			return _isHeap;
		}

		/**
		 * add an element to the set, supports Objects and Vectors of Objects.
		 * this is not a heap yet
		 */
		public function initElements(...elements):void
		{
			for(var ix:uint = 0; ix < elements.length; ix++) {
				if(elements[ix] is Vector.<*>)
					_A = _A.concat(elements[ix]);
				else
					_A.push(elements[ix]);
			}
			_isHeap = false;
		}

/*		HEAP-EXTRACT-MAX(A)
		1 if heap-size[A] < 1
		2   then error "heap underflow"
		3 max ← A[1]
		4 A[1] ← A[heap-size[A]]
		5 heap-size[A] ← heap-size[A] - 1
		6 MAX-HEAPIFY(A, 1)
		7 return max
*/		
		public function heapExtractRoot():Object
		{
			if(heapSize < 1)
				return null;

			var max:Object = getNode(1);
			_A[0] = getNode(heapSize);
			heapSize -= 1;
			_A.pop();
			heapify(1);
			return max;
		}

		/*
		HEAP-INCREASE-KEY(A, i, key)
		1 if key < A[i]
		2   then error "new key is smaller than current key"
		3 A[i] ← key
		4 while i > 1 and A[PARENT(i)] < A[i]
		5     do exchange A[i] ↔ A[PARENT(i)]
			6         i ← PARENT(i)
			*/
		/**
		 * Update a key and maintain the heap 
		 * @param $index The index of node [1..n]
		 * @param $key the new key
		 */
		public function heapUpdateKeyOfNode($index:uint, $key:Object):void
		{
			if($index <= 0)
				throw new Error("index must be non zero: [1..n]");

			var i:int = $index;
			changeKeyOfNode($index, $key);
			if(_heapType == MAX_HEAP)
			{
				if($key < keyOfNode($index))
					heapify($index);
				else {
					while((i > 1) && (keyOfNode(parent(i)) < keyOfNode(i) ) ) {
						swap(i, parent(i));
						i = parent(i);
					}
				}
			}
			else if(_heapType == MIN_HEAP)
			{
				if($key > keyOfNode($index))
					heapify($index);
				else {
					while((i > 1) && (keyOfNode(parent(i)) > keyOfNode(i) ) ) {
						swap(i, parent(i));
						i = parent(i);
					}
				}
			}
			
		}

/*		MAX-HEAP-INSERT(A, key)
		1 heap-size[A] ← heap-size[A] + 1
		2 A[heap-size[A]] ← -∞
			3 HEAP-INCREASE-KEY(A, heap-size[A], key)
*/
		/**
		 * insert a new element into the heap and maintain heap property,
		 * can be used to build a heap from scratch but that would be in O(nlog(n)),
		 * buildheap() is more efficient (O(n)) but requires the set
		 * @param $element the element to insert
		 */
		public function heapInsert($element:Object):void
		{
			if(_isHeap == false)
				buildHeap();
			
			heapSize += 1;
			_A.push($element);
			
			var key:Object = _keyField ? $element[_keyField] : $element;

			if(_heapType == MAX_HEAP)
				changeKeyOfNode(_heapSize, Number.NEGATIVE_INFINITY);
			else
				changeKeyOfNode(_heapSize, Number.POSITIVE_INFINITY);
			
			heapUpdateKeyOfNode(heapSize, key);
		}

		/*
		HEAPSORT(A)
		1 BUILD-MAX-HEAP(A)
		2 for i ← length[A] downto 2
		3    do exchange A[1] ↔ A[i]
			4       heap-size[A] ← heap-size[A] - 1
			5       MAX-HEAPIFY(A, 1)
			*/
		/**
		 * sort the heap
		 */
		public function heapSort():void
		{
			if(_isHeap == false)
				buildHeap();
			
			for(var ix:int = _A.length; ix >= 2; ix--) {
				swap(1, ix);
				heapSize -= 1;
				heapify(1)
			}
			
			// a sorted array is a heap, so let's maintain it
			_A = _A.reverse();
			heapSize = _A.length;
		}

		/*
		BUILD-MAX-HEAP(A)
		1  heap-size[A] ← length[A]
		2  for i ← ⌊length[A]/2⌋ downto 1
		3       do MAX-HEAPIFY(A, i)
			*/
		
		/**
		 * Builds the heap from the set A. this is the optimal way to 
		 * build - complexity is O(n)
		 */
		public function buildHeap():void
		{
			_heapSize = _A.length;
			for(var ix:int = Math.floor(_A.length/2); ix >= 1; ix--)
				heapify(ix);
			_isHeap = true;
		}

		/**
		 * @return The element with max/min key
		 */
		public function heapRoot():Object
		{
			if(_A.length == 0)
				return null;
			return _A[0];
		}
		
		/*
		
		MAX-HEAPIFY(A, i)
		1 l ← LEFT(i)
		2 r ← RIGHT(i)
		3 if l ≤ heap-size[A] and A[l] > A[i]
		4    then largest ← l
		5    else largest ← i
		6 if r ≤ heap-size[A] and A[r] > A[largest]
		7    then largest ← r
		8 if largest ≠ i
		9    then exchange A[i] ↔ A[largest]
		10         MAX-HEAPIFY(A, largest)
		
		
		*/
		
		/**
		 * maintaing the heap property, assumes the child trees are heaps themselves
		 */
		protected function heapify($index:uint):void
		{
			if($index == 0)
				throw new Error("index must be non zero: [1..n]");
			
			var largest:uint;
			var l:uint = left($index);
			var r:uint = right($index);

			if(_heapType == MAX_HEAP)
			{
				if((l <= heapSize) && (keyOfNode(l) > keyOfNode($index) ))
					largest = l;
				else
					largest = $index;
				
				if((r <= heapSize) && (keyOfNode(r) > keyOfNode(largest) ))
					largest = r;
			}
			else if(_heapType == MIN_HEAP)
			{
				if((l <= heapSize) && (keyOfNode(l) < keyOfNode($index) ))
					largest = l;
				else
					largest = $index;
				
				if((r <= heapSize) && (keyOfNode(r) < keyOfNode(largest) ))
					largest = r;
			}
			
			if(largest != $index) {
				swap($index, largest);
				heapify(largest);
			}
		}
		
		/**
		 * swap two elements by indices
		 */
		protected function swap($ind1:uint, $ind2:uint):void
		{
			if(($ind1 == 0) || ($ind2 == 0))
				throw new Error("index must be non zero: [1..n]");
			var temp:	Object 	= _A[$ind1 - 1];
			_A[$ind1 - 1] 		= _A[$ind2 - 1];
			_A[$ind2 - 1] 		= temp;
		}
		
		/**
		 * use it only as an interface to map [1..n] to [0..n-1] array
		 * @param $index index of node [1..n]
		 * 
		 */
		private function changeKeyOfNode($index:uint, $newKey:Object):void
		{
			if($index == 0)
				throw new Error("index must be non zero: [1..n]");
			
			if(_keyField != null)
				_A[$index - 1][_keyField] = $newKey;
			else {
				_A[$index - 1] = $newKey;
			}
			trace();
		}
		
		/**
		 * get key of node index [1..n]
		 */
		public function keyOfNode($index:uint):Object
		{
			if($index == 0)
				throw new Error("index must be non zero: [1..n]");
			if(_keyField != null)
				return _A[$index - 1][_keyField];
			return _A[$index - 1];
		}
		
		/**
		 * @param $index the node index [1..n]
		 * @return The node 
		 */
		public function getNode($index:uint):Object
		{
			if($index == 0)
				throw new Error("index must be non zero: [1..n]");
			return _A[$index - 1];
		}
		
		/**
		 * get parent index of node with index $index
		 */
		protected function parent($index:uint):uint
		{
			if($index == 0)
				throw new Error("index must be non zero: [1..n]");
			return Math.floor($index/2);
		}
		
		/**
		 * get left child index of node with index $index
		 */
		protected function left($index:uint):uint
		{
			if($index == 0)
				throw new Error("index must be non zero: [1..n]");
			return 2*$index;
		}
		
		/**
		 * get right child index of node with index $index
		 */
		protected function right($index:uint):uint
		{
			if($index == 0)
				throw new Error("index must be non zero: [1..n]");
			return 2*$index + 1;
		}
		
		public function get heapSize():						uint						{	return _heapSize;		}
		public function set heapSize(value:uint):	void						{	_heapSize = value;	}
		
		public function get A():									Vector.<Object>	{	return _A;					}
		
	}
}