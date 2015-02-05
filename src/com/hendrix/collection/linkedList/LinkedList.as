package com.hendrix.collection.linkedList
{
  /**
   * A circular, doubly linked list with a sentinel 
   * @author Tomer Shalev
   */
  public class LinkedList
  {
    public static var SENTINAL_NODE:  String          = "SENTINAL_NODE";
    
    private var _sentinal:            LinkedListNode  = null;
    private var _length:              uint            = 0;
    
    /**
     * A circular, doubly linked list with a sentinel 
     * @author Tomer Shalev
     */
    public function LinkedList()
    {
      _sentinal= new LinkedListNode(SENTINAL_NODE);
      _sentinal.nextNode = _sentinal.prevNode = _sentinal; 
    }
    
    public function reset():void
    {
      var node:LinkedListNode = headNode;
      
      while(node != null)
      {
        node.dispose();
        node.prevNode = null;
        node = node.nextNode;
      }
      
      _sentinal= new LinkedListNode(SENTINAL_NODE);
      _sentinal.nextNode = _sentinal.prevNode = _sentinal; 
    }
    
    /*
    LIST-SEARCH(L, k)
    1  x ← head[L]
    2  while x ≠ NIL and key[x] ≠ k
    3      do x ← next[x]
    4  return x
    */
    /**
     * search the linked list and return the node by it's data object, O(n) operation 
     * @param $key the data object that it stores
     * @return LinkedListNode
     */
    public function searchNode($key:Object):LinkedListNode
    {
      var node:LinkedListNode = headNode;
      while((node != null) && (node.data!=$key))
      {
        node = node.nextNode;
      }
      return node;
    }
    
    /**
     * insert a node at a given index, ~($index) operation becasue of the iterations
     * @param $index the index order where the node to be inserted
     * @param $x the node to be inserted
     * @return inserted node, null if not successful
     */
    public function getNodeAt($index:uint):LinkedListNode
    {
      var iNode:LinkedListNode = headNode;
      for(var ix:uint = 0; ix < $index; ix++) {
        if(iNode == null)
          return null;
        iNode = iNode.nextNode;
      }
      
      return iNode;
    }
    
    /**
     * insert a node at a given index, O(n) operation at worst becasue of the iterations
     * @param $index the index order where the node to be inserted
     * @param $x the node to be inserted
     * @return inserted node, null if not successful
     */
    public function insertNodeAt($index:uint, $x:Object):LinkedListNode
    {
      var iNode:LinkedListNode = headNode;
      for(var ix:uint = 0; ix < $index; ix++) {
        if(iNode == null)
          return null;
        iNode = iNode.nextNode;
      }
      
      return insertNodeBefore($x, iNode);
    }
    
    /**
     * insert an object before another node, O(1) operation
     * @param $x the object to insert
     * @param $beforeNode the node to insert the object before
     * @return the inserted node
     */
    public function insertNodeBefore($x:Object, $beforeNode:LinkedListNode = null):LinkedListNode
    {
      var node:LinkedListNode = ($x is LinkedListNode) ? ($x as LinkedListNode) : new LinkedListNode($x);
      
      node.nextNode           = $beforeNode;
      node.prevNode           = $beforeNode.prevNode;
      $beforeNode.prevNode    = node;
      node.prevNode.nextNode  = node
      
      _length                += 1;
      
      return node;
    }
    
    /**
     * insert an object after another node, O(1) operation
     * @param $x the object to insert
     * @param $beforeNode the node to insert the object after
     * @return the inserted node
     */
    public function insertNodeAfter($x:Object, $afterNode:LinkedListNode = null):LinkedListNode
    {
      var node:LinkedListNode = ($x is LinkedListNode) ? ($x as LinkedListNode) : new LinkedListNode($x);
      
      node.nextNode           = $afterNode.nextNode;
      $afterNode.nextNode     = node;
      node.nextNode.prevNode  = node;
      node.prevNode           = $afterNode;
      
      _length                += 1;
      
      return node;
    }
    
    /*
    LIST-INSERT(L, x)
    1  next[x] ← head[L]
    2  if head[L] ≠ NIL
    3     then prev[head[L]] ← x
    4  head[L] ← x
    5  prev[x] ← NIL
    */
    /**
     * insert a node at the head, O(1) operation 
     * @param $x the object to insert
     * @return the node
     */
    public function insertNodeAtHead($x:Object):LinkedListNode
    {
      return insertNodeBefore(headNode);
    }
    
    /**
     * insert a node at the tail, O(1) operation 
     * @param $x the object to insert
     * @return the node
     */
    public function insertNodeAtTail($x:Object):LinkedListNode
    {
      return insertNodeAfter($x, tailNode);
    }
    
    /*
    LIST-DELETE(L, x)
    1  if prev[x] ≠ NIL
    2      then next[prev[x]] ← next[x]
    3      else head[L] ← next[x]
    4  if next[x] ≠ NIL
    5      then prev[next[x]] ← prev[x]
    */
    /**
     * delete a node and return it's data, O(1) operation 
     * @param $x the node to be deleted
     * @return the data of the node
     * 
     */
    public function deleteNode($x:LinkedListNode):Object
    {
      if($x == null)
        return null;
      
      $x.prevNode.nextNode = $x.nextNode;
      $x.nextNode.prevNode = $x.prevNode;
      
      _length -= 1;
      
      // save reference to node's data and dispose the node
      var data:Object = $x.data;
      
      $x.dispose();
      
      return data;
    }
    
    public function get tailNode():   LinkedListNode  { return _sentinal.prevNode;    }
    
    public function get headNode():   LinkedListNode  { return _sentinal.nextNode;    }
    
    public function get length():     uint            { return _length;               }
    
  }
}