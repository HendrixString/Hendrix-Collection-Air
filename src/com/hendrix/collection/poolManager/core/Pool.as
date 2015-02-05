package com.hendrix.collection.poolManager.core
{
  
  import com.hendrix.collection.common.interfaces.IId;
  
  import flash.utils.getQualifiedClassName;
  
  /**
   * a simple pool
   * @author Tomer Shalev
   */
  public class Pool implements IId
  {
    public static var POOL_READY:     String          = "POOL_READY";
    public static var POOL_NOT_READY: String          = "POOL_NOT_READY";
    
    private var _id:                  String          = null;
    
    private var _classOfPool:         Class           = null;
    private var _className:           String          = null;
    
    private var _poolFactory:         Function        = null;
    
    private var _itemsAll:            Vector.<Object> = null;
    private var _itemsFree:           Vector.<Object> = null;
    //private var _itemsUsed:           Vector.<Object> = null;
    private var _itemsCount:          uint            = 0;
    
    private var _status:              String          = null;
    
    public var onPoolReady:           Function        = null;
    
    /**
     * a simple pool 
     */
    public function Pool()
    {
      _status   = POOL_NOT_READY;     
    }
    
    /**
     * init the pool 
     */
    public function initPool():void
    {
      if(_status == POOL_READY)
        return;
      
      _itemsFree            = new Vector.<Object>();
      _itemsAll             = new Vector.<Object>(_itemsCount, true);
      //_itemsUsed            = new Vector.<Object>();
      
      var item: Object      = null;
      
      for(var ix: uint = 0; ix < _itemsCount; ix++)
      {
        item                = (_poolFactory is Function) ? _poolFactory() : new _classOfPool();
        _itemsFree[ix]      = item;
        _itemsAll[ix]       = item;
      }
      
      item                  = null;
      
      ready();
    }
    
    /**
     * release a used item 
     * @param $item the item to release.
     */
    public function releaseItem($item:Object):void
    {
      if(_itemsFree.indexOf($item) == -1)
        _itemsFree.push($item);
    }
    
    /**
     * it's the user responsibility to release the item later 
     * @return the item, NULL if no items left
     */
    public function requestItem():Object
    {
      if(_itemsFree == null)
        return null;
      return _itemsFree.pop();
    }
    
    /**
     * it is the programmer responsibility to dispose all of the
     * pooled items. this is beacuse a pool is very generic and do not rely on special
     * interfaces for the items for the sake of simplicity. therefore items that have been removed from
     * the pool are no longer recorded inside it, which means programmer needs to keep track of it's refs.
     * use <code>this.itemsAll</code> to get a vector of the items so you can dispose them manually.
     */
    public function dispose():void
    {
      _classOfPool      = null;
      
      _itemsFree.length = 0;
      
      for(var ix:uint = 0 ; ix < _itemsAll.length; ix++) {
        _itemsAll[ix]   = null; 
      }
      
      _itemsAll         = null;
      
      //_itemsUsed.length = 0
      _itemsFree        = null;
      _poolFactory      = null;
      _status           = POOL_NOT_READY
      onPoolReady       = null;
    }
    
    /**
     * force release of all items. this is not a stable operation, since
     * some items can be in operation in background. 
     */
    public function releaseAllItems():void
    {
      for(var ix:uint = 0; ix < _itemsAll.length; ix++) {
        _itemsFree[ix] = _itemsAll[ix];
      }
    }
    
    /**
     * a helper method for IPoolItem inteface for aSync objects.
     */
    protected function ready():void
    {
      _status = POOL_READY;
      if(onPoolReady is Function)
        onPoolReady();
    }
    
    public function get classPool():                  Class     { return _classOfPool;  }
    public function set classPool(value:Class):       void            
    { 
      _classOfPool  = value;
      _className    = getQualifiedClassName(_classOfPool);
      trace(_className);
    }
    
    public function get poolFactory():                Function  { return _poolFactory;  }
    public function set poolFactory(value:Function):  void      { _poolFactory = value; }
    
    public function get itemsFree():                      Vector.<Object> 
    {
      if(_status == POOL_NOT_READY) {
        throw new Error("Pool Error: not ready, did you call initPool ?");
        return null;
      }
      
      return _itemsFree;        
    }
    
    public function get itemsCount():                 uint            { return _itemsCount;   }
    public function set itemsCount(value:uint):       void            { _itemsCount = value;  }
    
    public function get className():                  String          { return _className;    }
    public function set className(value:String):      void            { _className = value;   }
    
    /**
     * get all items so you can dispose them if you like 
     */
    public function get itemsAll():                   Vector.<Object> { return _itemsAll;     }
    
    public function get status():                     String          { return _status;       }
    
    public function get id():                         String          { return _id;           }
    public function set id(value:String):             void            { _id = value;          }
  }
}