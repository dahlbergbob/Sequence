/**
 * User: Bob Dahlberg
 * Date: 2012-07-06
 * Time: 15:11
 */
package com.boblu.sequense
{
	public interface ITask
	{
		/**
		 * Executes the task
		 */
		function execute():void;
		
		/**
		 * Used when no one is interested in the task and it should clean it's references.
		 */
		function clean():void;
	}
}
