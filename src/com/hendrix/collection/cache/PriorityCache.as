package com.hendrix.collection.cache
{
	import com.hendrix.collection.idCollection.IdCollection;

	public class PriorityCache
	{
		private var _cacheSize:uint	=	1;
		
		private var _cache:IdCollection = null;
		
		
		public function PriorityCache()
		{
			_cache = new IdCollection();
		}

		public function get cacheSize():uint	{	return _cacheSize;	}
		public function set cacheSize(value:uint):void		{	_cacheSize = value;	}

	}
}