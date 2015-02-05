package com.hendrix.collection.linkedList
{
  public class LinkedListNode
  {
    private var _data:      Object          = null;
    private var _nextNode:  LinkedListNode  = null;
    private var _prevNode:  LinkedListNode  = null;
    
    /**
     * A node for linked list
     * @param $data the data the node will store, can also be thought of as a key
     * @author Tomer Shalev 
     */
    public function LinkedListNode($data:Object)
    {
      _data = $data;
    }
    
    public function dispose():void
    {
      _data     = null;
      _prevNode = null;
      _nextNode = null;
    }
    
    public function get prevNode():                     LinkedListNode  { return _prevNode;   }
    public function set prevNode(value:LinkedListNode): void            { _prevNode = value;  }
    
    public function get nextNode():                     LinkedListNode  { return _nextNode;   }
    public function set nextNode(value:LinkedListNode): void            { _nextNode = value;  }
    
    public function get data():                         Object          { return _data;       }
    public function set data(value:Object):             void            { _data = value;      }
    
  }
}