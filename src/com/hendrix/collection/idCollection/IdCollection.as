package com.hendrix.collection.idCollection
{
	import flash.utils.Dictionary;

	public class IdCollection
	{
		protected var _dic: Dictionary;
		protected var _vec:	Vector.<Object>;
		
		protected var _idField:	String;
		
		public function IdCollection($idField: String = "id")
		{
			_dic	= new Dictionary(false);
			_vec	= new Vector.<Object>;
			
			_idField = $idField;
		}
		
		public function addNew(id: String, cls: Class): Object
		{
			if (_dic[id] !== undefined)
				return null;

			var obj: Object = new cls();
			obj[_idField] = id;
			
			if (add(obj, false) > 0)
				return obj;
			else
				return null;
		}
		
		public function add(item: Object, errorOnExistence: Boolean = true): int
		{
			// make sure id key is unique
			var id: String = item[_idField];
			if (_dic[id] !== undefined) {
				if (errorOnExistence)
					throw new Error('There is already an item with an id of : ', id);
				return -1;
			}
			
			_dic[id] = item;
			return _vec.push(item) - 1;
		}
		
		public function insert(item: Object, $index: int, checkExistence: Boolean = true): int
		{
			// make sure id key is unique
			var id: String = item[_idField];
			if (checkExistence && (_dic[id] !== undefined))
				return -1;
			
			// Make sure $index is valid
//			if (($index < 0) || ($index > _vec.length-1))
//				return -2;
			
			_vec.splice($index, 0, item);
			_dic[id] = item;
			
			return _vec.length - 1;
		}
		
		public function getById(id: String): Object
		{
			return _dic[id]; 
		}
		
		public function has(item: Object): Boolean
		{
			var id: String = item[_idField];
			return (_dic[id] !== undefined);
		}
		
		public function hasById(id: String): Boolean
		{
			return (_dic[id] !== undefined);			
		}
		
		public function remove(item: Object): Boolean
		{
			var id: String = item[_idField];
			var exists: Boolean = (_dic[id] !== undefined);
			
			if (exists) {
				delete _dic[id];
				_vec.splice(_vec.indexOf(item), 1);
			}
			
			return exists; 
		}
		
		public function removeById(id: String): Boolean
		{
			var exists: Boolean = (_dic[id] !== undefined);
			
			if (exists) {
				var item: Object = _dic[id];
				delete _dic[id];
				_vec.splice(_vec.indexOf(item), 1);
			}
			
			return exists; 
		}
		
		public function removeByIndex($ix:uint):Object
		{
			var res:Object = _vec[$ix];
			
			if (_vec[$ix]) {
				delete _dic[_vec[$ix].id];
				_vec.splice($ix, 1);
			}
			
			return res;
		}

		public function removeAll(): void
		{
			var id: String;
			for (var ix: uint = 0; ix < _vec.length; ix++)
			{
				id = _vec[ix][_idField];
				delete _dic[id];
			}
			_vec.length = 0;
		}
		
		public function replace(item: Object, newItem: Object): Boolean
		{
			var oid: String = item[_idField];
			var nid: String = newItem[_idField];
			var exists: Boolean = (_dic[oid] !== undefined);
			if (exists == false)
				return false;
			
			var ix: uint = _vec.indexOf(item);
			_vec[ix] = newItem;
			
			delete _dic[oid];
			_dic[nid] = newItem;
			
			return true;
		}
		
		public function updateItemId(item: Object, newId: String): void
		{
			var id: String = item[_idField];
			delete _dic[id];
			_dic[newId] = item;
		}
		
		public function get vec(): Vector.<Object> {
			return _vec;
		}
		
		public function get count(): uint {
			return _vec.length;
		}
		
		public function get idField(): String {
			return _idField;
		}
		public function set idField(value: String): void {
			_idField = value;
		}

		public function get dic():Dictionary
		{
			return _dic;
		}

	}
}