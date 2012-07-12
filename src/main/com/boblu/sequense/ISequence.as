/**
 * User: Bob Dahlberg
 * Date: 2012-06-21
 * Time: 08:36
 */
package com.boblu.sequense
{
	public interface ISequence
	{
		/**
		 * Adds a simple call to be executed in the sequence
		 * @param call			The function to call
		 * @param parameters	0 to N parameters to delegate to the call
		 */
		function addCall( call:Function, ...parameters ):void;
		
		/**
		 * Adds a task to execute in the sequence
		 * @param task			The ITask to execute.
		 * @param concurrent	Flag if the task can be run concurrently with the previous task or wait for it to finish. Default false.
		 */
		function addTask( task:ITask, concurrent:Boolean = false ):void;

		/**
		 * Holds the sequence at the current execution and waits for the sequence to be released before executing further
		 */
		function hold():void;

		/**
		 * Releases the current sequence to execute any remaining tasks
		 */
		function release():void;
	}
}
