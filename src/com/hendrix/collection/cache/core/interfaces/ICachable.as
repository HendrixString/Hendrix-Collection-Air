package com.hendrix.collection.cache.core.interfaces
{

	public interface ICachable extends IIdDisposable
	{
		function get data():            							Object;
		function set data(value:Object):  						void	;

		function get disposeMethod():            			Function;
		function set disposeMethod(value:Function):  	void	;

	}
}