package com.hendrix.collection.queue
{
  import com.hendrix.collection.binaryHeap.BinaryHeap;
  
  public class PriorityQueue implements IQueue
  {
    private var _heap:      BinaryHeap  = null;
    private var _queueSize: uint          = 0;
    
    /**
     * A Priority Queue data structure
     * @param $priorityField The field indicating the priority key
     * @param $heapType MAX_HEAP/MIN_HEAP indicating max/min priority queue
     * @author Tomer Shalev
     */
    public function PriorityQueue($priorityField:String=null, $heapType:String="MAX_HEAP")
    {
      _heap = new BinaryHeap($priorityField, $heapType);
    }
    
    public function get queueSize():uint
    {
      return _heap.A.length;
    }
    
    public function dispose():void
    {
      _heap.dispose();
      _heap = null;
    }
    
    public function clear():void
    {
      _heap.reset();
      _queueSize = 0;
    }
    
    public function getQueue($sorted:Boolean = false):Object
    {
      if($sorted)
        _heap.heapSort();
      return _heap.A;
    }
    
    /**
     * Enqueue all objects and build the priority queue,
     * better performance for building at O(n) 
     * @param args Vector of Objects, Object etc..
     * 
     */
    public function enqueueAllAndBuild(...args):void
    {
      _heap.initElements(args);
      _heap.buildHeap();
    }
    
    /**
     * enqueue one at a time and maintain the priority queue.
     * If you use it to build from scratch then performence is O(nlogn) 
     * @param args Vector of Objects, Object etc..
     */
    public function enqueue(...args):void
    {
      for(var ix:uint = 0; ix < args.length; ix++)
        _heap.heapInsert(args[ix]);
    }
    
    /**
     *  
     * @return The maximum/minimum element in the queue 
     * 
     */
    public function highestElement():Object
    {
      return _heap.heapRoot();
    }
    
    /**
     * Extracts the minimum/maximum element in the queue
     * @return The maximum/minimum element in the queue 
     * 
     */
    public function extractHighestElement():Object
    {
      var max:Object = _heap.heapExtractRoot();
      if(max)
        var a:Object =  _heap.keyField ? max[_heap.keyField] : max;
      trace("extracted:  " + a);
      return max;
    }
    
    /**
     * update key of item by it's index 
     * @param $index the index of the item
     * @param $key the new priority
     */
    public function updatePriorityOfItem($index:uint, $priority:Object):void
    {
      _heap.heapUpdateKeyOfNode($index, $priority);
    }
    
  }
}