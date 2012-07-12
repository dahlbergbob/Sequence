/**
 * User: Bob Dahlberg
 * Date: 2012-06-21
 * Time: 08:57
 */
package com.boblu.sequense
{
	public interface IDelegate
	{
		/** 
		 * Holds the IDelegate from executing further and from reporting that its done.
		 */
		function hold():void;

		/**
		 * Releases an hold IDelegate to make it resume its agenda. 
		 */
		function release():void;
	}
}
