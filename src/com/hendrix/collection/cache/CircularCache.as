package com.hendrix.collection.cache
{
  import com.hendrix.collection.cache.core.interfaces.ICachable;
  import com.hendrix.collection.cache.core.interfaces.ICache;
  import com.hendrix.collection.cache.core.types.CachedItem;
  
  import flash.utils.Dictionary;
  
  /**
   * a simple circular cache
   * @author Tomer Shalev
   */
  public class CircularCache implements ICache
  {
    private var _cacheSize:         uint                    = 1;
    
    private var _currentIndex:      uint                    = 0;
    
    protected var _cachedItems:     Vector.<ICachable>      = null;
    protected var _cachedItemsMap:  Dictionary              = null;
    
    
    /**
     * a simple circular cache
     * @param $cacheSize the requested cache size
     */
    public function CircularCache($cacheSize:uint = 1)
    {
      _cacheSize          = $cacheSize;
      
      _cachedItems        = new Vector.<ICachable>(_cacheSize, true);
      
      for(var ix:uint = 0; ix < _cachedItems.length; ix++) {
        _cachedItems[ix]  = new CachedItem();
      }
      
      _cachedItemsMap     = new Dictionary(false);
    }
    
    /**
     * @inheritDoc 
     */
    public function cacheItemWith($id:String, $data:Object, $disposeMethod:Function = null):void
    {
      if(_cachedItemsMap[$id] !== undefined)
        return;
      
      _currentIndex                     = _currentIndex % _cacheSize;
      
      disposeItemByIndex(_currentIndex);
      
      //dispose residual item
      var itemInPlace: ICachable        = _cachedItems[_currentIndex];
      
      itemInPlace.data                  = $data;
      itemInPlace.id                    = $id;
      itemInPlace.disposeMethod         = $disposeMethod;
      
      _cachedItemsMap[$id]              = _currentIndex;
      //_cachedItems[_currentIndex]       = itemInPlace;
      _currentIndex                    += 1;
    }
    
    /**
     * @inheritDoc 
     */
    public function cacheItem($item:ICachable):void
    {
      if(_cachedItemsMap[$item.id] !== undefined)
        return;
      
      _currentIndex                     = _currentIndex % _cacheSize;
      
      disposeItemByIndex(_currentIndex);
      
      //
      _cachedItemsMap[$item.id]         = _currentIndex;
      _cachedItems[_currentIndex]       = $item;
      _currentIndex                    += 1;
    }
    
    /**
     * @inheritDoc 
     */
    public function disposeItemById($id:String):void
    {
      if(_cachedItemsMap[$id] !== undefined) {
        disposeItemByIndex(_cachedItemsMap[$id] as uint);
      }
    }
    
    /**
     * @inheritDoc 
     */
    public function disposeItemByIndex($index:uint):void
    {
      var item:ICachable        =  _cachedItems[$index];
      delete _cachedItemsMap[item.id];
      
      item.dispose();
      
      item                      = null;
    }
    
    /**
     * @inheritDoc 
     */
    public function getCachedItemById($id:String):ICachable
    {
      var obj:Object = _cachedItemsMap[$id];
      if(_cachedItemsMap[$id] !== undefined)
        return _cachedItems[_cachedItemsMap[$id]] as ICachable;
      return null;
    }
    
    public function clean():void
    {
      for(var ix:uint = 0; ix < _cachedItems.length; ix++) {
        delete _cachedItemsMap[_cachedItems[ix].id];
        _cachedItems[ix].dispose();
      }
    }
    
    /**
     * @inheritDoc 
     */
    public function dispose():void
    {
      for(var ix:uint = 0; ix < _cachedItems.length; ix++) {
        delete _cachedItemsMap[_cachedItems[ix].id];
        _cachedItems[ix].dispose();
        _cachedItems[ix]  = null;
      }
      
      _cachedItemsMap    = null;
      _cachedItems       = null;
    }
    
    /**
     * @inheritDoc 
     */
    public function get cacheSize():            uint    { return _cacheSize;  }
    public function set cacheSize(value:uint):  void    { _cacheSize = value; }
    
  }
}