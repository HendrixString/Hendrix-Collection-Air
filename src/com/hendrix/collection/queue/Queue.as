package com.hendrix.collection.queue
{
	import com.hendrix.collection.linkedList.LinkedList;

	public class Queue implements IQueue
	{
		private var _queue:			LinkedList				=	null;
		private var _queueSize:	uint 							= 0;

		/**
		 * A regular Queue data structure, backed up by a linked list.
		 * might be faster with an Array implementation and two indices indicating first and last element.
		 * @author Tomer Shalev
		 */
		public function Queue()
		{
			_queue = new LinkedList();
		}
		
		public function dispose():void
		{
			_queue = null;
		}
		
		public function clear():void
		{
			_queueSize = 0;
			_queue.reset();
		}
		
		/**
		 * @inheritDoc
		 */
		public function get queueSize():uint
		{
			return _queue.length;
		}
		
		/**
		 * @inheritDoc
		 */
		public function getQueue($params:Boolean=false):Object
		{
			return _queue;
		}
		
		/**
		 * @inheritDoc
		 */
		public function enqueue(...args):void
		{
			for(var ix:uint = 0; ix < args.length; ix++)
				_queue.insertNodeAtTail(args[ix]);
		}
		
		/**
		 * @inheritDoc
		 */
		public function highestElement():Object
		{
			return _queue.headNode.data;
		}
		
		/**
		 * @inheritDoc
		 */
		public function extractHighestElement():Object
		{
			return _queue.deleteNode(_queue.headNode);
		}
	}
}