package com.hendrix.collection.SetData
{ 
  import com.hendrix.collection.common.interfaces.IDisposable;
  
  import flash.utils.Dictionary;
  
  /**
   * a common implementation of a Set data structure
   * @author Tomer Shalev
   */
  public class Set implements IDisposable
  {
    private var _mapElementsMembership: Dictionary      = null;
    private var _vecElements:           Vector.<Object> = null;
    
    /**
     * a common implementation of a Set data structure
     */
    public function Set()
    {
      _mapElementsMembership  = new Dictionary();
      _vecElements            = new Vector.<Object>();
    }
    
    public function addElement(element:Object):Boolean
    {
      if(_mapElementsMembership[element] !== undefined)
        return false;
      
      _mapElementsMembership[element] = _vecElements.push(element);
      
      return true;
    }
    
    public function addElements(...elements):void
    {
      var elementsCount:uint = elements.length;
      
      for(var ix:uint = 0; ix < elementsCount; ix++)
      {
        addElement(elements[ix]);
      }
    }
    
    public function union($set:Set):void
    {
      var setElementsCount:uint = $set.numElements;
      
      for(var ix:uint = 0; ix < setElementsCount; ix++)
      {
        addElement($set.vecElements[ix]);
      }
    }
    
    public function removeElement(element:Object):Boolean
    {
      if(_mapElementsMembership[element] === undefined)
        return false;
      
      var index:uint = _mapElementsMembership[element];
      _vecElements.splice(index, 1);
      
      return true;
    }
    
    public function isMember(element:Object):Boolean
    {
      return (_mapElementsMembership[element] === undefined) ? false : true;
    }
    
    public function get vecElements():Vector.<Object>
    {
      return _vecElements;
    }
    
    public function get numElements():uint
    {
      return _vecElements.length;
    }
    
    public function get randomElement():Object
    {
      return _vecElements[Math.floor(_vecElements.length*Math.random())];
    }
    
    public function dispose():void
    {
      _vecElements.length     = 0;
      _vecElements            = null;
      
      for (var key:Object in _mapElementsMembership) 
        delete _mapElementsMembership[key];
      
      _mapElementsMembership  = null;
    }
    
    
  }
}