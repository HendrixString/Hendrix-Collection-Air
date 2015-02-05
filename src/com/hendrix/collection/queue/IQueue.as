package com.hendrix.collection.queue
{
	public interface IQueue
	{
		/**
		 * @return The queue Size
		 */
		function get queueSize():uint;
		
		/**
		 * get the queue 
		 * @param $params Extra parameters for other implementations.
		 * @return The Queue
		 */		
		function getQueue($params:Boolean = false):Object;

		/**
		 * Enqueue new elements 
		 * @param args Object, Vector of Objects
		 */
		function enqueue(...args):void;

		/**
		 * peek at next element 
		 * @return the next element
		 */
		function highestElement():Object;
		
		/**
		 * Extract and get the next element 
		 * @return The next element
		 */		
		function extractHighestElement():Object;
		
		/**
		 * dispose the ds 
		 */
		function dispose():void;
		
		/**
		 * clear the ds, emptying
		 */
		function clear():void;
	}
}