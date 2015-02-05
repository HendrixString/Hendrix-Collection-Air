package com.hendrix.collection.cache.core.types
{ 
  import com.hendrix.collection.cache.core.interfaces.ICachable;
  
  /**
   * the base class 
   * @author Tomer Shalev
   * 
   */
  public class CachedItem implements ICachable
  {
    private var _data:          Object    = null;
    private var _id:            String    = null;
    private var _disposeMethod: Function  = null;
    
    public function CachedItem()
    {
    }
    
    public function dispose():void
    {
      if(_disposeMethod == dispose)
        throw new Error();
      
      if(_disposeMethod) {
        _disposeMethod();
        trace("disposeddddddddddddddddddddddddddddddddddddddddddddddddddddddddd")
      }
      
      _data           = null;
      _id             = null;
      _disposeMethod  = null;
    }
    
    public function get data():                         Object    { return _data;           }
    public function set data(value:Object):             void      { _data = value;          }
    
    public function get id():                           String    { return _id;             }
    public function set id(value:String):               void      { _id = value;            }
    
    public function get disposeMethod():                Function  { return _disposeMethod;  }
    public function set disposeMethod(value:Function):  void      { _disposeMethod = value; }
    
  }
}