package com.hendrix.collection.cache.core.interfaces
{
  import com.hendrix.collection.common.interfaces.IDisposable;
  
  
  /**
   * common interface for cachable items
   * @author Tomer Shalev
   */
  public interface ICache extends IDisposable
  {
    /**
     * caches an item that implements <code>ICachable</code> interface
     * @param $item
     * 
     */
    function cacheItem($item:ICachable):void;
    
    /**
     * IN-PLACE memory, uses the cache pool, superior memory usage.
     * @param $id id of the item
     * @param $data the data
     * @param $disposeMethod the dispose method of the object data, for example BitmapData Class has BitmapData.dispose();
     */
    function cacheItemWith($id:String, $data:Object, $disposeMethod:Function = null):void;
    
    /**
     * get a cached item by ID
     * @return NULL if absent, otherwise returns the item 
     * 
     */
    function getCachedItemById($id:String):ICachable
    
    /**
     * clean the cache 
     */
    function clean():void;
    
    /**
     * dispose item
     */
    function disposeItemById($id:String):void;
    function disposeItemByIndex($index:uint):void;
    
    /**
     * the cache size 
     */
    function get cacheSize():            uint   ;
    function set cacheSize(value:uint):  void   ;
    
  }
}