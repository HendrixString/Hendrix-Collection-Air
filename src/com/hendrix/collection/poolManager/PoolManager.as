package com.hendrix.collection.poolManager
{
  import com.hendrix.collection.idCollection.IdCollection;
  import com.hendrix.collection.poolManager.core.Pool;
  
  /**
   * a Pool Manager
   * @author Tomer Shalev
   * 
   */
  public class PoolManager
  {
    private static var _instance:     PoolManager   = null;
    
    protected var _poolItems:         IdCollection  = null;
    
    /**
     * a Pool Manager
     */
    public function PoolManager()
    {
      if(_instance  !=  null)
        throw new Error("Singleton!");
      
      /** First instanciation */
      _instance         = this;
      
      _poolItems        = new IdCollection("id");
    }
    
    public static function get instance():PoolManager
    {
      if (_instance ==  null)
        _instance = new PoolManager();
      
      return _instance;
    }
    
    /**
     * register a new pool, if the pool exists you will get it's reference 
     * @param $id the id of the pool
     * @param $clsItem the Class of an item
     * @param $classFactory a factory method to create the items, optional
     * @param $count the requested number of items
     * @return Pool
     */
    public function registerNewPool($id:String, $clsItem: Class, $classFactory:Function = null, $count:uint = 1):Pool
    {
      var pool: Pool    = getPool($id);
      
      if(pool)
        return pool;
      
      pool              = new Pool();
      
      pool.id           = $id;
      pool.classPool    = $clsItem;
      pool.poolFactory  = $classFactory;
      pool.itemsCount   = $count;
      
      _poolItems.add(pool);
      
      return pool;
    }
    
    /**
     * get a pool by id, else get NULL 
     */
    public function getPool($id:String):Pool
    {
      return _poolItems.getById($id) as Pool;
    }
    
    /**
     * dispose a pool, it will only kill references, so make sure to use pool.itemsAll to get a vector of items, dispose them
     * and then using this.disposePool(..).  
     */
    public function disposePool($id:String):void
    {     
      var pool: Pool  = getPool($id);
      
      pool.dispose();
      
      _poolItems.removeById($id);
      
      pool            = null;
    }
    
  }
}